package fr.manashield.flex.thex.userInterface {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import fr.manashield.flex.thex.utils.Color;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class GameOverPopup extends Sprite
	{
		protected var _background:Sprite;
		protected var _title:TextField;
		protected var _score:TextField;
		
		public function GameOverPopup(stage:Stage):void
		{
			_background = new Sprite();
			_background.graphics.beginFill(Color.WHITE.hexValue);
			_background.graphics.drawRect(-stage.fullScreenWidth,-stage.fullScreenHeight,2*stage.fullScreenWidth, 2*stage.fullScreenHeight);
			_background.graphics.endFill();
			_background.alpha = 0.5;
			this.addChild(_background);
			
			var titleFormat:TextFormat = new TextFormat();
			titleFormat.size = 100;
			titleFormat.color = 0x801616;
			titleFormat.font = "gameOver";
			_title = new TextField();
			_title.defaultTextFormat = titleFormat;
			_title.embedFonts = true;
			_title.text = "GAME OVER";
			_title.autoSize = TextFieldAutoSize.LEFT;
			_title.x = stage.stageWidth/2 - _title.width/2;
			_title.y = stage.stageHeight/10;
			this.addChild(_title);
			
			var scoreFormat:TextFormat = new TextFormat();
			scoreFormat.size = 200;0
			scoreFormat.color = 0x404040;
			scoreFormat.font = "score";
			_score = new TextField();
			_score.defaultTextFormat = scoreFormat;
			_score.embedFonts = true;
			_score.text = TextField(stage.getChildByName("_scoreField")).text;
			_score.autoSize = TextFieldAutoSize.LEFT;
			_score.x = stage.stageWidth/2 - _score.width/2;
			_score.y = stage.stageHeight/2 - _score.height/2;
			this.addChild(_score);
		}
	}
}
