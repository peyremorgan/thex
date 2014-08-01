package fr.manashield.flex.thex.events {
	import flash.events.Event;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class PauseEvent extends Event
	{
		public static const PAUSE:String = "pause";
		public static const RESUME:String = "resume";
		
		public function PauseEvent(type:String = PAUSE, bubbles:Boolean = false, cancelable:Boolean = false):void
		{
			super(type, bubbles, cancelable);
		}
	}
}
