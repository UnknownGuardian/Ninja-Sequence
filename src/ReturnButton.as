package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class ReturnButton extends Button 
	{
		[Embed(source = "assets/menus/button_back.png")]private const RETURN:Class;
		[Embed(source="assets/Button Overlays/button_back_overlay.png")]private const RETURN_O:Class;
		public function ReturnButton(callback:Function) 
		{
			super(0, 0, 152, 33, callback);
			all = new Image(RETURN);
			hover = new Image(RETURN_O);
		}
		
	}

}