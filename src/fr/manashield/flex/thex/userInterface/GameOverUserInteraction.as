package fr.manashield.flex.thex.userInterface {
	import flash.events.EventDispatcher;
	import flash.display.Stage;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class GameOverUserInteraction extends UserInteraction
	{
		public function GameOverUserInteraction(stage:Stage, eventDispatcher:EventDispatcher = null):void
		{
			super(stage, eventDispatcher);
		}
		
		public override function isAbstract():Boolean
		{
			return false;
		}
	}
}
