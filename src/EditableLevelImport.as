package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class EditableLevelImport extends Button
	{
		[Embed(source = "assets/editor/import.png")]private const IMPORT:Class;
		
		public function EditableLevelImport() 
		{
			super(720-51, 48, 50, 19, createLevel);
			all = new Image(IMPORT);
		}
		
		private function createLevel():void 
		{
			var w:GameWorld = world as GameWorld;
			if ( w.getLevel() is EditableLevel && (w.getLevel() as EditableLevel).textExport.text.length > 100)
			{
				w.getTimeline().savedLevelData = (w.getLevel() as EditableLevel).textExport.text;
				(w.getLevel() as EditableLevel).importLevel(w.getTimeline().savedLevelData);
				(w.getLevel() as EditableLevel).textExport.text = "Imported Level!";
			}
		}
		
	}

}