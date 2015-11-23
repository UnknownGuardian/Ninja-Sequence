package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TimelineSlot extends InteractiveSlotEntity
	{
		//Removed per 11-13-11 @ 9:35PM from decoupling lights + slots
		//private var _light:TimelineSlotLight;
		
		
		[Embed(source = "assets/Timeline/timeline_left.png")]private const LEFT:Class;
		[Embed(source = "assets/Timeline/timeline_none.png")]private const NONE:Class;
		[Embed(source = "assets/Timeline/timeline_right.png")]private const RIGHT:Class;
		[Embed(source="assets/Timeline/timeline_up.png")]private const UP:Class;
		private var _left:Image;
		private var _right:Image;
		private var _up:Image;
		private var _none:Image;
		
		
		public function TimelineSlot(X:Number = 0,Y:Number = 0) 
		{
			//define all possible combinations
			_left = new Image(LEFT);
			_right = new Image(RIGHT);
			_up = new Image(UP);
			_none = new Image(NONE);
			
			setToBlank();
			
			super(X, Y,  _left.width, _left.height);
			setCallback(removeSlot);
			
			/*
			var r:Number = Math.random();
			if (r < 0.25) setToLeft();
			else if (r < 0.5) setToRight();
			else if (r < 0.82) setToUp();
			else setToNone();*/
			
		}
		
		/* Removed per 11-13-11 @ 9:35PM from decoupling lights + slots
		override public function added():void
		{
			super.added();
			//create the light, set to half width - half light width, 20 below, add to world
			_light = new TimelineSlotLight(x + _left.width / 2 - 3, y + 35);
			trace(_light.x);
			world.add(_light);
		}*/
		
		public function setToLeft():void
		{
			graphic = _left;
		}
		public function setToRight():void
		{
			graphic = _right;
		}
		public function setToNone():void
		{
			graphic = _none;
		}
		public function setToUp():void
		{
			graphic = _up;
		}
		public function setToBlank():void
		{
			graphic = null;
		}
		
		/*Removed per 11-13-11 @ 9:35PM from decoupling lights + slots
		public function getLight():TimelineSlotLight
		{
			return _light;
		}*/
		
		public function getInstruction():String
		{
			if (graphic == _left) return Instruction.LEFT;
			if (graphic == _right) return Instruction.RIGHT;
			if (graphic == _up) return Instruction.UP;
			if (graphic == _none) return Instruction.NONE;
			return Instruction.BLANK;
		}
		
		public function cloneSlot(slot:TimelineSlot):void
		{
			var instruct:String = slot.getInstruction();
			if (instruct == Instruction.LEFT) setToLeft();
			if (instruct == Instruction.RIGHT) setToRight();
			if (instruct == Instruction.UP) setToUp();
			if (instruct == Instruction.NONE) setToNone();
			if (instruct == Instruction.BLANK) setToBlank();
		}
		
		public function removeSlot():void
		{
			(world as GameWorld).getTimeline().removeInstruction(this);
		}
	}

}