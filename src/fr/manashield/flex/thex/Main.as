package fr.manashield.flex.thex 
{
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="600",height="400",backgroundColor="#ffffff")]
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Main extends Sprite 
	{
		public function Main() : void 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e : Event = null) : void 
		{
			// Entry point
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			new Game(stage);
		}
	}
}