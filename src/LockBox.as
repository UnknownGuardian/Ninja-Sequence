package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LockBox extends Entity
	{
		public var anim:Spritemap = new Spritemap(Assets.LEVEL_TILESET, 16, 16);
		public function LockBox() 
		{
			anim.setFrame(6);
			graphic = anim;
			
			type = "Lock";
			
			setHitbox(16, 16);
			layer = 6;
		}
		
	}

}