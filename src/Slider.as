package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Slider extends Entity
	{
		
		[Embed(source = "assets/menus/Options Menu/slider.png")]public static const SLIDER:Class;
		private var _image:Image;
		
		private var _isOn:Boolean = false;
		public function Slider(startOn:Boolean = false, X:int = 0, Y:int = 0)
		{
			super(X, Y);
			_image = new Image(SLIDER);
			graphic = _image;
			
			if (startOn) on();
		}
		
		public function on():void
		{
			if (!_isOn)
			{
				_isOn = true;
				x +=  48;
			}
		}
		
		public function off():void
		{
			if (_isOn)
			{
				_isOn = false;
				x -= 48;
			}
		}
		
		public function toggle():void
		{
			if (_isOn) off();
			else on();
		}
		
		public function isOn():Boolean
		{
			return _isOn;
		}
		
	}

}