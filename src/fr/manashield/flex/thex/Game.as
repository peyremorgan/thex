package fr.manashield.flex.thex {
	import fr.manashield.flex.thex.events.BlockLandingEvent;
	import fr.manashield.flex.thex.blocks.Block;
	import fr.manashield.flex.thex.blocks.BlockGenerator;
	import fr.manashield.flex.thex.blocks.HexagonalGrid;
	import fr.manashield.flex.thex.utils.Color;

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
			var centralBlock:Block = new Block(HexagonalGrid.instance.cell(new Point(0,0)), new Color(0x5c5c5c));
			$(centralBlock); // Get rid of the annoying "not used" warning.
			
			/*new Block(HexagonalGrid.instance.cell(new Point(1,0)), Color.BLUE);
			new Block(HexagonalGrid.instance.cell(new Point(2,0)), Color.BLUE);
			new Block(HexagonalGrid.instance.cell(new Point(3,0)), Color.BLUE);
			new Block(HexagonalGrid.instance.cell(new Point(4,0)), Color.BLUE);
			new Block(HexagonalGrid.instance.cell(new Point(5,0)), Color.BLUE);
			new Block(HexagonalGrid.instance.cell(new Point(6,0)), Color.BLUE);
			
			new Block(HexagonalGrid.instance.cell(new Point(1,-1)), new Color(0xCACAAA));
			new Block(HexagonalGrid.instance.cell(new Point(2,-1)), new Color(0xCACAAA));*/
			
			BlockGenerator.instance.spawnBlock();
			
			Animation.initialize(this);
			Animation.instance.addEventListener(BlockLandingEvent.LANDING, this.blockLanded);
		}
		
		public function get stage():Stage	
		{
			return _stage;
		}
		
		public function blockLanded(e:BlockLandingEvent):void
		{
			if(e.block.sameColorNeighbors() >= 3)
			{
				e.block.destroyIf(e.block.color);
			}
		}
		
		private function $(o:Object):void{}
	}
}
