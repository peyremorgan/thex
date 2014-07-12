package fr.manashield.flex.thex
{
	import fr.manashield.flex.thex.events.BlockLandingEvent;
	import fr.manashield.flex.thex.blocks.BlockGenerator;
	import fr.manashield.flex.thex.utils.Color;
	import fr.manashield.flex.thex.blocks.Block;
	import fr.manashield.flex.thex.blocks.HexagonalGrid;

	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Game
	{
		private static const CELL_RADIUS:uint = 50;
		
		protected var _stage:Stage;
		protected var _origin:Point;
		
		public function Game(stage:Stage):void
		{
			// Game board
			_stage = stage;
			HexagonalGrid.init(_stage, CELL_RADIUS);
			_origin = _origin = HexagonalGrid.instance.hexToCartesian(new Point(0,0));
			
			// Central hexagon
			var centralBlock:Block = new Block(HexagonalGrid.instance.cell(new Point(0,0)), new Color(0xCACAAA));
			$(centralBlock); // Get rid of the annoying "not used" warning.
			
			BlockGenerator.instance.spawnBlock();
			
			Animation.initialize(this);
		}
		
		public function get stage():Stage	
		{
			return _stage;
		}
		
		private function $(o:Object):void{}
	}
}
