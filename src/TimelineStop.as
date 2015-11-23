package  
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TimelineStop extends Button
	{
		[Embed(source="assets/Timeline/timeline_stop.png")]private const NORMAL:Class;
		public function TimelineStop() 
		{
			super(652, 506, 53, 18, pressed);
			normal = new Image(NORMAL);
			hover = new Image(NORMAL);
			down = new Image(NORMAL);
			inactive = new Image(NORMAL);
			layer = 20;
		}
		
		private function pressed():void 
		{
			(world as GameWorld).getTimeline().resetPlaying();
		}
		
	}

}