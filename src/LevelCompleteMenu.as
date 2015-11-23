package  
{
	import com.tremorgames.TremorGames;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelCompleteMenu extends Entity
	{
		//[Embed(source = "assets/menus/Level Complete/hud_level_complete_sponsor.png")]private const BG:Class;
		[Embed(source = "assets/menus/Level Complete/hud_level.png")]private const BG:Class;
		[Embed(source = "assets/menus/Level Complete/ninja_ending.png")]private const BG_ALT:Class;
		[Embed(source = "assets/menus/Level Complete/star.png")]private const STAR:Class;
		[Embed(source = "assets/Button Overlays/next_level_overlay.png")]private const NEXT_O:Class;
		[Embed(source = "assets/Button Overlays/replay_level_overlay.png")]private const REPLAY_O:Class;
		[Embed(source="assets/Button Overlays/main_menu_overlay.png")]private const MAIN_O:Class;
		
		
		private var _canvas:Canvas;
		private var backgroundGraphic:Image
		private var altBackgroundGraphic:Image;
		private var star1:Image
		private var star2:Image
		private var star3:Image
		
		private var replayBtn:Button;
		private var levelSelectBtn:Button;
		private var nextBtn:Button;
		
		private var _sponsorLogo:TremorAnimation = new TremorAnimation();
		
		public function LevelCompleteMenu() 
		{
			backgroundGraphic = new Image(BG);
			backgroundGraphic.x = FP.halfWidth - backgroundGraphic.width / 2;
			backgroundGraphic.y = 464/2 - backgroundGraphic.height / 2 ;
			
			altBackgroundGraphic = new Image(BG_ALT);
			altBackgroundGraphic.x = FP.halfWidth - altBackgroundGraphic.width / 2;
			altBackgroundGraphic.y = 464 / 2 - altBackgroundGraphic.height / 2;
			
			star1 = new Image(STAR);
			star2 = new Image(STAR);
			star3 = new Image(STAR);
			star1.x = backgroundGraphic.x + 50;
			star2.x = backgroundGraphic.x + 102;
			star3.x = backgroundGraphic.x + 154;
			star1.y = star2.y = star3.y = backgroundGraphic.y + 77;
			
			_canvas = new Canvas(FP.screen.width, FP.screen.height);
			_canvas.drawRect(new Rectangle(0, 0, FP.screen.width, FP.screen.height), 0xFFFFFF, 0.25);
			
			addGraphic(_canvas);
			addGraphic(backgroundGraphic);
			addGraphic(star1);
			addGraphic(star2);
			addGraphic(star3);
			
			replayBtn = new Button(258, 372 - (540 - 464) / 2, 50, 50, gotoSameLevel);
			replayBtn.hover = new Image(REPLAY_O);
			levelSelectBtn = new Button(326, 372 - (540 - 464) / 2, 64, 50, gotoLevelSelect);
			levelSelectBtn.hover = new Image(MAIN_O);
			nextBtn = new Button(411, 372 - (540 - 464) / 2, 50, 50, gotoNextLevel);
			nextBtn.hover = new Image(NEXT_O);
		}
		
		override public function added():void
		{
			world.add(replayBtn);
			world.add(levelSelectBtn);
			world.add(nextBtn);
			
			replayBtn.setCallback(gotoSameLevel);
			levelSelectBtn.setCallback(gotoLevelSelect);
			nextBtn.setCallback(gotoNextLevel);
			
			if (Assets.LevelToBeLoaded != 20)
			{
				_sponsorLogo.scaleX = _sponsorLogo.scaleY = 0.6;
				_sponsorLogo.x = 274;
				_sponsorLogo.y = 215;
				_sponsorLogo.buttonMode = true;
				_sponsorLogo.addEventListener(MouseEvent.CLICK, visitLevelCompleteSponsorLogo);
				FP.stage.addChild(_sponsorLogo);
			}
			
			
		}
		override public function update():void
		{
			if (Input.released(Key.RIGHT) || Input.released(Key.D)) gotoNextLevel();
			if (Input.released(Key.LEFT) || Input.released(Key.A)) gotoSameLevel();
			if (Input.released(Key.DOWN) || Input.released(Key.S)) gotoLevelSelect();
		}
		override public function removed():void
		{
			world.removeList(replayBtn, levelSelectBtn, nextBtn);
			
			if (_sponsorLogo.parent != null)
			{
				FP.stage.removeChild(_sponsorLogo);
				_sponsorLogo.removeEventListener(MouseEvent.CLICK, visitLevelCompleteSponsorLogo);
			}
		}
		private function visitLevelCompleteSponsorLogo(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.tremorgames.com/"));
		}
		
		private function gotoNextLevel():void 
		{
			if (Assets.LevelToBeLoaded + 1 > 20) 
			{
				gotoLevelSelect();
				return;
			}
			
			//if (Assets.LevelToBeLoaded+1 > 5){ gotoLevelSelect(); return;} //stops on level 5
			(world as GameWorld).loadNextLevel();
			world.remove(this);
			
			saveLevelComplete();
		}
		
		private function saveLevelComplete():void 
		{
			var maxLevelUnlocked:int = Data.readInt("MaxLevelUnlocked", 0);
			if (maxLevelUnlocked < Assets.LevelToBeLoaded+1 && Assets.LevelToBeLoaded < 21)
			{
				Data.writeInt("MaxLevelUnlocked", Assets.LevelToBeLoaded+1);
				Data.save("Sequence");
			}
		}
		
		private function gotoLevelSelect():void 
		{
			FP.world = Assets.WorldLevelSelect != null ? Assets.WorldLevelSelect : new LevelSelectMenu();
			if(world != null)
				world.remove(this);
			
			saveLevelComplete();
		}
		
		private function gotoSameLevel():void 
		{
			saveLevelComplete();
			if(world != null)
				world.remove(this);
		}
		
		public function showStars(amount:int):void
		{
			
			
			var maxStars:int = Data.readInt("L" + Assets.LevelToBeLoaded, 0);
			if (maxStars == 4) maxStars = 3; //correct level 1 bug
			if (amount == 4) amount = 3; //correct level 1 bug
			if (maxStars < amount)
				Data.writeInt("L" + Assets.LevelToBeLoaded, amount);
			Data.save("Sequence");
			
			
			
			
			
			
			
			/* Tremor API
			 */
			
			 
			 var numPerfectLevels:int = 0;
			 var numRingsCollected:int = 0;
			 for (var q:int = 1; q <= 20; q++)
			 {
				var numStarsEarned:int = Data.readInt("L" + q, 0);
				if ( numStarsEarned >= 3 && numStarsEarned <= 5) //be reasonable ;)
				{
					numPerfectLevels++;
				}
				numRingsCollected += numStarsEarned;
				
			 }
			 
			 if (numRingsCollected > 60) numRingsCollected = 60;
			 
			 trace("Rating: " + numPerfectLevels);
			 trace("Rings Collected", numRingsCollected);
			 trace("Levels Completed", Assets.LevelToBeLoaded);
			TremorGames.PostStat("Rating", numPerfectLevels);
			TremorGames.PostStat("Rings Collected", numRingsCollected);
			TremorGames.PostStat("Levels Completed", Assets.LevelToBeLoaded);
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			(graphic as Graphiclist).remove(backgroundGraphic);
			(graphic as Graphiclist).remove(altBackgroundGraphic);
			(graphic as Graphiclist).remove(star1);
			(graphic as Graphiclist).remove(star2);
			(graphic as Graphiclist).remove(star3);
			
			if (Assets.LevelToBeLoaded == 20)
			{
				addGraphic(altBackgroundGraphic);
				altBackgroundGraphic.alpha = 0;
				var t5:VarTween = new VarTween(null, Tween.ONESHOT);
				t5.tween(altBackgroundGraphic, "alpha", 1, .1);
				addTween(t5, true);
				
				star1.x = altBackgroundGraphic.x + 100;
				star2.x = altBackgroundGraphic.x + 152;
				star3.x = altBackgroundGraphic.x + 204;
				star1.y = star2.y = star3.y = altBackgroundGraphic.y + 77;
				
				replayBtn.x = 208;
				replayBtn.y = 360
				levelSelectBtn.x = 327;
				levelSelectBtn.y = 360;
				nextBtn.x = 462;
				nextBtn.y = 360;
				
				if (_sponsorLogo.parent != null)
				{
					FP.stage.removeChild(_sponsorLogo);
					_sponsorLogo.removeEventListener(MouseEvent.CLICK, visitLevelCompleteSponsorLogo);
				}
				
			}
			else
			{
				addGraphic(backgroundGraphic);
				backgroundGraphic.alpha = 0;
				var t4:VarTween = new VarTween(null, Tween.ONESHOT);
				t4.tween(backgroundGraphic, "alpha", 1, .1);
				addTween(t4, true);
				
				star1.x = backgroundGraphic.x + 50;
				star2.x = backgroundGraphic.x + 102;
				star3.x = backgroundGraphic.x + 154;
				star1.y = star2.y = star3.y =  backgroundGraphic.y + 77;
				
				replayBtn.x = 258;
				replayBtn.y = 372 - (540 - 464) / 2;
				levelSelectBtn.x = 326;
				levelSelectBtn.y = 372 - (540 - 464) / 2;
				nextBtn.x = 411;
				nextBtn.y = 372 - (540 - 464) / 2;
			}
			
			
			
			
			if(amount > 0) addGraphic(star1);
			if(amount > 1) addGraphic(star2);
			if (amount > 2) addGraphic(star3);
			
			star1.alpha = 0;
			star2.alpha = 0;
			star3.alpha = 0;
			
			var t:VarTween = new VarTween(null, Tween.ONESHOT);
			t.tween(star1, "alpha", 1, .3);
			addTween(t, true);
			
			var t2:VarTween = new VarTween(null, Tween.ONESHOT);
			t2.tween(star2, "alpha", 1, .45);
			addTween(t2, true);
			
			var t3:VarTween = new VarTween(null, Tween.ONESHOT);
			t3.tween(star3, "alpha", 1, .6);
			addTween(t3, true);
		}
		
	}

}