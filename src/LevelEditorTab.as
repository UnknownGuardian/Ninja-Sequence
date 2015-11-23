package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelEditorTab extends Button
	{
		[Embed(source = "assets/editor/editor_tile_tab.png")]private const TAB:Class;
		
		private var _allTiles:Vector.<LevelEditorTile> = new Vector.<LevelEditorTile>();
		public function LevelEditorTab() 
		{
			normal = new Image(TAB);
			hover = new Image(TAB);
			down = new Image(TAB);
			//inactive = new Image(TAB);
			
			layer = 1;
			
			
			
			setHitbox(172, 23, -273, -24);
			setOverCall(openTab);
		}
		
		override public function added():void
		{
			populateTiles();
			closeTab();
		}
		
		private function openTab():void 
		{
			y = 0;
			for (var i:int = 0; i < _allTiles.length; i++)
			{
				_allTiles[i].y = 4
			}
		}
		private function closeTab():void 
		{
			y = -23;
			for (var i:int = 0; i < _allTiles.length; i++)
			{
				_allTiles[i].y = -23 + 4
			}
		}
		
		override public function update():void
		{
			super.update();
			if (Input.mouseY > 80 && y == 0)
			{
				closeTab();
			}
		}
		
		private function populateTiles():void
		{
			var t0:LevelEditorTile = new LevelEditorTile(12+20*0,4,0);
			world.add(t0);
			_allTiles[0] = t0;
			for (var i:int = 1; i < 19; i++) //skip transparent tile
			{
				var t:LevelEditorTile = new LevelEditorTile(12+20*i,4,i);
				world.add(t);
				_allTiles[i] = t;
				if (i == 1)
				{
					selectCurrentTile(t);
				}
			}
		}
		
		public function unselectCurrentTile():void
		{
			for (var i:int = 0; i < _allTiles.length; i++)
			{
				_allTiles[i].getTiles().tinting = 0;
			}
		}
		public function selectCurrentTile(t:LevelEditorTile):void
		{
			t.getTiles().tinting = 0.5;
			t.getTiles().tintMode = 1;
		}
	}

}