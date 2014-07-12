package fr.manashield.flex.thex 
{
	import fr.manashield.flex.thex.events.RotateBlockEvent;

	import fr.manashield.flex.thex.userInterface.IngameUserInteraction;
	import fr.manashield.flex.thex.userInterface.UserInteraction;
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="1200",height="600",backgroundColor="#ffffff")]
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Main extends Sprite 
	{
		protected var _currentUI:UserInteraction;
		
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
			
			_currentUI = new IngameUserInteraction(stage);
			
			_currentUI.addEventListener(RotateBlockEvent.ROTATE_CW, Animation.instance.moveBlocksClockwise);
			_currentUI.addEventListener(RotateBlockEvent.ROTATE_CCW, Animation.instance.moveBlocksCounterClockwise);
		}
	}
}