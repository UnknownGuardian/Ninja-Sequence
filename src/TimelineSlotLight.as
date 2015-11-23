package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TimelineSlotLight extends Entity
	{
		[Embed(source = "assets/Timeline/timeline_big_indicator_idle.png")]private const OFF:Class;
		[Embed(source = "assets/Timeline/timeline_big_indicator_active.png")]private const ON:Class;
		
		public var _lightOn:Image;
		public var _lightOff:Image;
		public function TimelineSlotLight(X:Number = 0,Y:Number = 0) 
		{
			x = X;
			y = Y;
			_lightOn = new Image(ON);
			_lightOff = new Image(OFF);
			turnOff();
			layer = 19;
		}
		
		public function turnOff():void
		{
			graphic = _lightOff;
		}
		
		public function turnOn():void
		{
			graphic = _lightOn;
		}
		
		public function isOn():Boolean
		{
			return graphic == _lightOn;
		}
		
	}

}