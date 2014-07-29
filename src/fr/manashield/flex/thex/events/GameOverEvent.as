package fr.manashield.flex.thex.events {
	import flash.events.Event;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class GameOverEvent extends Event
	{
		public static const GAME_LOST:String = "gameLost";
		public static const GAME_WON:String = "gameWon";
		
		public function GameOverEvent(type:String = GAME_LOST, bubbles:Boolean = false, cancelable:Boolean = false):void
		{
			super(type, bubbles, cancelable);
		}
	}
}
