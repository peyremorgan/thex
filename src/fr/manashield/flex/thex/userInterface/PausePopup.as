package fr.manashield.flex.thex.userInterface {
	import fr.manashield.flex.thex.events.PauseEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
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
			_pauseText.y = stage.stageHeight/2 - _pauseText.height/2;
			this.addChild(_pauseText);
			
			ThexEventDispatcher.instance.addEventListener(PauseEvent.RESUME, destroy);
		}
		
		protected function destroy(e:Event):void
		{
			ThexEventDispatcher.instance.removeEventListener(PauseEvent.RESUME, destroy);
			stage.focus = stage;
			this.parent.removeChild(this);
		}
	}
}
