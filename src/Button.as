package
{
	import flash.events.MouseEvent;
	import net.flashpunk.graphics.Image;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.utils.Input;
	
	public class Button extends Entity
	{
		private var callback:Function = null;
		public var overCall:Function = null;
		private var overCalled:Boolean = false;
		
		private var initialized:Boolean = false;
		
		private var _normal:Graphic = new Graphic;
		private var _hover:Graphic = new Graphic;
		private var _down:Graphic = new Graphic;
		private var _inactive:Graphic = new Graphic;
		
		private var _normalChanged:Boolean = false;
		private var _hoverChanged:Boolean = false;
		private var _downChanged:Boolean = false;
		private var _inactiveChanged:Boolean = false;
		
		public var shouldCall:Boolean = true;
		
		public function Button(x:Number=0, y:Number=0, width:int=0, height:int=0, callback:Function=null)
		{
			super(x, y);
			
			setHitbox(width, height);
			
			this.callback = callback;
			graphic = normal;
		}
		
		override public function update():void
		{
			if(!initialized)
			{
				if(FP.stage != null)
				{
					FP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
					initialized = true;
				}
			}
			
			super.update();
			
			if(!shouldCall)
			{
				if(graphic != _inactive || _inactiveChanged)
				{
					graphic = _inactive;
					_inactiveChanged = false;
				}
			}
			else if(collidePoint(x, y, Input.mouseX, Input.mouseY))
			{
				if(Input.mouseDown)
				{
					if(graphic != _down || _downChanged)
					{
						graphic = _down;
						_downChanged = false;
					}
				}
				else if(graphic != _hover || _hoverChanged)
				{
					graphic = _hover;
					_hoverChanged = false;
					
					if(!overCalled)
					{
						if(overCall != null) overCall();
						overCalled = true;
					}
				}
			}
			else if(graphic != _normal || _normalChanged)
			{
				graphic = _normal;
				_normalChanged = false;
				overCalled = false;
			}
		}
		
		private function onMouseUp(e:MouseEvent=null):void
		{
			if(!shouldCall || !Input.mouseReleased || (callback == null) || (world != FP.world)) return;
			if(collidePoint(x, y, Input.mouseX, Input.mouseY)) callback();
		}
		
		override public function removed():void
		{
			super.removed();
			
			if(FP.stage != null)
				FP.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function set normal(normal:Graphic):void
		{
			_normal = normal;
			_normalChanged = true;
		}
		
		public function set hover(hover:Graphic):void
		{
			_hover = hover;
			_hoverChanged = true;
		}
		
		public function set down(down:Graphic):void
		{
			_down = down;
			_downChanged = true;
		}
		
		public function set inactive(inactive:Graphic):void
		{
			_inactive = inactive;
			_inactiveChanged = true;
		}
		
		public function set all(g:Graphic):void
		{
			normal = g;
			hover = g;
			down = g;
			inactive = g;
		}
		
		public function set alpha(num:Number):void
		{
			if (normal == null) return;
			(normal as Image).alpha = num;
			(hover as Image).alpha = num;
			(down as Image).alpha = num;
			(inactive as Image).alpha = num;
		}
		public function get alpha():Number
		{
			if (normal == null) return 1 ;
			return (normal as Image).alpha;
		}
		
		public function get normal():Graphic{ return _normal; }
		public function get hover():Graphic{ return _hover; }
		public function get down():Graphic{ return _down; }
		public function get inactive():Graphic { return _inactive; }
		public function get all():Graphic { return _normal; }
		
		public function setOverCall(f:Function):void
		{
			overCall = f;
		}
		public function setCallback(f:Function):void
		{
			if(FP.stage != null && callback != null)
				FP.stage.removeEventListener(MouseEvent.MOUSE_UP, callback);
			callback = f;
			initialized = false;
		}
	}
}