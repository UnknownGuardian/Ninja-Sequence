package  
{
	import flash.events.MouseEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class InteractiveSlotEntity extends Entity
	{
		private var _callback:Function = null;		
		private var _initialized:Boolean = false;
		
		private var _isDragging:Boolean = false;
		private var _dragXOffset:Number = 0;
		private var _dragLastX:Number = 0;
		private var _dragDistance:Number = 0;
		
		private var ID:int = Math.random() * 99;
		
		public function InteractiveSlotEntity(X:Number = 0,Y:Number = 0, width:int=0, height:int=0) 
		{
			super(X, Y);
			setHitbox(width, height);
		}
		
		
		override public function update():void
		{
			if(!_initialized)
			{
				if(FP.stage != null)
				{
					FP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
					_initialized = true;
				}
			}
			
			if (graphic == null) return;
			if(Input.mousePressed && !_isDragging && collidePoint(x, y, Input.mouseX, Input.mouseY) && !(world as GameWorld).getTimeline().isPlaying())
			{
				trace("Detected Click " + ID);
				_isDragging = true;
				_dragXOffset = Input.mouseX - x;
				_dragDistance = 0;
				_dragLastX = x;
			}
			if(_isDragging && Input.mouseDown)
			{
				trace("Dragging and Mouse Down " + ID);
				x = Input.mouseX - _dragXOffset;
				_dragDistance += Math.abs(x - _dragLastX);
				_dragLastX = x;
				
				
				//adjust other slots
				var slots:Vector.<TimelineSlot> = (world as GameWorld).getTimeline().getSlots();
				var calculatedIndex:int = int(x / 28);
				var currentIndex:int = slots.indexOf(this);
				//if (currentIndex != calculatedIndex+999) //odd bug with moving if uncommented
				{
					var maxCalculatedIndex:int = 19;
					var firstBlank:int = (world as GameWorld).getTimeline().getIndexOfFirstBlank();
					if(firstBlank != -1)
						maxCalculatedIndex = firstBlank-1;
					if (calculatedIndex > maxCalculatedIndex) calculatedIndex = maxCalculatedIndex;
					if (calculatedIndex < 0) calculatedIndex = 0;
					
					
					//positioning like this: (13 + 28 * i, 479);
					if (currentIndex > calculatedIndex) //needs to be moved to the left
					{
						for (var s:int = currentIndex; s > calculatedIndex; s--)
						{
							slots[s] = slots[s-1];
						}
						slots[s] = this as TimelineSlot;
					}
					if (currentIndex < calculatedIndex) //needs to be moved to the right
					{
						for (var k:int = currentIndex; k < calculatedIndex; k++) //loop from back
						{
							slots[k] = slots[k + 1];
						}
						slots[k] = this as TimelineSlot;
					}
					
					//reposition all slots
					for (var q:int = 0; q < slots.length; q++)
					{
						if(slots[q] != this)
							slots[q].x = 13 + 28 * q;
					}
					
					if (x > 13 + 28 * (slots.length - 1)) x = 13 + 28 * (slots.length - 1);
					if (x < 13 ) x = 13;
				}
			}
			if(Input.mouseReleased && _isDragging)
			{
				_isDragging = false;
				_dragXOffset = 0;
				_dragDistance = 0;
				
				//reposition this one
				x = 13 + 28 * (world as GameWorld).getTimeline().getSlots().indexOf(this);
				
				//trace(_dragDistance);
			}
			
		}
		
		private function onMouseUp(e:MouseEvent=null):void
		{
			if (graphic == null) return;
			if (!Input.mouseReleased || (_callback == null) || (world as GameWorld).getTimeline().isPlaying()) return;
			
			if (_dragDistance > 5) return;
			
			if (collidePoint(x, y, Input.mouseX, Input.mouseY))
			{	
				_callback();
				_dragDistance = 0; //just in case
			}
		}
		
		override public function removed():void
		{
			super.removed();
			
			if(FP.stage != null)
				FP.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function setCallback(f:Function):void 
		{
			_callback = f;
		}
	}

}