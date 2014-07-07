package fr.manashield.flex.thex {
	import fr.manashield.flex.thex.geometry.Polygon;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * @author Morgan
	 */
	public final class Animation
	{
		
		private static var _instance:Animation = new Animation();
		private static var _stage:Stage;
		private static var _grid:HexagonalGrid;
		
		private var fallingBlocks:Vector.<Polygon> = new Vector.<Polygon>();
		private var staticBlocks:Vector.<Polygon> = new Vector.<Polygon>();
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
		
		public function addBlock(newBlock:Polygon):void
		{
			this.fallingBlocks.push(newBlock);
		}
		
		private function moveBlocksToCenter(e : Event):void
		{
			for each(var block:Polygon in fallingBlocks)
			{
				moveToCenter(block, block.size);
			}
		}
		
		private function moveToCenter(block:Polygon, shift:Number):void
		{
			//TODO: put the fucking hex coords in the hexagon itself
			//Done: Morgan (6/7/14)
			//Not done in fact...
			
			var hexCoord:Point = _grid.cartesianToHex(new Point(block.x, block.y));

			if(distanceToCenter(_grid.hexToCartesian(hexCoord)) <= 2*shift*Math.cos(Math.PI/6))
			{
				fallingBlocks.splice(fallingBlocks.lastIndexOf(block), 1);
				staticBlocks.push(block);
			}
			else
			{
				var currentMin:Point = new Point(int.MAX_VALUE,int.MAX_VALUE);
				
				// Check the 6 adjacent hexagons of the current one and look for the nearest from the center
				// TODO: remove the code duplication with a function (morgan will do it eventually)
				distanceToCenter(_grid.hexToCartesian(hexCoord.add(new Point(1,0)))) < distanceToCenter(currentMin) ?
					currentMin = _grid.hexToCartesian(hexCoord.add(new Point(1,0))) : 1;
				distanceToCenter(_grid.hexToCartesian(hexCoord.add(new Point(-1,0)))) < distanceToCenter(currentMin) ?
					currentMin = _grid.hexToCartesian(hexCoord.add(new Point(-1,0))) : 1;
				distanceToCenter(_grid.hexToCartesian(hexCoord.add(new Point(0,1)))) < distanceToCenter(currentMin) ?
					currentMin = _grid.hexToCartesian(hexCoord.add(new Point(0,1))) : 1;;
				distanceToCenter(_grid.hexToCartesian(hexCoord.add(new Point(0,-1)))) < distanceToCenter(currentMin) ?
					currentMin = _grid.hexToCartesian(hexCoord.add(new Point(0,-1))) : 1;
				distanceToCenter(_grid.hexToCartesian(hexCoord.add(new Point(1,-1)))) < distanceToCenter(currentMin) ?
					currentMin = _grid.hexToCartesian(hexCoord.add(new Point(1,-1))) : 1;
				distanceToCenter(_grid.hexToCartesian(hexCoord.add(new Point(-1,1)))) < distanceToCenter(currentMin) ?
					currentMin = _grid.hexToCartesian(hexCoord.add(new Point(-1,1))) : 1;

				block.x = currentMin.x;
				block.y = currentMin.y;
			}
		}
		
		private function distanceToCenter(point:Point) : uint
		{
			return Math.sqrt(Math.pow(point.x - _stage.stageWidth/2, 2) + Math.pow(point.y - _stage.stageHeight/2, 2));
		}
	}
}
