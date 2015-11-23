package  
{
	import com.tremorgames.TremorGames;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class GameWorld extends World
	{
		private var _level:Level;
		private var _character:Character;
		private var _timeline:Timeline;
		private var _instructions:InstructionsMenu;
		private var _levelComplete:LevelCompleteMenu;
		private var _mainMenu:MainMenu;
		
		private var menuIcon:HudIcon;
		private var musicIcon:HudIcon;
		private var sfxIcon:HudIcon;
		
		private var _sponsorLogo:TremorAnimation = new TremorAnimation();
		
		public function GameWorld() 
		{
			Assets.WorldGameWorld = this;
			
			//_level = new EditableLevel();
			_level = new Level();
			add(_level);
			_timeline = new Timeline();
			add(_timeline);
			_character = new Character();
			add(_character);
			//_level.importLevel(Assets["LEVEL_" + Assets.LevelToBeLoaded]);
			_instructions = new InstructionsMenu();
			add(_instructions);
			_levelComplete = new LevelCompleteMenu();
			
			menuIcon = new HudIcon("menu");
			musicIcon = new HudIcon("music");
			sfxIcon = new HudIcon("sfx");
			addList(menuIcon, musicIcon, sfxIcon);
		}
		
		/*
		 * Getters
		 */
		public function getTimeline():Timeline
		{
			return _timeline;
		}
		public function getCharacter():Character
		{
			return _character;
		}
		public function getLevel():Level
		{
			return _level;
		}
		public function getInstructions():InstructionsMenu
		{
			return _instructions;
		}
		public function getLevelComplete():LevelCompleteMenu
		{
			return _levelComplete;
		}
		
		
		
		
		/*
		 * Overrides
		 */
		override public function update():void
		{
			super.update();
			if (Input.released(Key.M))
			{
				Preferences.sfxMuted = true;
				Preferences.musicMuted = true;
			}
		}
		override public function begin():void
		{
			super.begin();			
			addList(Assets.clouds);
			add(Assets.sun);
			add(Assets.bg);
			Assets.bg.change();
			
			if (!TremorGames.IsGameInTremorNetwork())
			{
				_sponsorLogo.scaleX = _sponsorLogo.scaleY = 0.4;
				_sponsorLogo.x = 5;
				_sponsorLogo.y = 5;
				_sponsorLogo.buttonMode = true;
				_sponsorLogo.addEventListener(MouseEvent.CLICK, visitInGameSponsorLogo);
				FP.stage.addChild(_sponsorLogo);
			}
		}
		
		private function visitInGameSponsorLogo(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.tremorgames.com/"));
		}
		override public function end():void
		{
			if (Assets.clouds[0].world == this)
			{
				removeList(Assets.clouds); //so they can be added to the new world
				remove(Assets.sun);
				remove(Assets.bg);
			}
			//Assets.DayMusic.stop();
			//Assets.NightMusic.stop();
			if (Assets.DayMusic.playing)
				Assets.fadeOut(Assets.DayMusic, 1);
			if (Assets.NightMusic.playing)
				Assets.fadeOut(Assets.NightMusic, 1);
				
			if (!TremorGames.IsGameInTremorNetwork())
			{
				_sponsorLogo.removeEventListener(MouseEvent.CLICK, visitInGameSponsorLogo);
				FP.stage.removeChild(_sponsorLogo);
			}
		}
		
		
		
		
		/*
		 * Transfer states
		 */
		public function showLevelComplete(numStars:int):void
		{
			add(_levelComplete);
			_levelComplete.showStars(numStars);
		}
		public function loadNextLevel():void
		{
			trace("Game World is loading level " + Assets.LevelToBeLoaded);
			Assets.LevelToBeLoaded++;
			trace("Game World is loading level " + Assets.LevelToBeLoaded);
			_level.importLevel(Assets["LEVEL_" + Assets.LevelToBeLoaded]);
			_timeline.clearAllInstructions();
			
			
			
			if (Assets.LevelToBeLoaded == 6)
				add(new Protips());
		}
		/*public function showLevelSelect():void
		{
			FP.world = Assets.WorldMainMenu;
			Assets.WorldMainMenu.clickedPlay();
		}*/
	}

}