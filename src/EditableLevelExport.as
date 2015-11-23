package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class EditableLevelExport extends Button
	{
		[Embed(source = "assets/editor/export.png")]private const EXPORT:Class;
		
		public function EditableLevelExport() 
		{
			super(720-51, 26, 50, 19, copyToClipboard);
			all = new Image(EXPORT);
		}
		
		private function copyToClipboard():void 
		{
			(world as GameWorld).getLevel().exportLevel();
		}
		
	}

}