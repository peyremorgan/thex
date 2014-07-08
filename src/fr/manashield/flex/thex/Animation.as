package fr.manashield.flex.thex {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public final class Animation
	{

		private static var _instance:Animation = new Animation();
		private static var _stage:Stage;
		private static var _grid:HexagonalGrid;

		private var fallingBlocks:Vector.<Block> = new Vector.<Block>();
		private var staticBlocks:Vector.<Block> = new Vector.<Block>();
		private var fallTimer:Timer = new Timer(1000, 0);

		public static function initialize(game:Game):void
		{
			_stage = game.stage;
			_grid = game.grid;

			_instance.fallTimer.addEventListener(TimerEvent.TIMER, _instance.moveBlocksToCenter);
			_instance.fallTimer.start();
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
			if(block.distanceToCenter <= 3*Math.cos(Math.PI/6)*block.currentCell.parent.gridSize)
			{
				fallingBlocks.splice(fallingBlocks.lastIndexOf(block), 1);
				staticBlocks.push(block);
			}
			else
			{
				block.moveTo(block.currentCell.nearestNeighborToCenter.hexCoordinates);
			}
		}
	}
}
