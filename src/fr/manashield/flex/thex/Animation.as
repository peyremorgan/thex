package fr.manashield.flex.thex {

	import fr.manashield.flex.thex.events.BlockLandingEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import fr.manashield.flex.thex.blocks.Block;
	import fr.manashield.flex.thex.events.RotateBlockEvent;

	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public final class Animation extends EventDispatcher
	{

		private static var _instance:Animation = new Animation();
		private static var _stage:Stage;

		private var fallingBlocks:Vector.<Block> = new Vector.<Block>();
		private var staticBlocks:Vector.<Block> = new Vector.<Block>();
		private var fallTimer:Timer = new Timer(1000, 0);

		public static function initialize(game:Game):void
		{
			_stage = game.stage;
			
			// Listeners
			_instance.fallTimer.addEventListener(TimerEvent.TIMER, _instance.moveBlocksToCenter);
			_instance.fallTimer.start();
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

		public function addBlock(newBlock:Block):void
		{
			this.fallingBlocks.push(newBlock);
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
				this.dispatchEvent(new BlockLandingEvent());
			}
			else
			{
				block.moveTo(block.currentCell.nearestNeighborToCenter.hexCoordinates);
			}
		}
	}
}
