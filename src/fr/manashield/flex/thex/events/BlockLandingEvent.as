package fr.manashield.flex.thex.events {
	import fr.manashield.flex.thex.blocks.Block;
	import flash.events.Event;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class BlockLandingEvent extends Event
	{
		public static const LANDING:String = "blockLanding";
		
		protected var _block:Block;
		
		public function BlockLandingEvent(block:Block = null):void
		{
			this._block = block;
			super(LANDING);
		}
		
		public function get block():Block
		{
			return this._block;
		}
	}
}
