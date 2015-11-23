package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class FarBackground extends Entity 
	{
		[Embed(source = "assets/Backgrounds/bkg_day.png")]private const BACKGROUND_SKY:Class;
		[Embed(source = "assets/Backgrounds/bkg_night.png")]private const BACKGROUND_NIGHT:Class;
		[Embed(source = "assets/Backgrounds/bkg_day_grid.png")]private const BACKGROUND_SKY_GRID:Class;
		[Embed(source = "assets/Backgrounds/bkg_night_grid.png")]private const BACKGROUND_NIGHT_GRID:Class;
		public var dayImage:Image;
		public var nightImage:Image;
		public var dayGridImage:Image;
		public var nightGridImage:Image;
		private var _useGrid:Boolean = false;
		private var _isDay:Boolean = true;
		
		private var ID:int = int(Math.random() * 9999);
		
		public function FarBackground(isDay:Boolean=true, useGrid:Boolean=false) 
		{
			_isDay = isDay;
			_useGrid = _useGrid;
			
			dayImage = new Image(BACKGROUND_SKY);
			nightImage = new Image(BACKGROUND_NIGHT);
			dayGridImage = new Image(BACKGROUND_SKY_GRID);
			nightGridImage = new Image(BACKGROUND_NIGHT_GRID);
			
			if(!useGrid && isDay)
				graphic = dayImage;
			else if(useGrid && isDay)
				graphic = dayGridImage;
			else if(!useGrid && !isDay)
				graphic = nightImage;
			else if(useGrid && !isDay)
				graphic = nightGridImage;
			layer = 999;
		}
		
		override public function update():void
		{
			if (Input.released(Key.N))
			{
				toggleDay();
			}
			if (Input.released(Key.G))
			{
				toggleGrid();
			}
			
			if (Assets.LevelToBeLoaded > 10 && !(world is MainMenu) && !(world is LevelSelectMenu))
			{
				if(graphic != nightImage)
					graphic = nightImage;
			}
			else if(graphic != dayImage)
				graphic = dayImage;
		}
		
		public function change():void
		{
			//trace("xxx " + (world is MainMenu) + (world is GameWorld) + (world is LevelSelectMenu));
			if (!(world is MainMenu) && !(world is LevelSelectMenu)&& Assets.LevelToBeLoaded > 10)
			{
				graphic = nightImage;
			}
			else
				graphic = dayImage;
		}
		
		public function changeToNight(useGrid:Boolean = false):void
		{
			_isDay = false;
			_useGrid = useGrid;
			if(!_useGrid && _isDay)
				graphic = dayImage;
			else if(_useGrid && _isDay)
				graphic = dayGridImage;
			else if(!_useGrid && !_isDay)
				graphic = nightImage;
			else if(_useGrid && !_isDay)
				graphic = nightGridImage;
			
		}
		public function changeToDay(useGrid:Boolean = false):void
		{
			_isDay = true;
			_useGrid = useGrid;
			if(!_useGrid && _isDay)
				graphic = dayImage;
			else if(_useGrid && _isDay)
				graphic = dayGridImage;
			else if(!_useGrid && !_isDay)
				graphic = nightImage;
			else if(_useGrid && !_isDay)
				graphic = nightGridImage;
		}
		public function toggleDay():void
		{
			_isDay = !_isDay;
			if(!_useGrid && _isDay)
				graphic = dayImage;
			else if(_useGrid && _isDay)
				graphic = dayGridImage;
			else if(!_useGrid && !_isDay)
				graphic = nightImage;
			else if(_useGrid && !_isDay)
				graphic = nightGridImage;
		}
		public function toggleGrid():void
		{
			_useGrid = !_useGrid;
			if(!_useGrid && _isDay)
				graphic = dayImage;
			else if(_useGrid && _isDay)
				graphic = dayGridImage;
			else if(!_useGrid && !_isDay)
				graphic = nightImage;
			else if(_useGrid && !_isDay)
				graphic = nightGridImage;
		}
		
	}

}