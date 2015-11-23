package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelEditorTile extends Button
	{
		private var _tiles:Spritemap = new Spritemap(Assets.LEVEL_TILESET, 16, 16);
		public function LevelEditorTile(X:Number = 0,Y:Number = 0, FrameNum:uint = 0) 
		{
			super(X, Y , 16, 16, changeCurrentTile);
			_tiles.setFrame(FrameNum);
			normal = _tiles;
			hover = _tiles;
			down = _tiles;
		}
		
		public function changeCurrentTile():void
		{
			((world as GameWorld).getLevel() as EditableLevel).setCurrentTile(this);
		}
		
		public function getTiles():Spritemap
		{
			return _tiles;
		}
		
	}

}