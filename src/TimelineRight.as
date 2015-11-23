package  
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TimelineRight extends Button
	{
		[Embed(source="assets/Timeline/timeline_right.png")]private const NORMAL:Class;
		public function TimelineRight() 
		{
			super(681, 478, 24, 24, pressed);
			normal = new Image(NORMAL);
			hover = new Image(NORMAL);
			down = new Image(NORMAL);
			inactive = new Image(NORMAL);
			layer = 20;
		}
		
		private function pressed():void 
		{
			(world as GameWorld).getTimeline().appendInstruction(Instruction.RIGHT);
		}
		
	}

}