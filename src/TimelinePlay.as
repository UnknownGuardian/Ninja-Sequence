package  
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TimelinePlay extends Button
	{
		[Embed(source="assets/Timeline/timeline_play.png")]private const NORMAL:Class;
		public function TimelinePlay() 
		{
			super(592, 506, 53, 18, pressed);
			normal = new Image(NORMAL);
			hover = new Image(NORMAL);
			down = new Image(NORMAL);
			inactive = new Image(NORMAL);
			layer = 20;
		}
		
		private function pressed():void 
		{
			(world as GameWorld).getTimeline().startPlaying();
		}
		
	}

}