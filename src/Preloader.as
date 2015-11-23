package 
{
	import com.tremorgames.TremorGames;
	import CPMStar.AdLoader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filters.GlowFilter;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Preloader extends MovieClip 
	{
		[Embed(source = "assets/menus/Preloader/loading_button.png")]private const BUTTON:Class;
		[Embed(source = "assets/menus/Preloader/loading_stripes.png")]private const STRIPES:Class;
		//[Embed(source = "assets/Backgrounds/bkg_day.png")]private const BG:Class;
		[Embed(source="assets/Backgrounds/new_intro_3.jpg")]public const BG:Class;
		[Embed(source = "assets/menus/Main Menu/mainmenu_play.png")]private const PLAY:Class;
		
		
		public var b:Bitmap = new BUTTON();
		public var s:Bitmap = new STRIPES();
		private var bg:Bitmap = new BG();
		public var m:Sprite = new Sprite();
		
		public var playBtn:Sprite = new Sprite();
		public var sponsorAnim:TremorAnimation = new TremorAnimation();
		
		private var adBox:MovieClip = new MovieClip();
		
		public static var VERSION_TYPE:String = "cpmstar";//"mochi" "cpmstar" "none"
		private static var textField:TextField = new TextField();
		
		/*private var c:int = 0;*/
		public function Preloader() 
		{
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			// show loader
			addChild(bg);
			
			b.x = stage.stageWidth / 2 - b.width / 2;
			b.y = 280;
			addChild(b);
			s.x = b.x;
			s.y = b.y;
			addChild(s);	
			
			playBtn.addChild(new PLAY());
			playBtn.x = stage.stageWidth / 2 - playBtn.width / 2;
			playBtn.y = 280;
			
			TremorGames.Init(21, 3913, "Ninja Sequence", "ace3rt", LoaderInfo(root.loaderInfo).parameters,"http://www.tremorgames.com");
			
			
			textField.defaultTextFormat = new TextFormat(null, 8, 0xFFFFFF);
			//addChild(textField);
			textField.text = VERSION_TYPE;
			
			sponsorAnim.buttonMode = true;
			sponsorAnim.addEventListener(MouseEvent.CLICK, visitSponsorPreloader);
			
			if (VERSION_TYPE == "none")
			{
				sponsorAnim.x = stage.stageWidth / 2 - sponsorAnim.width / 2;
				sponsorAnim.y = 120;
				addChild(sponsorAnim);
				
				playBtn.y += 50;
				b.y = s.y = playBtn.y;
			}
			else if (VERSION_TYPE == "cpmstar")
			{		
				sponsorAnim.x = stage.stageWidth / 2 - sponsorAnim.width / 2;
				sponsorAnim.y = 40;
				addChild(sponsorAnim);
				
				//playBtn.x = stage.stageWidth/3 * 2;
				//playBtn.x -= 40;
				playBtn.y -= 60;
				b.y = s.y = playBtn.y;
				
				var ad:DisplayObject = AdLoader.LoadAd(21495,1007);
				ad.name = "ad";
				ad.x = stage.stageWidth / 2 - 320 / 2;
				//ad.x = 405
				//ad.y = 280
				ad.y = stage.stageHeight / 2 - 250 / 2 + 140;
				adBox.addChild(ad);
				//adBox.width = 320;
				//adBox.height = 250;
				addChild(adBox);
			}
			
		}
		
		private function visitSponsorPreloader(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.tremorgames.com"));
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// update loader
			
			var percent:Number = (e.target.bytesLoaded / e.target.bytesTotal);
			m.graphics.clear();
			m.graphics.beginFill(0x000000, 1);
			m.graphics.drawRect(b.x, b.y, int(b.width*percent), b.height);
			m.graphics.endFill();
			s.mask = m;
			
		}
		
		private function checkFrame(e:Event):void 
		{
			s.x += 3;
			if (s.x > 50) s.x -= 37;
			/*c++;
			if (c > 300) c = 300;
			var percent:Number = c / 300;
			m.graphics.clear();
			m.graphics.beginFill(0x000000, 1);
			m.graphics.drawRect(b.x, b.y, int(b.width*percent), b.height);
			m.graphics.endFill();
			s.mask = m;
			s.x += 3;
			if (s.x > 50) s.x -= 37;*/
			if (currentFrame == totalFrames) 
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				startup();
				stop();
			}
		}
		
		private function startup():void 
		{
			// hide loader
			//removeChild(bg);
			removeChild(s);
			s.bitmapData.dispose();
			removeChild(b);
			b.bitmapData.dispose();
			s = null;
			
			addChild(playBtn);
			playBtn.buttonMode = true;
			playBtn.addEventListener(MouseEvent.ROLL_OUT, rOut);
			playBtn.addEventListener(MouseEvent.ROLL_OVER, rOver);
			playBtn.addEventListener(MouseEvent.CLICK, continueToMainMenu);
		}
		
		private function rOver(e:MouseEvent):void 
		{
			e.currentTarget.filters = [new GlowFilter(0xFFFFFF, 1)];
		}
		
		private function rOut(e:MouseEvent):void 
		{
			e.currentTarget.filters = [];
		}
		
		
		private function continueToMainMenu(e:MouseEvent):void
		{
			playBtn.removeEventListener(MouseEvent.ROLL_OUT, rOut);
			playBtn.removeEventListener(MouseEvent.ROLL_OVER, rOver);
			playBtn.removeEventListener(MouseEvent.CLICK, continueToMainMenu);
			sponsorAnim.removeEventListener(MouseEvent.CLICK, visitSponsorPreloader);
			
			removeChild(bg);
			removeChild(playBtn);
			//removeChild(textField);
			
			if (VERSION_TYPE == "none")
			{
				removeChild(sponsorAnim);
			}
			else if (VERSION_TYPE == "cpmstar")
			{		
				removeChild(sponsorAnim);
				adBox.removeChildAt(0);
				removeChild(adBox);
			}
			setTimeout(delayedFunction, 20);
		}
		private function delayedFunction():void
		{			
			stop();
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}