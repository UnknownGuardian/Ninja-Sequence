package  
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TimelineLeft extends Button
	{
		[Embed(source="assets/Timeline/timeline_left.png")]private const NORMAL:Class;
		public function TimelineLeft() 
		{
			super(621, 478, 24, 24, pressed);
			normal = new Image(NORMAL);
			hover = new Image(NORMAL);
			down = new Image(NORMAL);
			inactive = new Image(NORMAL);
			layer = 20;
		}
		
		private function pressed():void 
		{
			(world as GameWorld).getTimeline().appendInstruction(Instruction.LEFT);
		}
		
	}

}