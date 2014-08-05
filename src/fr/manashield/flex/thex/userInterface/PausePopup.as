package fr.manashield.flex.thex.userInterface {
	import fr.manashield.flex.thex.events.MenuEvent;
	import fr.manashield.flex.thex.events.PauseEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;

	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	
	public class PausePopup extends Banner
	{
		protected var _pauseText:TextField;

		public function PausePopup(stage:Stage):void
		{
			super(stage);

			_pauseText = new TextField();
			_pauseText.defaultTextFormat = new TextFormat("gameOver", 100, 0xFFFFFF);
			_pauseText.embedFonts = true;
			_pauseText.text = "PAUSE";
			_pauseText.autoSize = TextFieldAutoSize.LEFT;
			_pauseText.x = stage.stageWidth/2 - _pauseText.width/2;
			_pauseText.y = stage.stageHeight/3 - _pauseText.height/2;
			this.addChild(_pauseText);

			var buttonWidth:int = 267, buttonHeight:int = 75;
			var menuButtonLayer:ButtonLayer = new ButtonLayer(stage.stageWidth/2 - buttonWidth/2, 2*stage.stageHeight/3 - buttonHeight/2, buttonWidth, buttonHeight, new TextFormat("buttons", 2*buttonHeight/3, 0x888888), "MENU", true);

			var menuButton:SimpleButton = new SimpleButton(menuButtonLayer, menuButtonLayer, menuButtonLayer, menuButtonLayer);
			this.addChild(menuButton);

			menuButton.addEventListener(MouseEvent.CLICK, menu);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, menu);

			ThexEventDispatcher.instance.addEventListener(PauseEvent.RESUME, destroy);
		}

		protected function menu(e:Event):void
		{
			if(e.type == MouseEvent.CLICK || e.type == KeyboardEvent.KEY_DOWN && KeyboardEvent(e).keyCode == Keyboard.ENTER)
			{
				ThexEventDispatcher.instance.dispatchEvent(new MenuEvent(MenuEvent.MENU));
				this.destroy();
			}
			
		}
		
		protected function destroy(e:Event = null):void
		{
			ThexEventDispatcher.instance.removeEventListener(PauseEvent.RESUME, destroy);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, menu);
			stage.focus = stage;
			this.parent.removeChild(this);
		}
	}
}
