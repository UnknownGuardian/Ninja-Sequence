package  
{
	import flash.globalization.LocaleID;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Timeline extends Entity
	{
		[Embed(source = "assets/Timeline/timeline_panel.png")]private const TIMELINE_PANEL:Class;
		
		public var image:Image
		
		private var instructIndex:int = 0;
		private var slots:Vector.<TimelineSlot> = new Vector.<TimelineSlot>(20, true);
		private var lights:Vector.<TimelineSlotLight> = new Vector.<TimelineSlotLight>(20, true);
		
		private var _shouldPlay:Boolean = false;
		
		
		public var savedLevelData:String = "";
		
		public function Timeline() 
		{
			image = new Image(TIMELINE_PANEL);
			addGraphic(image);
			layer = 21;
			y = 465;
		}
		override public function added():void
		{
			world.add(new TimelineNone());
			world.add(new TimelineLeft());
			world.add(new TimelineUp());
			world.add(new TimelineRight());
			world.add(new TimelinePlay());
			world.add(new TimelineStop());
			
			for (var i:int = 0; i < 20; i++)
			{
				var s:TimelineSlot = new TimelineSlot(13 + 28 * i, 479);
				world.add(s);
				slots[i] = s;
			}
			for (var g:int = 0; g < 20; g++)
			{
				var li:TimelineSlotLight = new TimelineSlotLight(22 + 28 * g, 514);
				world.add(li);
				lights[g] = li;
			}
		}
		override public function update():void
		{
			if (Input.released(Key.SPACE))
			{
				if (isPlaying()) resetPlaying();
				else startPlaying();
			}
			if (!isPlaying())
			{
				if (Input.released(Key.LEFT)) { appendInstruction(Instruction.LEFT); }
				if (Input.released(Key.RIGHT)) { appendInstruction(Instruction.RIGHT); }
				if (Input.released(Key.UP)) { appendInstruction(Instruction.UP); }
				if (Input.released(Key.DOWN)) { appendInstruction(Instruction.NONE); }
				if (Input.released(Key.C))	{	clearAllInstructions();	}
				if (Input.released(Key.BACKSPACE)) { popInstruction(); }
				if (Input.released(Key.R)) {if(isPlaying()) resetPlaying(); }
			}

		}
		public function isPlaying():Boolean
		{
			return _shouldPlay;
		}
		public function startPlaying():void
		{
			if ((world as GameWorld).getLevelComplete().world != null) return;
			if ((world as GameWorld).getInstructions().world != null) return;
			
			var w:GameWorld = world as GameWorld;
			if (w.getCharacter().isAnimating) return;
			
			if (isPlaying())
				resetPlaying();
			
			try{
				_shouldPlay = true;
				w.getLevel().generateCollisionData();
				if ( w.getLevel() != null)
				{
					var c:Character = w.getCharacter();
					/*c.x =  w.getLevel().playerLoc.x*16;
					c.y =  w.getLevel().playerLoc.y * 16;*/
					//trace(c.world);
					//world.add(c);
				}
				
				if(w.getLevel() is EditableLevel)
					savedLevelData = w.getLevel().exportLevel(false);
				
			}
			catch (e:TypeError)
			{
				_shouldPlay = false;
				trace("[Timeline]: Character not defined on map: \n" + e.getStackTrace());
			}
		}
		public function pausePlaying():void
		{
			_shouldPlay = false;
		}
		public function resetPlaying():void
		{
			_shouldPlay = false;
			if(instructIndex != 0)
			{
				lights[instructIndex - 1].turnOff();
				instructIndex = 0;
			}
			
			var c:Character = (world as GameWorld).getCharacter();
			c.reset();
			//world.remove(c);
			
			if (savedLevelData.length > 100 && (world as GameWorld).getLevel() is EditableLevel)
			{
				(world as GameWorld).getLevel().importLevel(savedLevelData);
			}
			else
			{
				(world as GameWorld).getLevel().importLevel(Assets["LEVEL_" + Assets.LevelToBeLoaded]);
			}
			
			/*FP.screen.scale = 1;
			FP.resetCamera();*/
		}
		
		public function getSlots():Vector.<TimelineSlot>
		{
			return slots;
		}
		
		public function getInstructionAt(index:int):String
		{
			//cap, prevent errors
			if (index >= slots.length) { trace("[Timeline][getInstructionAt()] Index out of bounds: " + index + " | " + (new Error()).getStackTrace()); return ""; }
			
			//give current instruction
			return slots[index].getInstruction();
		}
		
		public function getCurrentInstruction():String
		{
			//cap, prevent errors
			if (instructIndex >= slots.length) { trace("[Timeline][getCurrentInstruction()] InstructionIndex out of bounds: " + instructIndex + " | " + (new Error()).getStackTrace()); return ""; }
			
			//grab instruction, turn light on
			var instruct:String = slots[instructIndex].getInstruction();
			lights[instructIndex].turnOn();
			
			//if possible turn old one off
			if (instructIndex > 0)
				lights[instructIndex -1].turnOff();
			
			//increment instruct index
			instructIndex++;
			
			return instruct;
		}
		
		//return true if successful
		public function appendInstruction(type:String):Boolean
		{
			if (isPlaying()) return false;
			
			if ((world as GameWorld).getLevelComplete().world != null) return false;
			if ((world as GameWorld).getInstructions().world != null) return false;
			
			var firstOpen:int = getIndexOfFirstBlank();
			if (firstOpen == -1) return false;
			
			if(type == Instruction.LEFT)
				slots[firstOpen].setToLeft();
			if(type == Instruction.RIGHT)
				slots[firstOpen].setToRight();
			if(type == Instruction.UP)
				slots[firstOpen].setToUp();
			if(type == Instruction.NONE)
				slots[firstOpen].setToNone();
			return true;
		}
		public function popInstruction():void
		{
			if (isPlaying()) return
			
			if ((world as GameWorld).getLevelComplete().world != null) return;
			if ((world as GameWorld).getInstructions().world != null) return;
			
			var firstOpen:int = getIndexOfFirstBlank();
			if (firstOpen == 0) return;
			if (firstOpen == -1) firstOpen = slots.length;
			slots[firstOpen - 1].setToBlank();
		}
		
		public function removeInstruction(slot:TimelineSlot):void
		{
			if ((world as GameWorld).getLevelComplete().world != null) return;
			if ((world as GameWorld).getInstructions().world != null) return;
			
			if (slot.getInstruction() == Instruction.BLANK) return;
			var q:int = 0;
			outer: for (q = 0; q < slots.length; q++)
			{
				//if found the slot we want to remove
				if (slots[q] == slot)
				{
					inner: for (var i:int = q; i < slots.length-1; i++)
					{
						slots[i].cloneSlot(slots[i + 1]);
					}
					slots[i].setToBlank();
					break;
				}
			}
		}
		
		public function clearAllInstructions():void
		{			
			for (var q:int = 0; q < slots.length; q++)
			{
				slots[q].setToBlank();
			}
		}
		
		public function getIndexOfFirstBlank():int
		{
			for (var q:int = 0; q < slots.length; q++)
			{
				//if blank slot, stop iteration
				if (slots[q].getInstruction() == Instruction.BLANK) return q;
			}
			return -1;
		}
		
	}

}