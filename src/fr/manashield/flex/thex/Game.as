package fr.manashield.flex.thex {
	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Game
	{
		protected var _stage:Stage;
		protected var _origin:Point;
		protected var _gameGrid:HexagonalGrid;
		
		public function Game(stage:Stage):void
		{
			// Game board
			_stage = stage;
			_gameGrid = new HexagonalGrid(_stage, 50);
			_origin = _origin = _gameGrid.hexToCartesian(new Point(0,0));
			
			// Central hexagon
			var centralBlock:Block = new Block(_gameGrid.cell(new Point(0,0)), Color.BLUE);
			
			// hex test
			var toto:Block = new Block(_gameGrid.cell(new Point(0,3)), Color.RED);
			
			Animation.initialize(this);
			Animation.instance.addBlock(toto);
		}
		
		public function get stage():Stage	
		{
			return _stage;
		}
		
		public function get grid():HexagonalGrid
		{
			return _gameGrid;
		}
	}
}
