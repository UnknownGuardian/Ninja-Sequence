package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelSelectIcon extends Button
	{
		[Embed(source = "assets/menus/Level Select/levelmenu_daylocked.png")]private const DAY_LOCK:Class
		[Embed(source = "assets/menus/Level Select/levelmenu_nightlocked.png")]private const NIGHT_LOCK:Class;
		[Embed(source = "assets/Button Overlays/1_overlay.png")]private const O_1:Class
		[Embed(source = "assets/Button Overlays/2_overlay.png")]private const O_2:Class
		[Embed(source = "assets/Button Overlays/3_overlay.png")]private const O_3:Class
		[Embed(source = "assets/Button Overlays/4_overlay.png")]private const O_4:Class
		[Embed(source = "assets/Button Overlays/5_overlay.png")]private const O_5:Class
		[Embed(source = "assets/Button Overlays/6_overlay.png")]private const O_6:Class
		[Embed(source = "assets/Button Overlays/7_overlay.png")]private const O_7:Class
		[Embed(source = "assets/Button Overlays/8_overlay.png")]private const O_8:Class
		[Embed(source = "assets/Button Overlays/9_overlay.png")]private const O_9:Class
		[Embed(source = "assets/Button Overlays/10_overlay.png")]private const O_10:Class
		[Embed(source = "assets/Button Overlays/11_overlay.png")]private const O_11:Class
		[Embed(source = "assets/Button Overlays/12_overlay.png")]private const O_12:Class
		[Embed(source = "assets/Button Overlays/13_overlay.png")]private const O_13:Class
		[Embed(source = "assets/Button Overlays/14_overlay.png")]private const O_14:Class
		[Embed(source = "assets/Button Overlays/15_overlay.png")]private const O_15:Class
		[Embed(source = "assets/Button Overlays/16_overlay.png")]private const O_16:Class
		[Embed(source = "assets/Button Overlays/17_overlay.png")]private const O_17:Class
		[Embed(source = "assets/Button Overlays/18_overlay.png")]private const O_18:Class
		[Embed(source = "assets/Button Overlays/19_overlay.png")]private const O_19:Class
		[Embed(source = "assets/Button Overlays/20_overlay.png")]private const O_20:Class
		
		private var _isLocked:Boolean = true;
		private var _isDay:Boolean = true;
		private var _data:Object
		private var _closeCallback:Function
		
		private var _group:LevelSelectStarGroup;
		
		public function LevelSelectIcon(day:Boolean = true, locked:Boolean = true, data:Object = null) 
		{
			super(0, 0, 50, 50, clicked);
			_isLocked = locked;
			_isDay = day;
			_data = data;
			
			if (_isLocked)  all = new Image(_isDay? DAY_LOCK:NIGHT_LOCK);
			layer = 10;
			
			_group = new LevelSelectStarGroup();
			updateStars();
		}
		
		override public function added():void
		{
			super.added();
			setCallback(clicked);
			_group.x = x;
			_group.y = y;
			world.add(_group);
		}
		
		public function updateStars():void
		{
			var num:int = Data.readInt("L" + _data.level, 0);
			_group.showStars(num);
		}
		
		public function clicked():void
		{
			if (_isLocked) return;
			_data.callback(this);
		}
		
		public function unlock():void
		{
			if (_isLocked)
			{ 
				all = null;
				_isLocked = false;
				hover = new Image(this["O_" + _data.level]);
			}
		}
		public function lock():void
		{
			if (!_isLocked) { all = new Image(_isDay? DAY_LOCK:NIGHT_LOCK); _isLocked = true; }
		}
		public function isLocked():Boolean
		{
			return _isLocked;
		}
		public function getData():Object
		{
			return _data;
		}
	}

}