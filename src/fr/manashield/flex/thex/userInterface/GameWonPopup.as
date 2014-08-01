package fr.manashield.flex.thex.userInterface {
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class GameWonPopup extends GameOverPopup
	{
		public function GameWonPopup(stage:Stage):void
		{
			super(stage);
			
			_score = new TextField();
			_score.defaultTextFormat = new TextFormat("score", 100, 0xFFFFFF);
			_score.embedFonts = true;
			_score.text = TextField(stage.getChildByName("_scoreField")).text;
			_score.autoSize = TextFieldAutoSize.LEFT;
			_score.x = stage.stageWidth/2 - _score.width/2;
			_score.y = stage.stageHeight/2 - _score.height/3;
			this.addChild(_score);
		}
		
		protected override function titleMessage():String
		{
			return "CONGRATULATIONS";
		}
	}
}






