package fr.manashield.flex.thex.userInterface {
	import flash.display.Stage;
	import flash.events.EventDispatcher;
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
