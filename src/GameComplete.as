package  
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class GameComplete extends Entity
	{
		[Embed(source = "assets/menus/Level Complete/ninja_ending.png")]private const BG:Class;
		private var _canvas:Canvas;
		private var backgroundGraphic:Image
		
		private var replayBtn:Button;
		private var levelSelectBtn:Button;
		private var nextBtn:Button;
		
		private var _closeCallback:Function
		public function GameComplete(c:Function) 
		{
			
		}
		
	}

}