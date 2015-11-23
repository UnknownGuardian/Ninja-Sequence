package  
{
	import com.tremorgames.TremorGames;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class MainMenu extends World
	{
		[Embed(source = "assets/menus/Main Menu/mainmenu_play_big.png")]private const PLAY:Class;
		[Embed(source = "assets/menus/Main Menu/mainmenu_options.png")]private const OPTIONS:Class;
		[Embed(source = "assets/menus/Main Menu/mainmenu_credits.png")]private const CREDITS:Class;
		[Embed(source = "assets/menus/Main Menu/mainmenu_moregames.png")]private const MOREGAMES:Class;
		[Embed(source = "assets/Button Overlays/mainmenu_play_big_overlay.png")]private const PLAY_O:Class;
		[Embed(source = "assets/Button Overlays/mainmenu_options_overlay.png")]private const OPTIONS_O:Class;
		[Embed(source = "assets/Button Overlays/mainmenu_credits_overlay.png")]private const CREDITS_O:Class;
		[Embed(source="assets/Button Overlays/mainmenu_moregames_overlay.png")]private const MOREGAMES_O:Class;
		
		
		[Embed(source = "sponsor/AchievementsPlay.png")]private const ACHIEVEMENTS:Class;
		
		private var _title:Title;
		private var _playBtn:Button;
		private var _optionsBtn:Button;
		private var _creditsBtn:Button;
		private var _moreGamesBtn:Button;
		
		private var options:OptionsMenu;
		private var credits:CreditsMenu;
		//private var levelSelect:LevelSelectMenu;
		
		public var isAnimating:Boolean = false;
		
		private var _sponsorLogo:TremorAnimation = new TremorAnimation();
		private var _playGameWithAchievements:Bitmap = new ACHIEVEMENTS();
		
		
		public function MainMenu() 
		{
			Assets.WorldMainMenu = this;
			
			
			
			//add(new InstructionsMenu());
			//add(new LevelSelectMenu(clickedPlay));
			
			_title = new Title();
			add(_title);
			
			_playBtn = new Button(0, 0, 170, 50, clickedPlay);
			_playBtn.all = new Image(PLAY);
			_playBtn.hover = new Image(PLAY_O);
			//_playBtn.x = (FP.screen.width - _playBtn.width) / 2;
			//_playBtn.y = 280;
			
			_optionsBtn = new Button(0, 0, 135, 33, clickedOptions);
			_optionsBtn.all = new Image(OPTIONS);
			_optionsBtn.hover = new Image(OPTIONS_O);
			//_optionsBtn.x = (FP.screen.width - _optionsBtn.width) / 2;
			//_optionsBtn.y = 350;
			
			_creditsBtn = new Button(0, 0, 135, 33, clickedCredits);
			_creditsBtn.all = new Image(CREDITS);
			_creditsBtn.hover = new Image(CREDITS_O);
			//_creditsBtn.x = (FP.screen.width - _creditsBtn.width) / 2;
			//_creditsBtn.y = 400;
			
			_moreGamesBtn = new Button(0, 0, 135, 33, clickedMoreGames);
			_moreGamesBtn.all = new Image(MOREGAMES);
			_moreGamesBtn.hover = new Image(MOREGAMES_O);
			//_moreGamesBtn.x = (FP.screen.width - _moreGamesBtn.width) / 2;
			//_moreGamesBtn.y = 450;
			
			addList(_playBtn, _optionsBtn, _creditsBtn, _moreGamesBtn);
			
			options = new OptionsMenu(replaceButtons);
			credits = new CreditsMenu(replaceButtons);
			//levelSelect = new LevelSelectMenu(replaceButtons);
		}
		
		
		
		/*override public function added():void
		{
			super.added();
			
			
			
			
		}*/
		
		override public function begin():void
		{
			replaceButtons();
			
			if (Assets.clouds.length == 0)
			{
				for (var i:int = 0; i < 5; i++)
				{
					var c:Cloud = new Cloud();
					c.x = Math.random() * (FP.screen.width / 7) + FP.screen.width / 5 * i;
					c.y = Math.random() * (FP.screen.height / 4) + 5;
					Assets.clouds[i] = c;
				}
			}
			addList(Assets.clouds);
			add(Assets.sun);
			Assets.bg.change();
			add(Assets.bg);
			trace(Assets.MainMenuMusic.volume);
			Assets.loopMusic(Assets.MainMenuMusic);
			Assets.fadeIn(Assets.MainMenuMusic, 1);
			
			_sponsorLogo.scaleX = _sponsorLogo.scaleY = 0.6;
			_sponsorLogo.x = FP.stage.stageWidth - _sponsorLogo.width + 10;
			_sponsorLogo.y = FP.stage.stageHeight - _sponsorLogo.height + 10;
			_sponsorLogo.buttonMode = true;
			_sponsorLogo.addEventListener(MouseEvent.CLICK, visitMainMenuSponsorLogo);
			FP.stage.addChild(_sponsorLogo);
			
			
			if (!TremorGames.IsGameInTremorNetwork())
			{
				_playGameWithAchievements.x = FP.stage.stageWidth - _playGameWithAchievements.width - 5;
				_playGameWithAchievements.y = _sponsorLogo.y - 40;
				FP.stage.addChild(_playGameWithAchievements);
			}
			
		}
		
		private function visitMainMenuSponsorLogo(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.tremorgames.com/"));
		}
		
		override public function end():void
		{
			if (Assets.clouds.length != 0)
			{
				if (Assets.clouds[0].world == this)
				{
					trace("removed teh clouds on main menu");
					removeList(Assets.clouds); //so they can be added to the new world
				}
			}
			remove(Assets.sun);
			remove(Assets.bg);
			//Assets.MainMenuMusic.stop();
			
			_sponsorLogo.removeEventListener(MouseEvent.CLICK, visitMainMenuSponsorLogo);
			FP.stage.removeChild(_sponsorLogo);
			if (!TremorGames.IsGameInTremorNetwork())
			{
				FP.stage.removeChild(_playGameWithAchievements);
			}
		}
		
		private function replaceButtons():void 
		{
			_playBtn.x = (FP.screen.width - _playBtn.width) / 2;
			_playBtn.y = 280;
			_playBtn.alpha = 0;
			var t:VarTween = new VarTween(null, Tween.ONESHOT);
			t.tween(_playBtn, "alpha", 1, 0.3);
			addTween(t, true);
			
			_optionsBtn.x = (FP.screen.width - _optionsBtn.width) / 2;
			_optionsBtn.y = 350;
			_optionsBtn.alpha = 0;
			var t2:VarTween = new VarTween(null, Tween.ONESHOT);
			t2.tween(_optionsBtn, "alpha", 1, 0.45);
			addTween(t2, true);
			
			_creditsBtn.x = (FP.screen.width - _creditsBtn.width) / 2;
			_creditsBtn.y = 400;
			_creditsBtn.alpha = 0;
			var t3:VarTween = new VarTween(null, Tween.ONESHOT);
			t3.tween(_creditsBtn, "alpha", 1, 0.60);
			addTween(t3, true);
			
			_moreGamesBtn.x = (FP.screen.width - _moreGamesBtn.width) / 2;
			_moreGamesBtn.y = 450;
			_moreGamesBtn.alpha = 0;
			var t4:VarTween = new VarTween(enableClick, Tween.ONESHOT);
			t4.tween(_moreGamesBtn, "alpha", 1, 0.75);
			addTween(t4, true);
			
			isAnimating = true;
		}
		
		private function enableClick():void 
		{
			isAnimating = false;
		}
		
		public function clickedPlay():void 
		{
			if (isAnimating) return;
			
			if (options.world != null) return;
			if (credits.world != null) return;
			
			/*_playBtn.x = -999;
			_optionsBtn.x = -999;
			_creditsBtn.x = -999;
			_moreGamesBtn.x = -999;*/
			
			
			
			var t:VarTween = new VarTween(gotoLevelSelect, Tween.ONESHOT);
			t.tween(_playBtn, "alpha", 0, 0.75);
			addTween(t, true);
			
			var t2:VarTween = new VarTween(null, Tween.ONESHOT);
			t2.tween(_optionsBtn, "alpha", 0, 0.60);
			addTween(t2, true);
			
			var t3:VarTween = new VarTween(null, Tween.ONESHOT);
			t3.tween(_creditsBtn, "alpha", 0, 0.45);
			addTween(t3, true);
			
			var t4:VarTween = new VarTween(null, Tween.ONESHOT);
			t4.tween(_moreGamesBtn, "alpha", 0, 0.3);
			addTween(t4, true);
			isAnimating = true;
			
			
			//Assets.MenuFader = new SfxFader(Assets.MainMenuMusic);
			//Assets.MenuFader.fadeTo(0, 2);
			//Assets.MenuFader.crossFade(Assets.LevelSelectMusic, true, 0.5, Preferences.musicMuted? 0:1);
			Assets.fadeOut(Assets.MainMenuMusic, 0.75);
		}
		
		private function gotoLevelSelect():void 
		{
			isAnimating = false;
			FP.world = Assets.WorldLevelSelect != null ? Assets.WorldLevelSelect : new LevelSelectMenu();
		}
		
		private function clickedOptions():void 
		{
			if (isAnimating) return;
			
			if (credits.world != null) return;
			
			_playBtn.x = (FP.screen.width - _playBtn.width) / 2;
			_playBtn.y = 100 - _playBtn.height;
			
			_optionsBtn.x = FP.screen.width/4 - _optionsBtn.width / 2;
			_optionsBtn.y = FP.screen.height/2 - _optionsBtn.height/2;
			
			_creditsBtn.x = 3*FP.screen.width/4 - _creditsBtn.width / 2;
			_creditsBtn.y = FP.screen.height/2 - _creditsBtn.height/2;
			
			_moreGamesBtn.x = (FP.screen.width - _moreGamesBtn.width) / 2;
			_moreGamesBtn.y = FP.screen.height - 100;
			add(options);
			
		}
		
		private function clickedCredits():void 
		{
			if (isAnimating) return;
			
			if (options.world != null) return;
			
			_moreGamesBtn.x = FP.screen.width/4 - _moreGamesBtn.width / 2;
			_moreGamesBtn.y = FP.screen.height / 2 - _moreGamesBtn.height / 2 + 50;
			
			_playBtn.x = _moreGamesBtn.x - (_playBtn.width - _moreGamesBtn.width);
			_playBtn.y = FP.screen.height/2 - _playBtn.height/2 - 50;
			
			_optionsBtn.x = 3*FP.screen.width/4 - _optionsBtn.width / 2;
			_optionsBtn.y = FP.screen.height/2 - _optionsBtn.height/2 - 50;
			
			_creditsBtn.x = 3*FP.screen.width/4 - _creditsBtn.width / 2;
			_creditsBtn.y = FP.screen.height/2 - _creditsBtn.height/2 + 50 ;
			
			
			add(credits);
		}
		
		private function clickedMoreGames():void 
		{
			navigateToURL(new URLRequest("http://www.tremorgames.com/"));
		}
	}

}