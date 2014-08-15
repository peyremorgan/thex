package fr.manashield.flex.thex 
{
	import fr.manashield.flex.thex.blocks.HexagonalGrid;
	import fr.manashield.flex.thex.events.GameOverEvent;
	import fr.manashield.flex.thex.events.MenuEvent;
	import fr.manashield.flex.thex.events.NewGameEvent;
	import fr.manashield.flex.thex.events.PauseEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;
	import fr.manashield.flex.thex.userInterface.GameOverPopup;
	import fr.manashield.flex.thex.userInterface.GameWonPopup;
	import fr.manashield.flex.thex.userInterface.MenuUserInteraction;
	import fr.manashield.flex.thex.userInterface.PausePopup;
	import fr.manashield.flex.thex.userInterface.UserInteraction;
	import fr.manashield.flex.thex.utils.EmbedFonts;

	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="900",height="900",backgroundColor="#ffffff",frameRate="60")]
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Main extends Sprite 
	{
		protected var _currentUI:UserInteraction;
		protected var _menu:Menu;
		private static const CELL_RADIUS:uint = 25;
		
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
			
			_menu = new Menu(stage);
			
            HexagonalGrid.init(stage, CELL_RADIUS);
			
			_currentUI = new MenuUserInteraction(stage);
			
			ThexEventDispatcher.instance.addEventListener(GameOverEvent.GAME_LOST, gameOver);
			ThexEventDispatcher.instance.addEventListener(GameOverEvent.GAME_WON, gameWon);
			ThexEventDispatcher.instance.addEventListener(NewGameEvent.NEW_GAME, newGame);
			ThexEventDispatcher.instance.addEventListener(PauseEvent.PAUSE, pause);
			ThexEventDispatcher.instance.addEventListener(PauseEvent.RESUME, resume);
			ThexEventDispatcher.instance.addEventListener(MenuEvent.MENU, menu);
		}
		
		private function resume(e:Event = null) : void
		{
			_currentUI = _currentUI.resume();
			Game.instance.resume();
		}
		
		private function pause(e:Event = null) : void
		{
			_currentUI = _currentUI.pause();
			Game.instance.pause();
			
			stage.addChild(new PausePopup(stage));
		}
		
		private function gameOver(e:Event = null) : void
		{
			_currentUI = _currentUI.gameOver();
			Game.instance.gameOver();
			
			stage.addChild(new GameOverPopup(stage));
		}
		
		private function gameWon(e:Event = null) : void
		{
			_currentUI = _currentUI.gameOver();
			Game.instance.gameOver();
			
			stage.addChild(new GameWonPopup(stage));
		}
		
		private function newGame(e:Event = null) : void
		{
			if(Game.instance == null)
			{
				Game.init(stage);
			}
			
			Game.instance.preLoad();
			if(_menu)
			{
				_menu.fadeOut();
				_menu = null;
			}
			
			_currentUI = _currentUI.newGame();
			Game.instance.newGame();
		}
		
		private function menu(e:Event = null):void
		{
			if(this._menu == null)
			{
				this._menu = new Menu(stage, true);
				Game.instance.gameOver();
				_currentUI = _currentUI.menu();
			}
		}
	}
}
