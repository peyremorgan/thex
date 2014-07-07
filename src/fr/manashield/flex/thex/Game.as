package fr.manashield.flex.thex {
	import fr.manashield.flex.thex.geometry.Hexagon;
	import fr.manashield.flex.thex.geometry.HexagonBuilder;
	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 * @author Morgan
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
			var gameHexagonBuilder : HexagonBuilder = new HexagonBuilder();
			gameHexagonBuilder.origin = _origin;
			gameHexagonBuilder.size = 50;
			gameHexagonBuilder.color = 0x1BBDCD;
			
			var centralHex:Hexagon = Hexagon(gameHexagonBuilder.build());
			_stage.addChild(centralHex);
			
			// hex test
			gameHexagonBuilder.origin = _gameGrid.hexToCartesian(new Point(3,1));
			gameHexagonBuilder.color = 0xFFFF00;
			var toto:Hexagon = Hexagon(gameHexagonBuilder.build());
			
			_stage.addChild(toto);
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
