package fr.manashield.flex.thex.events {
	import flash.events.Event;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class RotateBlockEvent extends Event
	{
		public static const ROTATE_CW:String = "blockRotateClockwise";
		public static const ROTATE_CCW:String = "blockRotateCounterClockwise";
		
		public function RotateBlockEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
