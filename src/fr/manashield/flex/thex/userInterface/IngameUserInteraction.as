package fr.manashield.flex.thex.userInterface 
{
	import fr.manashield.flex.thex.events.RotateBlockEvent;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;

	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class IngameUserInteraction extends UserInteraction 
	{
		public function IngameUserInteraction() 
		{
			this.isAbstract = false;
			super();
		}
		
		override function keyPressed(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.RIGHT:
				this.localEventDispatcher.dispatchEvent(new RotateBlockEvent(RotateBlockEvent.ROTATE_CW));
				break;
				
				case Keyboard.LEFT:
				this.localEventDispatcher.dispatchEvent(new RotateBlockEvent(RotateBlockEvent.ROTATE_CCW));
				break;
			}
		}
	}
}
