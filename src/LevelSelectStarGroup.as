package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelSelectStarGroup extends Entity
	{
		[Embed(source = "assets/menus/Level Select/star.png")]private const STAR:Class;
		private var star1:Image
		private var star2:Image
		private var star3:Image
		public function LevelSelectStarGroup(farSpread:Boolean = false) 
		{
			star1 = new Image(STAR);
			star2 = new Image(STAR);
			star3 = new Image(STAR);
			if (!farSpread)
			{
				star1.x = 0 + 1;
				star2.x = 16 + 1;
				star3.x = 32 + 1;
			}
			else
			{
				star1.x = 0 + 1;
				star2.x = 51 + 1;
				star3.x = 101 + 1;
			}
			star1.y = star2.y = star3.y = 32 + 1;
			
			addGraphic(star1);
			addGraphic(star2);
			addGraphic(star3);
		}
		
		public function showStars(amount:int):void
		{
			(graphic as Graphiclist).remove(star1);
			(graphic as Graphiclist).remove(star2);
			(graphic as Graphiclist).remove(star3);
			
			if(amount > 0) addGraphic(star1);
			if(amount > 1) addGraphic(star2);
			if (amount > 2) addGraphic(star3);
		}
		
	}

}