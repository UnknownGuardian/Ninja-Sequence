package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class StripedBox extends Entity 
	{
		
		public var anim:Spritemap = new Spritemap(Assets.LEVEL_TILESET, 16, 16);
		public function StripedBox() 
		{
			anim.setFrame(1);
			graphic = anim;
			
			type = "StripedBox";
			
			setHitbox(16, 16);
			layer = 6;
		}
		
	}

}