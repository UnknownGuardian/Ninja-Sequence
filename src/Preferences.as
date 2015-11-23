package  
{
	import flash.display.StageQuality;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Preferences 
	{
		private static var _musicMuted:Boolean = false;
		private static var _sfxMuted:Boolean = false;
		private static var _quality:String = StageQuality.HIGH;
		
		public function Preferences() 
		{
			
		}
		
		static public function loadPreferences():void
		{
			Preferences.musicMuted = Data.readBool("MusicMuted", false);
			Preferences.sfxMuted = Data.readBool("SFXMuted", false);
			Preferences.quality = Data.readString("Quality", StageQuality.HIGH);			
			trace("Loaded Preferences: ", "Music Muted:", Preferences.musicMuted, "SFX Muted:", Preferences.sfxMuted, "Quality:", Preferences.quality);
		}
		
		static public function get musicMuted():Boolean 
		{
			return _musicMuted;
		}
		
		static public function set musicMuted(value:Boolean):void 
		{
			trace("Preferences: ", "Music Muted:", value);
			Data.writeBool("MusicMuted", value);
			Data.save("Sequence");
			_musicMuted = value;
			
			if (_musicMuted) Assets.muteMusic();
			else Assets.unmuteMusic();
			
			trace(Assets.MainMenuMusic.volume + "pre", _musicMuted);
		}
		
		static public function get sfxMuted():Boolean 
		{
			return _sfxMuted;
		}
		
		static public function set sfxMuted(value:Boolean):void 
		{
			trace("Preferences: ", "SFX Muted:", value);
			Data.writeBool("SFXMuted", value);
			Data.save("Sequence");
			_sfxMuted = value;
			
			if (_sfxMuted) Assets.muteSfx();
			else Assets.unmuteSfx();
		}
		
		static public function get quality():String 
		{
			return _quality;
		}
		
		static public function set quality(value:String):void 
		{
			FP.stage.quality = value;
			_quality = value;
		}
		
	}

}