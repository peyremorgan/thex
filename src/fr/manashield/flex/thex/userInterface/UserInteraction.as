package fr.manashield.flex.thex.userInterface 
{
	import fr.manashield.flex.thex.Animation;
	import fr.manashield.flex.thex.events.ForceFallEvent;
	import fr.manashield.flex.thex.events.RotateBlockEvent;
	import fr.manashield.flex.thex.utils.Abstract;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class UserInteraction extends Abstract implements IEventDispatcher
	{
		public var _localEventDispatcher:EventDispatcher;
		public var _stage:Stage;
		
		public function mousePressed(e:MouseEvent):void{}
		public function mouseReleased(e:MouseEvent):void{}
		
		public function keyPressed(e:KeyboardEvent):void{}
		public function keyReleased(e:KeyboardEvent):void{}
		
		public function UserInteraction(stage:Stage = null, eventDispatcher:EventDispatcher = null)
		{
			this._localEventDispatcher = eventDispatcher?eventDispatcher:new EventDispatcher();
			_stage = stage;
			
			if(stage) addEventListeners(stage);
		}
		
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
		
		// Transitions
		public function gameOver():UserInteraction
		{
			removeEventListeners(_stage);
			
			return new GameOverUserInteraction(_stage, _localEventDispatcher);
		}
		
		public function newGame():UserInteraction
		{
			return new IngameUserInteraction(_stage, _localEventDispatcher);
		}
		
		public function menu():UserInteraction
		{
			return null; // FIXME : implement me
		}
		
		public function resume():UserInteraction
		{
			return null; // FIXME : implement me
		}
		
		// Event-related methods
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			this._localEventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function dispatchEvent(event : Event) : Boolean 
		{
			return this._localEventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type : String) : Boolean
		{
			return this._localEventDispatcher.hasEventListener(type);
		}
		
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void 
		{
			this._localEventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type : String) : Boolean 
		{
			return this._localEventDispatcher.willTrigger(type);
		}
		
		// Listeners registration
		public function registerListeners():void
		{
			addEventListener(RotateBlockEvent.ROTATE_CW, Animation.instance.moveBlockClockwise);
			addEventListener(RotateBlockEvent.ROTATE_CCW, Animation.instance.moveBlockCounterClockwise);
			addEventListener(ForceFallEvent.FORCE_FALL, Animation.instance.forceFall);
		}
	}
}
