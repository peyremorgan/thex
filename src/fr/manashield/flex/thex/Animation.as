package fr.manashield.flex.thex {
	import fr.manashield.flex.thex.events.ForceFallEvent;
	import fr.manashield.flex.thex.blocks.Block;
	import fr.manashield.flex.thex.blocks.BlockGenerator;
	import fr.manashield.flex.thex.events.GameOverEvent;
	import fr.manashield.flex.thex.events.RotateBlockEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;
	import fr.manashield.flex.thex.geometry.Sparkle;
	import fr.manashield.flex.thex.utils.Color;

	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public final class Animation
	{
		private static var _instance:Animation;
		
		private var _game:Game;
		private var fallingBlock:Block;
		private var staticBlocks:Vector.<Block> = new Vector.<Block>();
		protected var _frameNb:uint;
		
		//
		//private var sparkleTimer:Timer = new Timer(2000, 0);

		public static function initialize(game:Game):void
		{
			//_stage = game.stage;
			_instance = new Animation(game);
			
			// Listeners
			game.timer.addEventListener(TimerEvent.TIMER_COMPLETE, _instance.moveBlockToCenter);
			game.timer.addEventListener(TimerEvent.TIMER, _instance.sparkle);
			
			ThexEventDispatcher.instance.addEventListener(RotateBlockEvent.ROTATE_CW, _instance.moveBlockClockwise);
			ThexEventDispatcher.instance.addEventListener(RotateBlockEvent.ROTATE_CCW, _instance.moveBlockCounterClockwise);
			ThexEventDispatcher.instance.addEventListener(ForceFallEvent.FORCE_FALL, _instance.forceFall);
		
		}
		
		//
		private function sparkle(e:Event=null):void {
			var sparklesPos:Vector.<Point> = new Vector.<Point>();
			sparklesPos.push(new Point(10, 5));
			sparklesPos.push(new Point(-15, 20));
			sparklesPos.push(new Point(0, -15));
		
			for each(var block:Block in staticBlocks) {
				if(Math.floor(Math.random()*Game.TIMER_PERIOD*10))
					continue;

				block.symbol.stage.addChild(new Sparkle(block.symbol.localToGlobal(sparklesPos[Math.floor(Math.random()*sparklesPos.length)])));
			}
		}
		
		public function Animation(game:Game):void
		{
			if(_instance == null)
			{
				_game = game;
			}
			else
			{
				throw new IllegalOperationError();
			}
		}
		
		public function blockLanded(block:Block):void
		{
			if(block.sameColorNeighbors() >= 3)
			{
				if(block.sameColorNeighbors() == 4)
				{
					++_game.score;
				}
				else if(block.sameColorNeighbors() > 4)
				{
					_game.score += 2;
				}
				_game.scoreField.text = _game.score.toString();

				block.destroyIf(block.color);
			}
			
			BlockGenerator.instance.spawnBlock();
		}

		public function moveBlockClockwise(e : RotateBlockEvent):void
		{
			if(!fallingBlock.currentCell.clockwiseNeighbor.occupied)
			{
				fallingBlock.moveTo(fallingBlock.currentCell.clockwiseNeighbor.hexCoordinates);
			}
		}
		
		public function moveBlockCounterClockwise(e : RotateBlockEvent):void
		{
			if(!fallingBlock.currentCell.counterClockwiseNeighbor.occupied)
			{
				fallingBlock.moveTo(fallingBlock.currentCell.counterClockwiseNeighbor.hexCoordinates);
			}
		}
		
		
		public static function get instance():Animation
		{
			return _instance;
		}
		
		public function addBlock(newBlock:Block, falling:Boolean = true):void
		{
			if(falling)
			{
				fallingBlock = newBlock;
			}
			else
			{
				this.staticBlocks.push(newBlock);
			}
		}
		
		private function moveBlockToCenter(e:Event):void
		{
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
		
		public function forceFall(e:Event):void
		{
			moveBlockToCenter(null);
		}
		
		public function reset():void
		{
			// Carefull: the destroy method modifies the staticBlocks array
			var length:uint = staticBlocks.length;
			for (var i:uint=0; i<length; ++i)
			{
				staticBlocks[0].destroy();
			}
			
			if(fallingBlock)
			{
				fallingBlock.destroy();
				fallingBlock = null;
			}
		}
		
		public function removeBlock(blockToRemove:Block):Block
		{
			var removedBlock:Block = null;
			
			if(staticBlocks.indexOf(blockToRemove) >= 0)
			{
				removedBlock =  staticBlocks.splice(staticBlocks.indexOf(blockToRemove), 1)[0];
				
				if(staticBlocks.length <= 0 && this._game.ingame)
				{
					ThexEventDispatcher.instance.dispatchEvent(new GameOverEvent(GameOverEvent.GAME_WON));
				}
			}

			if(fallingBlock == blockToRemove)
			{
				removedBlock = fallingBlock;
				fallingBlock = null;
			}
			
			return removedBlock;
		}
		
		
		
		public function activeColors(unique:Boolean = true):Vector.<Color>
		{
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
	}
}
