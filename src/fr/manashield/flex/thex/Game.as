package fr.manashield.flex.thex 
{
	import fr.manashield.flex.thex.blocks.Block;
	import fr.manashield.flex.thex.blocks.BlockGenerator;
	import fr.manashield.flex.thex.blocks.HexagonalGrid;
	import fr.manashield.flex.thex.events.GameOverEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;
	import fr.manashield.flex.thex.utils.Color;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Game
	{
		private static const CELL_RADIUS:uint = 25;
		private static const TICK_PERIOD:uint = 1000;
		public static const TIMER_PERIOD:uint = 100;
		
		protected var _ingame:Boolean;
		protected var _stage:Stage;
		protected var _origin:Point;
		protected var _score:uint;
		protected var _scoreField:TextField;
		protected var _clockTimer:Timer = new Timer(TIMER_PERIOD, TICK_PERIOD/TIMER_PERIOD);
		
		public function Game(stage:Stage):void
		{
			// Game board
			_stage = stage;
			HexagonalGrid.init(_stage, CELL_RADIUS);
			_origin = _origin = HexagonalGrid.instance.hexToCartesian(new Point(0,0));
			
			// Score field
			_scoreField = new TextField();
			_scoreField.name = "_scoreField";
			_scoreField.autoSize = TextFieldAutoSize.LEFT;
			stage.addChild(_scoreField);

			var format:TextFormat = new TextFormat();
			format.size = 100;
			format.font = "score";
			format.color = 0x555555;
			format.letterSpacing = 4;
			_scoreField.defaultTextFormat = format;
			_scoreField.embedFonts = true;
			
			// central hexagon
			new Block(HexagonalGrid.instance.cell(new Point(0,0)), new Color(0x5c5c5c));
			
			// initialze and launch the animation of the falling blocks
			Animation.initialize(this);
			
			// Initialize timer
			this._clockTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.tick);
			
		}
		
		protected function tick(e:Event):void
		{
			countDown();
			rearmTimer();
		}
		
		public function get ingame():Boolean
		{
			return _ingame;
		}
		
		public function get timer():Timer
		{
			return this._clockTimer;
		}
		
		public function get stage():Stage	
		{
			return _stage;
		}
		
		private function countDown(e:Event = null):void
		{
			--_score;
			_scoreField.text = _score.toString();
			
			if (!_score)
			{
				ThexEventDispatcher.instance.dispatchEvent(new GameOverEvent(GameOverEvent.GAME_LOST));
			}
		}
		
		protected function fillGrid(radius:uint = 3):void
		{
			for(var i:uint=1; i<=radius; ++i)
			{
				for(var j:uint=0; j<6*i; ++j)
				{
					BlockGenerator.instance.spawnBlock(i, j, false);
				}
			}
		}
		
		public function gameOver():void
		{
			this._ingame = false;
			this.timer.stop();
		}
		
		public function newGame():void
		{
			// Reset score
			_score = 20;
			_scoreField.text = _score.toString();
			
			// Cleanup game board
			Animation.instance.reset();
			
			// Enable game rules
			this._ingame = true;
			
			// Generate map
			this.fillGrid(1);
			
			// create first falling block
			BlockGenerator.instance.spawnBlock();
			
			// Start timer
			this.timer.start();
		}
		
		public function get score():uint
		{
			return _score;
		}
		
		public function set score(score:uint):void
		{
			_score = score;
		}
		
		public function get scoreField():TextField
		{
			return _scoreField;
		}
		
		public function set scoreField(scoreField:TextField):void
		{
			_scoreField = scoreField;
		}
		
		public function pause():void
		{
			this.timer.stop();
		}
		
		public function resume():void
		{
			this.timer.start();
		}
		
		public function rearmTimer():void
		{
			this.timer.reset();
			if(_ingame) this.timer.start();
		}
	}
}