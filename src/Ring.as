package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Ring extends Entity
	{
		[Embed(source = "assets/tiles/ss_ring_16x16.png")]private const FRAMES:Class;
		public var anim:Spritemap = new Spritemap(FRAMES, 16, 16);
		public function Ring() 
		{
			anim.add("rotate", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 20, true);
			graphic = anim;
			anim.play("rotate");
			
			type = "ring";
			
			setHitbox(16, 16);
			layer = 6;
		}
		
	}

}