package fr.manashield.flex.thex.userInterface {
	import fr.manashield.flex.thex.events.MenuEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;

	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * @author Paul
	 */
	public class MenuUserInteraction extends UserInteraction
	{
		public function MenuUserInteraction(stage:Stage, eventDispatcher:EventDispatcher = null):void
		{
			super(stage, eventDispatcher);
		}
		
		public override function isAbstract():Boolean
		{
			return false;
		}
		
		override public function keyPressed(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.DOWN:
				ThexEventDispatcher.instance.dispatchEvent(new MenuEvent(MenuEvent.NEXT_ITEM));
				break;
				
				case Keyboard.UP:
				ThexEventDispatcher.instance.dispatchEvent(new MenuEvent(MenuEvent.PREVIOUS_ITEM));
				break;
				
				case Keyboard.ENTER:
				ThexEventDispatcher.instance.dispatchEvent(new MenuEvent(MenuEvent.SELECT));
				break;
			}
		}
		
		public override function menu():UserInteraction
		{
			return this;
		}
	}
}
