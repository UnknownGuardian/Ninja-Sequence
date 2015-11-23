package  
{
	import adobe.utils.CustomActions;
	import com.tremorgames.TremorGames;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Data;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelSelectMenu extends World
	{
		[Embed(source = "assets/menus/Level Select/level_select_Icons.png")]private const ICON_EXPORT:Class;		
		private var _image:Image;
		private var _iconsEntity:Entity;
		
		private var icons:Vector.<LevelSelectIcon> = new Vector.<LevelSelectIcon>();
		private var returnBtn:ReturnButton;
		
		private var bonusLevel:BonusButton;
		
		public var isAnimating:Boolean = false;
		
		private var _sponsorLogo:TremorAnimation = new TremorAnimation();
		
		public function LevelSelectMenu() 
		{
			Assets.WorldLevelSelect = this;
			
			_image = new Image(ICON_EXPORT);
			_iconsEntity = new Entity(-5, 0, _image);
			_iconsEntity.layer = 300;
			
			
			returnBtn = new ReturnButton(gotoMainMenu);
			returnBtn.x = FP.screen.width / 2 - 152 / 2;
			returnBtn.y = 480;
			
			bonusLevel = new BonusButton(gotoLevel);
			bonusLevel.x = FP.halfWidth - 118 / 2;
			bonusLevel.y = returnBtn.y - 50 - 10;
			
			
			for (var i:int = 0; i < 20; i++)
			{
				icons[i] = new LevelSelectIcon(i < 10, true/*i > maxLevelUnlocked*/, { level:i + 1, callback:gotoLevel } );
				icons[i].x = ( i % 5) * 68 + 200;
				icons[i].y = int(i / 5) * 85 + 103;
			}
		}
		
		private function gotoMainMenu():void 
		{
			close();
			FP.world = Assets.WorldMainMenu;
		}
		public function adjustIcons():void
		{
			var maxLevelUnlocked:int = Data.readInt("MaxLevelUnlocked", 1);
			
			
			//trace("Max Level Unlocked is " + maxLevelUnlocked);
			for (var i:int = 0; i < 20; i++)
			{
				if (i < maxLevelUnlocked/* && i < 5*/) 
					icons[i].unlock();
			}
		}
		
		public function gotoLevel(obj:*):void
		{
			if (isAnimating) return;
			close();
			
			Assets.LevelToBeLoaded = obj.getData().level;
			trace("Loading level from level select " + Assets.LevelToBeLoaded);
			FP.world = Assets.WorldGameWorld != null ? Assets.WorldGameWorld : new GameWorld();
			Assets.WorldGameWorld.getLevel().importLevel(Assets["LEVEL_" + Assets.LevelToBeLoaded]);
		}
		
		public function close():void 
		{
			removeList(returnBtn, _iconsEntity);
			removeList(icons);
		}
		
		override public function begin():void
		{
			super.begin();
			
			adjustIcons();
			addList(returnBtn, _iconsEntity);
			addList(icons);
			add(bonusLevel);
			returnBtn.setCallback(gotoMainMenu);
			
			if (Assets.WorldGameWorld != null)
			{
				Assets.WorldGameWorld.getTimeline().clearAllInstructions();
			}
			
			addList(Assets.clouds);
			add(Assets.sun);
			add(Assets.bg);
			Assets.bg.change();
			
			for (var i:int = 0; i < icons.length; i++)
			{
				icons[i].alpha = 0;
				var t:VarTween = new VarTween(null, Tween.ONESHOT);
				t.tween(icons[i], "alpha", 1, .1+i*.01);
				addTween(t, true);
				icons[i].updateStars();
			}
			bonusLevel.checkIfUnlocked();
			bonusLevel.updateStars();
			
			var t2:VarTween = new VarTween(enableClick, Tween.ONESHOT);
			t2.tween(returnBtn, "alpha", 1, .3);
			addTween(t2, true);
			isAnimating = true;
			
			Assets.loopMusic(Assets.LevelSelectMusic);
			Assets.fadeIn(Assets.LevelSelectMusic, 1);
			
			
			_sponsorLogo.scaleX = _sponsorLogo.scaleY = 0.6;
			_sponsorLogo.x = FP.stage.stageWidth - _sponsorLogo.width + 10;
			_sponsorLogo.y = FP.stage.stageHeight - _sponsorLogo.height + 10;
			_sponsorLogo.buttonMode = true;
			_sponsorLogo.addEventListener(MouseEvent.CLICK, visitLevelSelectSponsorLogo);
			FP.stage.addChild(_sponsorLogo);
		}
		private function visitLevelSelectSponsorLogo(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.tremorgames.com/"));
		}
		
		private function enableClick():void 
		{
			isAnimating = false;
		}
		
		override public function end():void
		{
			if (Assets.clouds[0].world == this)
			{
				trace("removed teh clouds on level select");
				removeList(Assets.clouds); //so they can be added to the new world
				remove(Assets.sun);
				remove(Assets.bg);
			}
			//Assets.LevelSelectMusic.stop();
			Assets.fadeOut(Assets.LevelSelectMusic, 0.75);
			
			_sponsorLogo.removeEventListener(MouseEvent.CLICK, visitLevelSelectSponsorLogo);
			FP.stage.removeChild(_sponsorLogo);
		}
		
	}

}