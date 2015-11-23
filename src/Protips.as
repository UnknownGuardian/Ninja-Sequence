package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Protips extends Entity
	{
		[Embed(source = "assets/menus/Instructions/protips.png")]private const TIPS:Class;
		[Embed(source="assets/menus/Instructions/instructions_right_arrow.png")]private var RIGHT_ARROW:Class;
		private var image1:Image;
		private var _canvas:Canvas;
		private var _rightBtn:Button;
		public function Protips() 
		{
			image1 = new Image(TIPS);
			image1.x = FP.screen.width / 2 - 476 / 2;
			image1.y = FP.screen.height / 2 - 322 / 2;
			
			_canvas = new Canvas(FP.screen.width, FP.screen.height);
			_canvas.drawRect(new Rectangle(0, 0, FP.screen.width, FP.screen.height), 0xFFFFFF, 0.25);
			
			addGraphic(_canvas);
			addGraphic(image1);
			
			
			_rightBtn = new Button(0, 0, 50, 50, close);
			_rightBtn.x = FP.screen.width -50 - _rightBtn.width;
			_rightBtn.y = FP.screen.height / 2 - _rightBtn.height / 2;
			_rightBtn.all = new Image(RIGHT_ARROW);
			
			layer = 1;
		}
		override public function added():void
		{
			world.add(_rightBtn);
		}
		override public function update():void
		{
			if (Input.released(Key.RIGHT) || Input.released(Key.D)) close();
		}
		public function close():void
		{
			world.removeList(this, _rightBtn);
		}
	}

}