package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Title extends Entity 
	{
		//[Embed(source="assets/menus/Main Menu/NS_JFX_intro.png")]public const TITLE:Class;
		//[Embed(source = "assets/menus/Main Menu/mainmenu_title.png")]public const TITLE:Class;
		[Embed(source="assets/menus/Main Menu/new_intro.png")]public const TITLE:Class;
		public function Title() 
		{
			graphic = new Image(TITLE);
			
			layer = 805;
		}
		
	}

}