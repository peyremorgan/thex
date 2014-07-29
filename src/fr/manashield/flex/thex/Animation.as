package fr.manashield.flex.thex
{
	import fr.manashield.flex.thex.events.ThexEventDispatcher;
	import fr.manashield.flex.thex.events.GameOverEvent;
	import fr.manashield.flex.thex.blocks.Block;
	import fr.manashield.flex.thex.events.BlockLandingEvent;
	import fr.manashield.flex.thex.events.RotateBlockEvent;
	import fr.manashield.flex.thex.utils.Color;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public final class Animation extends EventDispatcher // TODO : move event-dispatching code to ThexEventDispatcher
	{
		private static var _instance:Animation = new Animation();
		private static var _stage:Stage;

		private var fallingBlocks:Vector.<Block> = new Vector.<Block>();
		private var staticBlocks:Vector.<Block> = new Vector.<Block>();
		private var fallTimer:Timer = new Timer(1000, 0);
		protected var _frameNb:uint;

		public static function initialize(game:Game):void
		{
			_stage = game.stage;
			
			// Listeners
			_instance.fallTimer.addEventListener(TimerEvent.TIMER, _instance.moveBlocksToCenter);
			_instance.fallTimer.start();
		}
		
		public function gameOver():void
		{
			_instance.fallTimer.stop();
		}
		
		public function moveBlocksClockwise(e : RotateBlockEvent):void
		{
			for each(var block:Block in fallingBlocks)
			{
				if(!block.currentCell.clockwiseNeighbor.occupied)
				{
					block.moveTo(block.currentCell.clockwiseNeighbor.hexCoordinates);
				}
			}
		}
		
		public function moveBlocksCounterClockwise(e : RotateBlockEvent):void
		{
			for each(var block:Block in fallingBlocks)
			{
				if(!block.currentCell.counterClockwiseNeighbor.occupied)
				{
					block.moveTo(block.currentCell.counterClockwiseNeighbor.hexCoordinates);
				}
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
				this.fallingBlocks.push(newBlock);
			}
			else
			{
				this.staticBlocks.push(newBlock);
			}
		}

		private function moveBlocksToCenter(e : Event):void
		{
			for each(var block:Block in fallingBlocks)
			{
				moveToCenter(block);
			}
		}

		private function moveToCenter(block:Block):void
		{
			if(block.currentCell.nearestNeighborToCenter.occupied)
			{
				fallingBlocks.splice(fallingBlocks.lastIndexOf(block), 1);
				staticBlocks.push(block);
				this.dispatchEvent(new BlockLandingEvent(block));
			}
			else
			{
				block.moveTo(block.currentCell.nearestNeighborToCenter.hexCoordinates);
			}
		}
		
		public function forceFall(e:Event):void
		{
			moveBlocksToCenter(null);
		}
		
		
		public function removeBlock(blockToRemove:Block):Block
		{
			var removedBlock:Block = null;
			
			if(staticBlocks.indexOf(blockToRemove) >= 0)
			{
				removedBlock =  staticBlocks.splice(staticBlocks.indexOf(blockToRemove), 1)[0];
				
				if(staticBlocks.length <= 0) ThexEventDispatcher.instance.dispatchEvent(new GameOverEvent(GameOverEvent.GAME_WON));
			}
			
			if(fallingBlocks.indexOf(blockToRemove) >= 0)
			{
				removedBlock = fallingBlocks.splice(fallingBlocks.indexOf(blockToRemove), 1)[0];
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
