package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class CreditsButton extends Button 
	{
		[Embed(source = "assets/menus/Main Menu/CreditButton.png")] private const SOLID:Class;
		[Embed(source = "assets/menus/Main Menu/CreditButtonClear.png")] private const OVERLAY:Class;
		private var _image:Image;
		public function CreditsButton(callback:Function) 
		{
			super(0, 0, 200, 60, callback);
			all = new Image(OVERLAY);
			_image = new Image(SOLID);
			_image.alpha = 0.2;
			hover = _image;
			//(hover as Image).alpha = 0.5;
		}
		
	}

}