package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelGlassLayer  extends Entity
	{
		protected var _glassTiles:Tilemap
		public function LevelGlassLayer() 
		{
			_glassTiles = new Tilemap(Assets.LEVEL_TILESET, 720, 464, 16, 16);
			graphic  = _glassTiles;
			layer = 7;
			type = "glass";
			makeGrid();
		}
		
		public function makeGrid():void
		{
			mask = _glassTiles.createGrid(Level.GlassNumbers);
		}
		public function getTilemap():Tilemap
		{
			return _glassTiles;
		}
		
	}

}