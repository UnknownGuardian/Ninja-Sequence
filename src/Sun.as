package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Sun extends Entity 
	{
		//[Embed(source = "assets/Backgrounds/sun.png")]private const SUN:Class;
		[Embed(source="assets/Backgrounds/extra_pix_sun.png")]private const SUN:Class;
		[Embed(source="assets/Backgrounds/extra_pix_moon.png")]private const MOON:Class;
		public var sunImage:Image;
		public var moonImage:Image;
		public function Sun() 
		{
			sunImage = new Image(SUN);
			moonImage = new Image(MOON);
			graphic = sunImage;
			layer = 850;
			
			x = 34 * 16;
			y = 2 * 16;
		}
		
		override public function added():void
		{
			change();
		}
		
		public function change():void
		{
			if (world is GameWorld && Assets.LevelToBeLoaded > 10)
			{
				graphic = moonImage;
			}
			else
				graphic = sunImage;
		}
		
	}

}