package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class BonusButton extends Button 
	{
		[Embed(source = "assets/menus/Level Select/bonus.png")]private const BONUS:Class;
		public var _image:Image;
		private var _data:Object = { level:"99" };
		private var _group:LevelSelectStarGroup;
		public function BonusButton(f:Function) 
		{
			super(0, 0, 118, 50);
			_image = new Image(BONUS);
			all = _image;
			_data.callback = f;
			
			_group = new LevelSelectStarGroup(true);
			updateStars();
		}
		
		override public function added():void
		{
			_group.x = x;
			_group.y = y;
			world.add(_group);
			
			checkIfUnlocked();
		}
		
		public function checkIfUnlocked():void
		{
			if (Assets.checkIfAllLevelsBeatFully())
			{
				alpha = 1;
				setCallback(clicked);
			}
			else
				alpha = 0.50;
		}
		
		private function clicked():void 
		{
			_data.callback(this);
		}
		public function getData():Object
		{
			return _data;
		}
		
		public function updateStars():void 
		{
			var num:int = Data.readInt("L" + _data.level, 0);
			_group.showStars(num);
		}
		
	}

}