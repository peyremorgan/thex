package fr.manashield.flex.thex.userInterface 
{
	import fr.manashield.flex.thex.events.ForceFallEvent;
	import fr.manashield.flex.thex.events.RotateBlockEvent;

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class IngameUserInteraction extends UserInteraction 
	{
		public function IngameUserInteraction(stage:Stage):void
		{
			super(true, stage);
		}
		
		public override function isAbstract():Boolean
		{
			return false;
		}
		
		override public function keyPressed(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.RIGHT:
				this.localEventDispatcher.dispatchEvent(new RotateBlockEvent(RotateBlockEvent.ROTATE_CW));
				break;
				
				case Keyboard.LEFT:
				this.localEventDispatcher.dispatchEvent(new RotateBlockEvent(RotateBlockEvent.ROTATE_CCW));
				break;
				
				case Keyboard.DOWN:
				this.localEventDispatcher.dispatchEvent(new ForceFallEvent());
			}
		}
	}
}
