package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Cloud extends Entity
	{
		//[Embed(source = "assets/Backgrounds/cloud.png")]private const CLOUD:Class
		[Embed(source="assets/Backgrounds/pixelated_cloud.png")]private const CLOUD:Class
		[Embed(source="assets/Backgrounds/pixelated_star.png")]private const STAR:Class
		private var cloudImage:Image;
		private var starImage:Image;
		private var moveDelay:int = 0;
		private var moveDelayMax:int = int(Math.random() * 20) + 40;
		
		private var speed:Number = int(Math.random() * 3) * 0.5 + 1;
		private var _shouldMove:Boolean = false;
		
		private var alpha:Number = Math.random();
		private var fadingIn:Boolean = false;
		
		private var toggle:Boolean = false;
		public function Cloud() 
		{
			cloudImage = new Image(CLOUD);
			starImage = new Image(STAR);
			graphic = cloudImage
			layer = 800;
		}
		
		override public function update():void
		{
			super.update();
			
			if (toggle) {
				if (graphic == cloudImage)
				{
					moveDelay++;
					if (moveDelay > moveDelayMax)
					{
						moveDelay = 0;
						moveDelayMax = int(Math.random() * 20) + 40;
						x -= 16;
						if (x + 116 < 0) x = FP.screen.width + 16;
					}
				}
				else if(graphic == starImage)
				{
					//trace("fading teh star");
					if (fadingIn) alpha += 0.02;
					else alpha -= 0.02;
					if (alpha > 1) { alpha = 1; fadingIn = false; }
					if (alpha < 0) { alpha = 0; fadingIn = true; }
					starImage.alpha = alpha;
				}
			}
			else
			{
			
				_shouldMove = !_shouldMove;
				if (_shouldMove)
				{
					x -= speed;
					if (x + 100 < -5) x = FP.screen.width + 5;
				}
			}
			
			if (Input.released(Key.T))
				toggle = !toggle;
		}
		
		override public function added():void
		{
			change();
		}
		
		public function change():void
		{
			if (world is GameWorld && Assets.LevelToBeLoaded > 10)
			{
				graphic = starImage;
				toggle = true;
			}
			else
			{
				if (world is GameWorld)	toggle = true;
				else 					toggle = false;
				graphic = cloudImage;
			}
		}
		
	}

}