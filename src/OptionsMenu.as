package  
{
	import flash.display.StageQuality;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class OptionsMenu extends Entity
	{
		[Embed(source = "assets/menus/Options Menu/menu_options.png")]private const BACKGROUND:Class;
		
		private var sfx:OptionSelector;
		private var music:OptionSelector;
		private var quality:QualitySelector;
		private var returnBtn:ReturnButton;
		
		public var _image:Image;
		public var _canvas:Canvas;
		private var _closeCallback:Function
		public function OptionsMenu(c:Function) 
		{
			_closeCallback = c;
			_canvas = new Canvas(FP.screen.width, FP.screen.height);
			_canvas.drawRect(new Rectangle(0, 0, FP.screen.width, FP.screen.height), 0xFFFFFF, 0.2);
			
			
			_image = new Image(BACKGROUND);
			addGraphic(_canvas);
			addGraphic(_image);
			
			
			
			music = new OptionSelector(clickedMusic, 		FP.screen.width / 2 - 102 / 2,		185);
			sfx = new OptionSelector(clickedSFX, 			FP.screen.width / 2 - 102 / 2, 		250);
			quality = new QualitySelector(clickedQuality, 	FP.screen.width / 2 - 102 / 2,		320);
			returnBtn = new ReturnButton(close);
			returnBtn.x = FP.screen.width / 2 - 152 / 2;
			returnBtn.y = 370;
			//169x288
			_image.x = FP.screen.width / 2 - 170/2;
			_image.y = FP.screen.height / 2 - 288/2;
		}
		
		public function close():void 
		{
			world.removeList(sfx, music, quality, returnBtn, this);
			if (_closeCallback != null)_closeCallback();
			/*returnBtn.all = null;
			graphic = null;
			world.removeList(sfx, music, quality, returnBtn, this);*/
		}
		
		override public function added():void
		{
			super.added();
			
			if (Preferences.musicMuted)	music.getSlider().off(); else music.getSlider().on();
			if (Preferences.sfxMuted)	sfx.getSlider().off(); else sfx.getSlider().on();
			if (Preferences.quality == StageQuality.HIGH)	quality.getSlider().off();else quality.getSlider().on();
			
			world.addList(sfx, music, quality, returnBtn);
			returnBtn.setCallback(close);
			
			
		}
		
		public function clickedMusic():void
		{
			Preferences.musicMuted = !music.getSlider().isOn();
		}
		public function clickedSFX():void
		{
			Preferences.sfxMuted = !sfx.getSlider().isOn();
		}
		public function clickedQuality():void
		{
			Preferences.quality = quality.getSlider().isOn() ? StageQuality.HIGH : StageQuality.LOW;
			Data.writeString("Quality", Preferences.quality);
			Data.save("Sequence");
		}
	}
}