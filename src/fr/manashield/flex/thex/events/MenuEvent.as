package fr.manashield.flex.thex.events {
	import flash.events.Event;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class MenuEvent extends Event
	{
		public static const PREVIOUS_ITEM:String = "previousItem";
		public static const NEXT_ITEM:String = "nextItem";
		public static const SELECT:String = "select";
		public static const MENU:String = "menu";
		
		public function MenuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void
		{
			super(type, bubbles, cancelable);
		}
	}
}
