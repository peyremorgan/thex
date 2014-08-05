package fr.manashield.flex.thex.userInterface {
	import fr.manashield.flex.thex.utils.Abstract;

	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class UserInteraction extends Abstract
	{
		public var _localEventDispatcher:EventDispatcher;
		public var _stage:Stage;
		
		public function mousePressed(e:MouseEvent):void{}
		public function mouseReleased(e:MouseEvent):void{}
		
		public function keyPressed(e:KeyboardEvent):void{}
		public function keyReleased(e:KeyboardEvent):void{}
		
		public function UserInteraction(stage:Stage = null, eventDispatcher:EventDispatcher = null)
		{
			_localEventDispatcher = eventDispatcher?eventDispatcher:new EventDispatcher();
			_stage = stage;
			
			if(stage) addEventListeners(stage);
		}
		
		// Event listening methods and properties
		
		protected var events:Object = [
			[KeyboardEvent.KEY_DOWN, keyPressed],
			[KeyboardEvent.KEY_UP, keyReleased],
			[MouseEvent.MOUSE_DOWN, mousePressed],
			[MouseEvent.MOUSE_UP, mouseReleased]
		];
		
		protected function addEventListeners(stage:Stage):void
		{
			for each (var i:Object in events)
			{
				stage.addEventListener(i[0], i[1]);
			}
		}
		
		protected function removeEventListeners(stage:Stage):void
		{
			for each (var i:Object in events)
			{
				stage.removeEventListener(i[0], i[1]);
			}
		}
		
		// Transition methods
		
		public function gameOver():UserInteraction
		{
			removeEventListeners(_stage);
			
			return new GameOverUserInteraction(_stage, _localEventDispatcher);
		}
		
		public function newGame():UserInteraction
		{
			removeEventListeners(_stage);
			
			return new IngameUserInteraction(_stage, _localEventDispatcher);
		}
		
		public function pause():UserInteraction
		{
			return this;
		}
		
		public function resume():UserInteraction
		{
			return this;
		}
		
		public function menu():UserInteraction
		{
			removeEventListeners(_stage);
			
			return new MenuUserInteraction(_stage, _localEventDispatcher);
		}
	}
}