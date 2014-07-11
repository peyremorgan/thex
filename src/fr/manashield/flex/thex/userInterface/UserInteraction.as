package fr.manashield.flex.thex.userInterface 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import fr.manashield.flex.thex.Abstract;

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class UserInteraction extends Abstract implements IEventDispatcher
	{
		public var localEventDispatcher:EventDispatcher;
		
		function mousePressed(e:MouseEvent):void{}
		function mouseReleased(e:MouseEvent):void{}
		
		function keyPressed(e:KeyboardEvent):void{}
		function keyReleased(e:KeyboardEvent):void{}
		
		public function UserInteraction(initializeEventListener:Boolean = false, stage:Stage = null)
		{
			if(initializeEventListener)
			{
				this.localEventDispatcher = new EventDispatcher();
			}
			
			if(stage)
			{
				stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyPressed);
				stage.addEventListener(KeyboardEvent.KEY_UP, this.keyReleased);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, this.mousePressed);
				stage.addEventListener(MouseEvent.MOUSE_UP, this.mouseReleased);
			}
		}
		
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			this.localEventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function dispatchEvent(event : Event) : Boolean 
		{
			return this.localEventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type : String) : Boolean
		{
			return this.localEventDispatcher.hasEventListener(type);
		}
		
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void 
		{
			this.localEventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type : String) : Boolean 
		{
			return this.localEventDispatcher.willTrigger(type);
		}
	}
}
