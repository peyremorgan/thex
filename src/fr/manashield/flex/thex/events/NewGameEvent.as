package fr.manashield.flex.thex.events {
	import flash.events.Event;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class NewGameEvent extends Event
	{
		public static const NEW_GAME:String = "newGame";
		
		public function NewGameEvent(type:String = NEW_GAME, bubbles:Boolean = false, cancelable:Boolean = false):void
		{
			super(type, bubbles, cancelable);
		}
	}
}
