package  
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class HudIcon extends Button 
	{
		[Embed(source = "assets/hud/hud_menu_big.png")]private const MENU:Class;
		[Embed(source = "assets/hud/hud_music_big.png")]private const MUSIC:Class;
		[Embed(source = "assets/hud/hud_sfx_big.png")]private const SFX:Class;
		
		public var menuImage:Image;
		public var musicImage:Image;
		public var sfxImage:Image;
		public var _icon:String
		public function HudIcon(icon:String) 
		{
			super(0, 0, 33, 16, clicked);
			_icon = icon;
			menuImage = new Image(MENU);
			musicImage = new Image(MUSIC);
			sfxImage = new Image(SFX);
			if (icon == "menu")
			{
				all = menuImage;
				x = 16 * 42;
				y = 16 * 1;
			}
			if (icon == "music") 
			{
				all = musicImage;
				x = 16 * 42;
				y = 16 * 2;
				if (Preferences.musicMuted)
					alpha = 0.6;
				else alpha = 1;
			}
			if (icon == "sfx") 
			{
				all = sfxImage;
				x = 16 * 42;
				y = 16 * 3;
				if (Preferences.sfxMuted)
					alpha = 0.6;
				else alpha = 1;
			}
			layer = 200;
		}
		
		override public function added():void
		{
			setCallback(clicked);
		}
		
		private function clicked():void 
		{
			if (_icon == "menu") 
			{
				if ((world as GameWorld).getLevelComplete().world != null) return;
				if ((world as GameWorld).getInstructions().world != null) return;
				FP.world = Assets.WorldLevelSelect != null ? Assets.WorldLevelSelect : new LevelSelectMenu();
			}
			if (_icon == "music") 
			{
				Preferences.musicMuted = !Preferences.musicMuted;
				if (Preferences.musicMuted)
					alpha = 0.6;
				else alpha = 1;
			}
			if (_icon == "sfx") 
			{
				Preferences.sfxMuted = !Preferences.sfxMuted;
				if (Preferences.sfxMuted)
					alpha = 0.6;
				else alpha = 1;
			}
		}
		
	}

}