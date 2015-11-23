package 
{
	import com.tremorgames.TremorGames;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Data;

	/**
	 * ...
	 * @author UnknownGuardian
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine
	{
		public function Main():void 
		{
			super(720, 540, 60, false);
			Assets.MainEngine = this;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		public function addedToStage(e:Event):void
		{
			
			
			var sponsorSplash:SponsorSplash = new SponsorSplash();
			//sponsorSplash.scaleX = sponsorSplash.scaleY = 0.8;
			sponsorSplash.x = -50;
			sponsorSplash.y = -50;
			addChild(sponsorSplash);
			sponsorSplash.buttonMode = true;
			sponsorSplash.addEventListener(Event.REMOVED_FROM_STAGE, afterSponsorSplash);
			sponsorSplash.addEventListener(MouseEvent.CLICK, visitSponsorSplash);
		}
		
		private function visitSponsorSplash(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.tremorgames.com/"));
		}
		private function afterSponsorSplash(e:Event):void
		{			
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, afterSponsorSplash);
			e.currentTarget.removeEventListener(MouseEvent.CLICK, visitSponsorSplash);
			
			var sp:SplashScreen = new SplashScreen();
			addChild(sp);
			sp.addEventListener(Event.REMOVED_FROM_STAGE, afterSplash);

		}
		
		private function afterSplash(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, afterSplash);
			
			trace(stage);
			/*SiteLock.registerStage(stage);
			SiteLock.allowLocalPlay();
			SiteLock.allowSites(["profusiongames.com", "dropbox.com", "megaswf.com", "flashgamelicense.com"]);
			if (!SiteLock.checkURL(false))
			{
				return;
			}*/
			
			
			Data.id = "Profusion";
			Data.load("Sequence");
			Data.writeInt("PlayCount", Data.readInt("PlayCount", 0) + 1);
			Data.save("Sequence");
			
			Preferences.loadPreferences();
			
			
			
			
			
			//FP.world = new GameWorld();
			FP.world = new MainMenu();
			//FP.console.enable();
		}

		override public function init():void 
		{
			trace("FlashPunk has started successfully!");		
			
		}

	}

}