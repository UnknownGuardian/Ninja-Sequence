package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelSpikeLayer extends Entity
	{
		protected var _spikeTiles:Tilemap
		public function LevelSpikeLayer() 
		{
			_spikeTiles = new Tilemap(Assets.LEVEL_TILESET, 720, 464, 16, 16);
			graphic  = _spikeTiles;
			layer = 7;
			type = "spikes";
			makeGrid();
		}
		
		public function makeGrid():void
		{
			mask = _spikeTiles.createGrid(Level.SpikeNumbers);
		}
		public function getTilemap():Tilemap
		{
			return _spikeTiles;
		}
		
	}

}