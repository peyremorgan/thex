package fr.manashield.flex.thex.userInterface {
	import flash.ui.Keyboard;
	import fr.manashield.flex.thex.events.NewGameEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
 	public class GameOverPopup extends Banner
	{
		protected var _title:TextField;
		protected var _score:TextField;
		protected var continueButtonLayer:Sprite;
		
		public function GameOverPopup(stage:Stage):void
		{
			super(stage);
			
			_title = new TextField();
			_title.defaultTextFormat = new TextFormat("gameOver", 80, 0xFFFFFF);
			_title.embedFonts = true;
			_title.text = titleMessage();
			_title.autoSize = TextFieldAutoSize.LEFT;
			_title.x = stage.stageWidth/2 - _title.width/2;
			_title.y = stage.stageHeight/3 - _title.height/3;
			this.addChild(_title);
			
			// Continue button
			var buttonWidth:int = 267, buttonHeight:int = 75;
			continueButtonLayer = new Sprite();
			continueButtonLayer.graphics.beginFill(0xFFFFFF);
			continueButtonLayer.graphics.drawRect(stage.stageWidth/2 - buttonWidth/2, 2*stage.stageHeight/3 - buttonHeight/2, buttonWidth, buttonHeight);
			continueButtonLayer.graphics.endFill();
			
			var continueText:TextField = new TextField();
			var continueTextFormat:TextFormat = new TextFormat("gameOver", 2*buttonHeight/3, 0x888888);
			continueTextFormat.align = TextFormatAlign.CENTER;
			continueText.defaultTextFormat = continueTextFormat;
			continueText.embedFonts = true;
			continueText.text = "NEW GAME";
			continueText.height = buttonHeight;
			continueText.width = buttonWidth;
			continueText.x = stage.stageWidth/2 - buttonWidth/2;
			continueText.y = 2*stage.stageHeight/3 - buttonHeight*0.4;
			continueText.selectable = false;
			continueButtonLayer.addChild(continueText);
			
			var continueButton:SimpleButton = new SimpleButton(continueButtonLayer, continueButtonLayer, continueButtonLayer, continueButtonLayer);
			this.addChild(continueButton);
			
			continueButton.addEventListener(MouseEvent.CLICK, newGame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, newGame);
		}
		
		protected function newGame(e:Event):void
		{
			if(e.type == MouseEvent.CLICK || e.type == KeyboardEvent.KEY_DOWN && KeyboardEvent(e).keyCode == Keyboard.ENTER)
			{
				stage.focus = stage;
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, newGame);
				this.parent.removeChild(this);
				ThexEventDispatcher.instance.dispatchEvent(new NewGameEvent());
			}
		}
		
		protected function titleMessage():String
		{
			return "GAME OVER";
		}
	}
}
