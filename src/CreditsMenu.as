package  
{
	import flash.geom.Rectangle;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class CreditsMenu extends Entity 
	{
		[Embed(source = "assets/menus/Main Menu/menu_credits_big.png")]private const CREDITS:Class;
		private var _image:Image;
		public var _canvas:Canvas;
		private var returnBtn:ReturnButton;
		private var _closeCallback:Function
		
		private var ugCredits:CreditsButton;
		private var daCredits:CreditsButton;
		
		public function CreditsMenu(c:Function) 
		{
			_closeCallback = c;
			_image = new Image(CREDITS);
			
			_canvas = new Canvas(FP.screen.width, FP.screen.height);
			_canvas.drawRect(new Rectangle(0, 0, FP.screen.width, FP.screen.height), 0xFFFFFF, 0.5);
			
			addGraphic(_canvas);
			addGraphic(_image);
			
			ugCredits = new CreditsButton(gotoUGSite);
			ugCredits.x = FP.screen.width / 2 - 200 / 2;
			ugCredits.y = FP.screen.height / 2 - 220;
			daCredits = new CreditsButton(gotoDASite);
			daCredits.x = FP.screen.width / 2 - 200 / 2;
			daCredits.y = FP.screen.height / 2 - 145;
			
			returnBtn = new ReturnButton(close);
			returnBtn.x = FP.screen.width / 2 - 152 / 2;
			returnBtn.y = 450;
			
			_image.x = FP.screen.width / 2 - 204/2;
			_image.y = FP.screen.height / 2 - 458/2;
		}
		
		private function gotoUGSite():void 
		{
			navigateToURL(new URLRequest("http://profusiongames.com/blog/"));
			//navigateToURL(new URLRequest("http://profusiongames.com/blog/"));
		}
		private function gotoDASite():void 
		{
			navigateToURL(new URLRequest("http://davidarcila.com/"));
			//navigateToURL(new URLRequest("http://davidarcila.com/"));
		}
		
		public function close():void 
		{
			world.removeList(returnBtn, ugCredits, daCredits, this);
			if (_closeCallback != null)_closeCallback();
		}
		
		override public function added():void
		{
			super.added();
			world.addList(returnBtn, ugCredits, daCredits);
			returnBtn.setCallback(close);
			
			ugCredits.setCallback(gotoUGSite);
			daCredits.setCallback(gotoDASite);
		}
		
	}

}