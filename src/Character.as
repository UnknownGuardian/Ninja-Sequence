package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.tweens.motion.CubicMotion;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Character extends Entity
	{
		[Embed(source = "assets/char/char_ninja_SS.png")]private const FRAMES:Class;
		[Embed(source = "assets/char/char_white_ninja_SS_FINAL.png")]private const NIGHT_FRAMES:Class;
		private var deadTween:VarTween;
		
		public var boxGuy:Spritemap = new Spritemap(FRAMES, 16, 16);
		public var boxGuyNight:Spritemap = new Spritemap(NIGHT_FRAMES, 16, 16);
		public var frameName:Array = ["dead", "idle", "left", "right", "up"];
		
		
		public const GRAVITY:Number = 0.06;
		public const FRICTION:Number = 0.95;
		public const GLASS_FRICTION:Number = 0.70;
		public const VEL_X_MIN:Number = 0.1;
		public const VEL_Y_MAX:Number = 2.5;
		public var velX:Number = 0;
		public var velY:Number = 0;
		
		public var instructTime:int = 26//47;
		public var instructTimeMax:int = 26;//47;
		
		public var numberOfRingsCarrying:Number = 0;
		
		public var isAnimating:Boolean = false;
		
		public function Character() 
		{
			setFace("idle");
			graphic = boxGuy;
			//y = 100;
			//x = FP.screen.width / 2;
			setHitbox(16, 16);
			layer = 5;
			
			
		}
		
		
		
		public function setFace(face:String):void
		{
			var index:int = frameName.indexOf(face);
			if (index == -1){ trace("[Character][setFace()] Did not find specified face: " + face + " | " + (new Error()).getStackTrace()); return;}
			boxGuy.setFrame(index);
			boxGuyNight.setFrame(index);
		}
		
		override public function update():void
		{
			//hide or show debug panel by pressing Escape (27 key code)
			if (Input.released(27))
			{
				FP.console.enable();
			}
			
			
			if (Assets.LevelToBeLoaded > 10)
			{
				if(graphic != boxGuyNight)
					graphic = boxGuyNight;
			}
			else if(graphic != boxGuy)
				graphic = boxGuy;
				
			
			
			if (!(world as GameWorld).getTimeline().isPlaying())
				return; //do not move
			
				
			if (isAnimating) return;
				
				
			
			//check collision with level
			if (x < 0 || x > 720-width || y < 0 || y > 464-height || collide("spikes", x,y) || collide("static", x,y))
			{
				showDeathAnim();				
				return;
			}
			
			//if going fast enough to break glass
			if (collide("glass", x, y))
			{
				//trace(typeof collide("glass", x, y), velY);
				if (velY > 2*VEL_Y_MAX/3 || velX > 2*VEL_Y_MAX/3)
				{
					setFace("idle");
					var glass:Tilemap = (world as GameWorld).getLevel().getGlassEntity().getTilemap();
					glass.setTile(x / 16, y / 16, 0);
					glass.setTile(x / 16 + 1, y / 16, 0);
					glass.setTile(x / 16, y / 16 + 1, 0);
					glass.setTile(x / 16 + 1, y / 16 + 1, 0);
					(world as GameWorld).getLevel().getGlassEntity().makeGrid();
					velY *= GLASS_FRICTION;
					velX *= GLASS_FRICTION;
					
				}
				else
				{
					showDeathAnim();
					return;
				}
			}
			
			var collidedEntity:Entity = collide("ring", x, y);
			if (collidedEntity != null)
			{
				numberOfRingsCarrying++;
				collidedEntity.world.remove(collidedEntity);
				Assets.RingSound.play();
			}
			collidedEntity = collide("Key", x, y);
			if (collidedEntity != null)
			{
				var lockList:Array = [];
				world.getType("Lock", lockList);
				Assets.KeySound.play();
				collidedEntity.world.removeList(lockList);
				collidedEntity.world.remove(collidedEntity);
			}
			
			//striped box collision
			collidedEntity = collide("StripedBox", x, y);
			if (collidedEntity != null)
			{
				Assets.SenseiSound.play();
				(world as GameWorld).showLevelComplete(numberOfRingsCarrying);
				setFace("up");
				resetTimeline();
				return;
			}
			
			//lock collision
			collidedEntity = collide("Lock", x, y);
			if (collidedEntity != null)
			{
				showDeathAnim();				
				return;
			}
			
			
			
			
			//other collectables
			if (collide("collectables", x, y))
			{
				var items:Tilemap = (world as GameWorld).getLevel().getCollectableEntity().getTilemap();
				var stuffUnder:Array = [];
				stuffUnder.push(items.getTile(x / 16, y / 16));
				stuffUnder.push(items.getTile(x / 16 + 1, y / 16));
				stuffUnder.push(items.getTile(x / 16, y / 16 + 1));
				stuffUnder.push(items.getTile(x / 16 + 1, y / 16 + 1));
				
				square: for (var q:int = 0; q < stuffUnder.length; q++)
				{
					/*if (stuffUnder[q] == 4) //heart
					{
						numberOfHeartsCarrying++;
					}
					else*/ if (stuffUnder[q] == 6) //lock
					{
						continue square;
					}
					else if (stuffUnder[q] == 1) //stripped box
					{
						
					}
					else if (stuffUnder[q] >= 15 && stuffUnder[q] <= 18) //sensei
					{
						(world as GameWorld).showLevelComplete(numberOfRingsCarrying);
						setFace("up");
						resetTimeline();
						Assets.SenseiSound.play();
						return;
					}
					//else if (stuffUnder[q] == 14)
					//{
						//trace("collected ninja : " + ID);
						//continue square;
					//}
					//if (stuffUnder[q] != 14)
					//{
						if (q == 0) items.setTile(x / 16, y / 16, 0);
						if (q == 2) items.setTile(x / 16 + 1, y / 16, 0);
						if (q == 3) items.setTile(x / 16, y / 16 + 1, 0);
						if (q == 4) items.setTile(x / 16 + 1, y / 16 + 1, 0);
					//}
				}
			}
			
			if (velX > 0.5) setFace("right");
			else if (velX < -0.5) setFace("left");
			else if (velY > 0.5) setFace("up");
			else if (velY < -0.5) setFace("up");
			else setFace("idle");
			
			
			instructTime++;
			
			//if its time to get new instruction
			if (instructTime > instructTimeMax)
			{
				instructTime = 0;
				
				//get the instruction and apply it
				handleInstruction();
			}
			
			//add gravity
			velY += GRAVITY;
			
			//cap speed
			if (velY > VEL_Y_MAX)
				velY = VEL_Y_MAX;
			if (velY < -VEL_Y_MAX)
				velY = -VEL_Y_MAX;
				
			//stop moving x if minimal
			if (velX < VEL_X_MIN && velX > -VEL_X_MIN)
				velX = 0;
				
			
			//update position
			x += velX;
			y += velY;
			
			//apply friction
			velX *= FRICTION;
			//velY *= FRICTION;
			
			/* ZOOM + SLOW if approaching sensei [COLLAPSED]
			var senseiLoc:Point = (world as GameWorld).getLevel().senseiLoc;
			var dist:Number = distanceToPoint(senseiLoc.x, senseiLoc.y, true);
			if ( dist <= 80)
			{
				//FP.screen.scale = 1;
				FP.screen.scale = 1 + (80 - dist) / 90
				var guessX:int = (senseiLoc.x + x) / 2 - (720 / 2)/FP.screen.scale// + FP.screen.width / 2;
				var guessY:int = (senseiLoc.y + y) / 2 - (540 / 2) / FP.screen.scale// + FP.screen.height / 2;
				if (guessX > FP.screen.scale * 720-720)
				{
					guessX =  FP.screen.scale * 720 - 720;
				}
				if (guessX < 0) guessX = 0;
				if (guessY > FP.screen.scale * 540-540)
				{
					trace("CAPPED OUT");
					guessY =  FP.screen.scale * 540 - 540;
				}
				if (guessY < 0) guessY = 0;
				FP.camera.x = guessX;
				FP.camera.y = guessY;
				//
				FP.stage.frameRate = 40;
			}
			else if (FP.screen.scale != 1)
			{
				FP.screen.scale = 1;
				FP.resetCamera();
				FP.stage.frameRate = 60;
			}*/
			
			
		}
		
		private function showDeathAnim():void 
		{
			isAnimating = true;
			setFace("dead");
			deadTween = new VarTween(stopAnimation);
			deadTween.tween(graphic, "alpha", 0, 0.3, Ease.cubeIn);
			deadTween.start();
			world.addTween(deadTween, true);
		}
		
		private function stopAnimation():void 
		{
			isAnimating = false;
			resetTimeline();
			world.removeTween(deadTween);
			(graphic as Spritemap).alpha = 1;
		}
		
		public function handleInstruction():void
		{
			//retreive the current instruction
			var instruct:String = (world as GameWorld).getTimeline().getCurrentInstruction();
			
			if (instruct == Instruction.UP)
			{
				//vel boost up
				velY -= 5;
			}
			else if (instruct == Instruction.RIGHT)
			{
				//vel boost right
				velX += 5;
			}
			else if (instruct == Instruction.LEFT)
			{
				//vel boost left
				velX -= 5;
			}
			else if (instruct == Instruction.NONE)
			{
				//do nothing
			}
		}
		
		public function resetTimeline():void
		{
			(world as GameWorld).getTimeline().resetPlaying();
		}
		
		public function reset():void
		{
			setFace("idle");
			
			
			if (Assets.LevelToBeLoaded > 10)
			{
				if(graphic != boxGuyNight)
					graphic = boxGuyNight;
			}
			else if(graphic != boxGuy)
				graphic = boxGuy;

			
			//reposition the player
			
			velX = 0;
			velY = 0;
			numberOfRingsCarrying = 0;
			instructTime = instructTimeMax;
		}
	}

}