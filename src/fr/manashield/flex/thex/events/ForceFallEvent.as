package fr.manashield.flex.thex.events {
	import flash.events.Event;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class ForceFallEvent extends Event
	{
		public static const FORCE_FALL:String = "forceFall";
		
		public function ForceFallEvent():void
		{
			super(FORCE_FALL);
		}
	}
}
