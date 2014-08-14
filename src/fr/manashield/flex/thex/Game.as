package fr.manashield.flex.thex 
{
	import fr.manashield.flex.thex.utils.CellAlreadyOccupiedError;
	import fr.manashield.flex.thex.blocks.HexagonalCell;
	import fr.manashield.flex.thex.geometry.Sparkle;
	import fr.manashield.flex.thex.events.ForceFallEvent;
	import fr.manashield.flex.thex.events.RotateBlockEvent;
	import fr.manashield.flex.thex.blocks.Block;
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
		protected var fallingBlock:Block;
		protected var staticBlocks:Vector.<Block> = new Vector.<Block>();
		protected var _clockTimer:Timer = new Timer(TIMER_PERIOD, TICK_PERIOD/TIMER_PERIOD);
		
		public function Game(stage:Stage):void
        {
            _stage = stage;
            HexagonalGrid.init(_stage, CELL_RADIUS);
            HexagonalGrid.instance.addChild(createScoreField());
            addEventListeners();
        }

        private function createScoreField():TextField {
            _scoreField = new TextField();
            _scoreField.name = "_scoreField";
            _scoreField.autoSize = TextFieldAutoSize.LEFT;

            var format:TextFormat = new TextFormat();
            format.size = 100;
            format.font = "score";
            format.color = 0x555555;
            format.letterSpacing = 4;
            _scoreField.defaultTextFormat = format;
            _scoreField.embedFonts = true;

            return _scoreField;
        }

        private function addEventListeners():void {
            ThexEventDispatcher.instance.addEventListener(RotateBlockEvent.ROTATE_CW, moveBlockClockwise);
            ThexEventDispatcher.instance.addEventListener(RotateBlockEvent.ROTATE_CCW, moveBlockCounterClockwise);
            ThexEventDispatcher.instance.addEventListener(ForceFallEvent.FORCE_FALL, forceFall);
			_clockTimer.addEventListener(TimerEvent.TIMER_COMPLETE, tick);
            _clockTimer.addEventListener(TimerEvent.TIMER, sparkle);
        }

        public function moveBlockClockwise(e : RotateBlockEvent):void {
            if(!fallingBlock.currentCell.clockwiseNeighbor.occupied)
            {
                    fallingBlock.moveTo(fallingBlock.currentCell.clockwiseNeighbor.hexCoordinates);
            }
    	}

        public function moveBlockCounterClockwise(e : RotateBlockEvent):void {
            if(!fallingBlock.currentCell.counterClockwiseNeighbor.occupied)
            {
                    fallingBlock.moveTo(fallingBlock.currentCell.counterClockwiseNeighbor.hexCoordinates);
            }
        }

        public function forceFall(e:Event):void {
            moveBlockToCenter(null);
        }

        private function moveBlockToCenter(e:Event = null):void {
            if(fallingBlock.currentCell.nearestNeighborToCenter.occupied)
            {
                    staticBlocks.push(fallingBlock);
                    blockLanded(fallingBlock);
            }
            else
            {
                    fallingBlock.moveTo(fallingBlock.currentCell.nearestNeighborToCenter.hexCoordinates);
            }
        }

        public function blockLanded(block:Block):void {
            var sameColorNeighbors:Vector.<Block> = block.sameColorNeighbors();
            if(sameColorNeighbors.length >= 3)
            {
                    if(sameColorNeighbors.length == 4)
                    {
                            ++_score;
                    }
                    else if(sameColorNeighbors.length > 4)
                    {
                            _score += 2;
                    }
                    _scoreField.text = _score.toString();

                    destroyBlocks(sameColorNeighbors);
            }

            spawnBlock(activeColors());
        }

        private function destroyBlocks(blocks:Vector.<Block>):void {
            for each(var block:Block in blocks) {
                    block.destroy();
                    removeBlock(block);
            }
        }

        public function removeBlock(blockToRemove:Block):Block {
            var removedBlock:Block = null;

            removedBlock =  staticBlocks.splice(staticBlocks.indexOf(blockToRemove), 1)[0];

            if(staticBlocks.length <= 0 && _ingame)
            {
                    ThexEventDispatcher.instance.dispatchEvent(new GameOverEvent(GameOverEvent.GAME_WON));
            }

            if(fallingBlock == blockToRemove)
            {
                    removedBlock = fallingBlock;
                    fallingBlock = null;
            }

            return removedBlock;
        }

        private function sparkle(e:Event=null):void {
            var sparklesPos:Vector.<Point> = new Vector.<Point>();
            sparklesPos.push(new Point(10, 5));
            sparklesPos.push(new Point(-15, 20));
            sparklesPos.push(new Point(0, -15));

            for each(var block:Block in staticBlocks) {
                    if(Math.floor(Math.random()*TIMER_PERIOD*10))
                            continue;

                    block.symbol.addChild(new Sparkle(sparklesPos[Math.floor(Math.random()*sparklesPos.length)]));
            }
        }

        public function activeColors(unique:Boolean = true):Vector.<Color> {
            var colors:Vector.<Color> = new Vector.<Color>();

            for each(var block:Block in staticBlocks)
            {
                    if(!unique || colors.indexOf(block.color) < 0)
                    {
                            colors.push(block.color);
                    }
            }

            return colors;
        }

        public function addBlock(newBlock:Block, falling:Boolean = true):void {
            if(falling)
            {
                    fallingBlock = newBlock;
            }
            else
            {
                    staticBlocks.push(newBlock);
            }
        }

        public function spawnBlock(activeColors:Vector.<Color>, radius:uint = 7, index:int = Infinity, addToFallingList:Boolean = true):Block {
            var cell:HexagonalCell = HexagonalGrid.instance.cell(new Point(0,radius));

            // Cette ligne est extrement degueu. A refaire quand !flemme;
            var spawnIndex:int = (index != Infinity ? (index<0 ? (6*radius)+index%(6*radius) : index%(6*radius)) : Math.random()*6*radius);

            for(var i:int=0; i<spawnIndex; ++i)
            {
                    cell = cell.clockwiseNeighbor;
            }

            var blockColor:Color;

            if(addToFallingList)
            {
                    if(activeColors.length)
                    {
                            blockColor = activeColors[uint(Math.random()*activeColors.length)];
                    }
                    else
                    {
                            return null;
                    }
            }
            else
            {
                    blockColor = Color.RANDOM;
            }

            try
            {
                    var newBlock:Block = new Block(cell, blockColor);
                    addBlock(newBlock, addToFallingList);
            }
            catch(error:CellAlreadyOccupiedError)
            {
                    ThexEventDispatcher.instance.dispatchEvent(new GameOverEvent(GameOverEvent.GAME_LOST));
            }

            return newBlock;
        }
		
		protected function tick(e:Event):void
		{
			countDown();
			moveBlockToCenter();
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
		
		private function fillGrid(radius:uint = 3):void {
            for(var i:uint=1; i<=radius; ++i)
            {
                for(var j:uint=0; j<6*i; ++j)
                {
                        spawnBlock(Color.COLORS, i, j, false);
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
			// Start timer
			this.timer.start();
		}
		
		public function preLoad():void
		{
			// Reset score
			_score = 20;
			_scoreField.text = _score.toString();
			
			// Cleanup game board
			// Beware: the destroy method modifies the staticBlocks array
            while(staticBlocks.length>0)
            {
                    staticBlocks[0].destroy();
                    removeBlock(staticBlocks[0]);
            }

            if(fallingBlock)
            {
                    fallingBlock.destroy();
                    fallingBlock = null;
            }
			
			// Enable game rules
			this._ingame = true;
			
			// Generate map
			this.fillGrid(1);
			
			// create first falling block
			spawnBlock(activeColors());
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