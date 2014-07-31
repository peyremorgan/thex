package fr.manashield.flex.thex.userInterface {
	import fr.manashield.flex.thex.events.NewGameEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;
	import fr.manashield.flex.thex.utils.Color;

	import flash.display.GradientType;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
 	public class GameOverPopup extends Sprite
	{
		protected var _background:Sprite;
		protected var _title:TextField;
		protected var _score:TextField;
		protected var _banner:Sprite;
		protected var _gradientMatrix:Matrix;
		protected var continueButtonLayer:Sprite;
		
		public function GameOverPopup(stage:Stage):void
		{
			_background = new Sprite();
			_background.graphics.beginFill(Color.WHITE.hexValue);
			_background.graphics.drawRect(-stage.fullScreenWidth,-stage.fullScreenHeight,2*stage.fullScreenWidth, 2*stage.fullScreenHeight);
			_background.graphics.endFill();
			_background.alpha = 0.5;
			this.addChild(_background);
			
			_banner = new Sprite();
			_gradientMatrix = new Matrix();
			_gradientMatrix.createGradientBox(2*stage.fullScreenWidth, stage.stageHeight/2, Math.PI/2, 0, stage.stageHeight/4);
			//banner.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF,0xAC3838,0x801616,0x000000], [1,1,1,1], [0,5,250,255], gradientMatrix);
			//banner.graphics.beginGradientFill(GradientType.LINEAR, [0xAC3838,0x000000], [1,1], [0,255], gradientMatrix);
			//banner.graphics.beginFill(0x801616);
			//banner.graphics.beginFill(0xCCCCCC);
			_banner.graphics.beginGradientFill(GradientType.LINEAR, [0xCCCCCC,0xAAAAAA], [1,1], [0,255], _gradientMatrix);
			_banner.graphics.drawRect(-stage.fullScreenWidth, stage.stageHeight/4, 2*stage.fullScreenWidth, stage.stageHeight/2);
			_banner.graphics.endFill();
			this.addChild(_banner);
			
			_title = new TextField();
			_title.defaultTextFormat = new TextFormat("gameOver", 100, 0xFFFFFF);
			_title.embedFonts = true;
			_title.text = titleMessage();
			_title.autoSize = TextFieldAutoSize.LEFT;
			_title.x = stage.stageWidth/2 - _title.width/2;
			_title.y = stage.stageHeight/3 - _title.height/3;
			this.addChild(_title);
			
			// Continue button something
			var buttonWidth:int = 158, buttonHeight:int = 50;
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
		}
		
		protected function newGame(e:Event):void
		{
			this.parent.removeChild(this);
			ThexEventDispatcher.instance.dispatchEvent(new NewGameEvent());
		}
		
		protected function titleMessage():String
		{
			return "GAME OVER";
		}
	}
}
