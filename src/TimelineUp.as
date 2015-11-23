package  
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TimelineUp extends Button
	{
		[Embed(source="assets/Timeline/timeline_up.png")]private const NORMAL:Class;
		public function TimelineUp() 
		{
			super(652, 478, 24, 24, pressed);
			normal = new Image(NORMAL);
			hover = new Image(NORMAL);
			down = new Image(NORMAL);
			inactive = new Image(NORMAL);
			layer = 20;
		}
		
		private function pressed():void 
		{
			(world as GameWorld).getTimeline().appendInstruction(Instruction.UP);
		}
		
	}

}