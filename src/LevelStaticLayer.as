package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelStaticLayer extends Entity
	{
		protected var _staticTiles:Tilemap
		public function LevelStaticLayer() 
		{
			_staticTiles = new Tilemap(Assets.LEVEL_TILESET, 720, 464, 16, 16);
			graphic  = _staticTiles;
			type = "static";
			layer = 7;
			_staticTiles.setRect(0, 0, 99, 99, 0);
			_staticTiles.setRect(4, 4, 720 / 16-8, 1, 3);
			_staticTiles.setRect(4, 24, 720 / 16-8, 1, 3);
			_staticTiles.setRect(4, 5, 1, 19, 3);
			_staticTiles.setRect(720 / 16-5, 5, 1, 19, 3);
			
			makeGrid();
		}
		public function makeGrid():void
		{
			mask = _staticTiles.createGrid(Level.StaticNumbers);
		}
		public function getTilemap():Tilemap
		{
			return _staticTiles;
		}
	}

}