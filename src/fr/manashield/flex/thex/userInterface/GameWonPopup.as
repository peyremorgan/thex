package fr.manashield.flex.thex.userInterface {
	import flash.display.Stage;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class GameWonPopup extends GameOverPopup
	{
		public function GameWonPopup(stage:Stage):void
		{
			super(stage);
		}
		
		protected override function titleMessage():String
		{
			return "CONGRATULATIONS";
		}
	}
}
