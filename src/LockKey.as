package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LockKey extends Entity 
	{
		public var anim:Spritemap = new Spritemap(Assets.LEVEL_TILESET, 16, 16);
		public function LockKey() 
		{
			anim.setFrame(5);
			graphic = anim;
			
			type = "Key";
			
			setHitbox(16, 16);
			layer = 6;
		}
		
	}

}