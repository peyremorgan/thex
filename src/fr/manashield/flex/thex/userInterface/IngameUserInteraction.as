package fr.manashield.flex.thex.userInterface 
{
	import fr.manashield.flex.thex.events.ThexEventDispatcher;
	import fr.manashield.flex.thex.events.ForceFallEvent;
	import fr.manashield.flex.thex.events.PauseEvent;
	import fr.manashield.flex.thex.events.RotateBlockEvent;

	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class IngameUserInteraction extends UserInteraction 
	{
		public function IngameUserInteraction(stage:Stage, eventDispatcher:EventDispatcher = null):void
		{
			super(stage, eventDispatcher);
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
				this._localEventDispatcher.dispatchEvent(new RotateBlockEvent(RotateBlockEvent.ROTATE_CW));
				break;
				
				case Keyboard.LEFT:
				this._localEventDispatcher.dispatchEvent(new RotateBlockEvent(RotateBlockEvent.ROTATE_CCW));
				break;
				
				case Keyboard.DOWN:
				this._localEventDispatcher.dispatchEvent(new ForceFallEvent());
				break;
				
				case Keyboard.ESCAPE:
				ThexEventDispatcher.instance.dispatchEvent(new PauseEvent());
				break;
			}
		}
		
		public override function pause():UserInteraction
		{
			removeEventListeners(_stage);
			
			return new GamePausedUserInteraction(_stage, _localEventDispatcher);
		}
	}
}
