package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelCollectableLayer  extends Entity
	{
		protected var _collectableTiles:Tilemap
		public function LevelCollectableLayer() 
		{
			_collectableTiles = new Tilemap(Assets.LEVEL_TILESET, 720, 464, 16, 16);
			graphic  = _collectableTiles;
			layer = 7;
			type = "collectables";
			makeGrid();
		}
		public function makeGrid():void
		{
			mask = _collectableTiles.createGrid(Level.CollectableNumbers);
		}
		public function getTilemap():Tilemap
		{
			return _collectableTiles;
		}
		
	}

}