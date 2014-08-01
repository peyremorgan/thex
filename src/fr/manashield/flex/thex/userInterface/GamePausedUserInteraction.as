package fr.manashield.flex.thex.userInterface {
	import fr.manashield.flex.thex.events.ResumeEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;

	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class GamePausedUserInteraction extends UserInteraction
	{
		public function GamePausedUserInteraction(stage:Stage, eventDispatcher:EventDispatcher = null):void
		{
			super(stage, eventDispatcher);
		}
		
		public override function isAbstract():Boolean
		{
			return false;
		}
		
		public override function resume():UserInteraction
		{
			return new IngameUserInteraction(_stage, _localEventDispatcher);
		}
		
		override public function keyPressed(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.ESCAPE:
				ThexEventDispatcher.instance.dispatchEvent(new ResumeEvent());
				break;
			}
		}
	}
}
