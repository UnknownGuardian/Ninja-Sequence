package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class OptionSelector extends Button 
	{
		
		[Embed(source = "assets/menus/Options Menu/switch_on_off.png")]public static const ONOFF:Class;
		private var _image:Image;
		private var _slider:Slider;
		private var _callback:Function;
		public function OptionSelector(sliderCallback:Function, X:int, Y:int)
		{
			super(0, 0, 110, 32, interceptCallback);
			_image = new Image(ONOFF);
			all = _image;
			_callback = sliderCallback;	
			
			x = X;
			y = Y;
			_slider = new Slider(false, x+2,y+2);
		}
		
		override public function added():void
		{
			
			
			super.added();
			world.add(_slider);
			setCallback(interceptCallback);
		}
		
		override public function removed():void
		{
			world.remove(_slider);
		}	
		
		public function interceptCallback():void
		{
			_slider.toggle();
			_callback();
		}
		
		public function getSlider():Slider
		{
			return _slider;
		}
	}

}