package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class InstructionsMenu extends Entity
	{
		[Embed(source = "assets/menus/Instructions/ins_1.png")]private const IN1:Class;
		[Embed(source = "assets/menus/Instructions/ins_2.png")]private const IN2:Class;
		[Embed(source = "assets/menus/Instructions/ins_3.png")]private const IN3:Class;
		[Embed(source = "assets/menus/Instructions/ins_4.png")]private const IN4:Class;
		[Embed(source = "assets/menus/Instructions/ins_5.png")]private const IN5:Class;
		[Embed(source = "assets/menus/Instructions/instructions_left_arrow.png")]private var LEFT_ARROW:Class;
		[Embed(source = "assets/menus/Instructions/instructions_right_arrow.png")]private var RIGHT_ARROW:Class;
		[Embed(source = "assets/Button Overlays/instructions_left_arrow_overlay.png")]private var LEFT_ARROW_O:Class;
		[Embed(source="assets/Button Overlays/instructions_right_arrow_overlay.png")]private var RIGHT_ARROW_O:Class;
		
		
		private var image1:Image;
		private var image2:Image;
		private var image3:Image;
		private var image4:Image;
		private var image5:Image;
		private var _canvas:Canvas;
		private var currentInstruction:int = 1;
		private var _leftBtn:Button;
		private var _rightBtn:Button;
		public function InstructionsMenu() 
		{
			image1 = new Image(IN1);
			image2 = new Image(IN2);
			image3 = new Image(IN3);
			image4 = new Image(IN4);
			image5 = new Image(IN5);
			
			
			_canvas = new Canvas(FP.screen.width, FP.screen.height);
			_canvas.drawRect(new Rectangle(0, 0, FP.screen.width, FP.screen.height), 0xFFFFFF, 0.25);
			
			addGraphic(_canvas);
			addGraphic(image1);
			image1.x = image2.x = image3.x = image4.x = image5.x = FP.screen.width / 2 - 476 / 2;
			image1.y = image2.y = image3.y = image4.y = image5.y = FP.screen.height / 2 - 322 / 2;
			
			_leftBtn = new Button(0, 0, 50, 50, gotoPrevious);
			_rightBtn = new Button(0, 0, 50, 50, gotoNext);
			
			_leftBtn.x = 50;
			_rightBtn.x = FP.screen.width -50 - _rightBtn.width;
			
			_leftBtn.y = FP.screen.height / 2 - _leftBtn.height / 2;
			_rightBtn.y = FP.screen.height / 2 - _rightBtn.height / 2;
			
			_leftBtn.all = new Image(LEFT_ARROW);
			_leftBtn.hover = new Image(LEFT_ARROW_O);
			_rightBtn.all = new Image(RIGHT_ARROW);
			_rightBtn.hover = new Image(RIGHT_ARROW_O);
			
			layer = 1;
			
			
		}
		
		override public function added():void
		{
			world.addList(_leftBtn, _rightBtn);
		}
		
		override public function update():void
		{
			if (Input.released(Key.RIGHT) || Input.released(Key.D)) gotoNext();
			if (Input.released(Key.LEFT) || Input.released(Key.A)) gotoPrevious();
		}
		
		public function gotoNext():void
		{
			if(currentInstruction < 6)
				currentInstruction++;
			if (currentInstruction == 2)
			{
				(graphic as Graphiclist).remove(image1);
				addGraphic(image2);
			}
			else if (currentInstruction == 3)
			{
				(graphic as Graphiclist).remove(image2);
				addGraphic(image3);
			}
			else if (currentInstruction == 4)
			{
				(graphic as Graphiclist).remove(image3);
				addGraphic(image4);
			}
			else if (currentInstruction == 5)
			{
				(graphic as Graphiclist).remove(image4);
				addGraphic(image5);
			}
			else if (currentInstruction == 6)
			{
				//TODO: remove go to game
				world.removeList(this, _leftBtn, _rightBtn);
			}
		}
		public function gotoPrevious():void
		{
			if(currentInstruction > 1)
				currentInstruction--;
			if (currentInstruction == 1)
			{
				(graphic as Graphiclist).remove(image2);
				addGraphic(image1);
			}
			else if (currentInstruction == 2)
			{
				(graphic as Graphiclist).remove(image3);
				addGraphic(image2);
			}
			else if (currentInstruction == 3)
			{
				(graphic as Graphiclist).remove(image4);
				addGraphic(image3);
			}
			else if (currentInstruction == 4)
			{
				(graphic as Graphiclist).remove(image5);
				addGraphic(image4);
			}
		}
		
	}

}