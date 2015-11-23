package  
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TimelineNone extends Button
	{
		[Embed(source="assets/Timeline/timeline_none.png")]private const NORMAL:Class;
		public function TimelineNone() 
		{
			super(592, 478, 24, 24, pressed);
			normal = new Image(NORMAL);
			hover = new Image(NORMAL);
			down = new Image(NORMAL);
			inactive = new Image(NORMAL);
			layer = 20;
		}
		
		private function pressed():void 
		{
			(world as GameWorld).getTimeline().appendInstruction(Instruction.NONE);
		}
		
	}

}