package fr.manashield.flex.thex 
{
	import fr.manashield.flex.thex.userInterface.GameWonPopup;
	import fr.manashield.flex.thex.events.NewGameEvent;
	import fr.manashield.flex.thex.events.GameOverEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;
	import fr.manashield.flex.thex.userInterface.GameOverPopup;
	import fr.manashield.flex.thex.userInterface.IngameUserInteraction;
	import fr.manashield.flex.thex.userInterface.UserInteraction;
	import fr.manashield.flex.thex.utils.EmbedFonts;

	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="800",height="800",backgroundColor="#ffffff",frameRate="100")]
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Main extends Sprite 
	{
		protected var _currentUI:UserInteraction;
		protected var _currentGame:Game = null;
		
		public function Main() : void
		{
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(e:Event=null) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			EmbedFonts.init();
			
			_currentGame = new Game(stage);
			ThexEventDispatcher.instance.addEventListener(GameOverEvent.GAME_LOST, gameOver);
			ThexEventDispatcher.instance.addEventListener(GameOverEvent.GAME_WON, gameWon);
			ThexEventDispatcher.instance.addEventListener(NewGameEvent.NEW_GAME, newGame);
			
			_currentUI = new IngameUserInteraction(stage);
			_currentUI.registerListeners();
		}
		
		private function gameOver(e:Event=null) : void
		{			
			_currentUI = _currentUI.gameOver();
			_currentGame.gameOver();
			
			stage.addChild(new GameOverPopup(stage));
		}
		
		private function gameWon(e:Event=null) : void
		{
			_currentUI = _currentUI.gameOver();
			_currentGame.gameOver();
			
			stage.addChild(new GameWonPopup(stage));
		}
		
		private function newGame(e:Event) : void
		{
			_currentUI = _currentUI.newGame();
			_currentGame.newGame();
		}
	}
}
