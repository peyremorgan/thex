package fr.manashield.flex.thex.events {
	import flash.events.Event;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class BlockLandingEvent extends Event
	{
		public static const LANDING:String = "blockLanding";
		
		public function BlockLandingEvent():void
		{
			super(LANDING);
		}
	}
}
