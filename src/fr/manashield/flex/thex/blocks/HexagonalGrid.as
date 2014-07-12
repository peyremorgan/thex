package fr.manashield.flex.thex.blocks
{
	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class HexagonalGrid 
	{
		protected static var _instance:HexagonalGrid;
		
		protected var _grid:Object;
		protected var _stage:Stage;
		protected var _gridSize:int;
		
		public static function init(stage:Stage, cellRadius:int, width:int = 25, height:int = 25):void
		{
			_instance = new HexagonalGrid(stage, cellRadius, width, height);
		}
		
		public function HexagonalGrid(stage:Stage, cellRadius:int, width:int = 25, height:int = 25) : void
		{			
			_grid = new Object();
			_stage = stage;
			_gridSize = cellRadius;
			
			for(var u:int = -width/2; u < width/2; ++u)
			for(var v:int = -height/2; v < height/2; ++v)
			{
				_grid[[u, v]] = new HexagonalCell(new Point(u, v), this);
			}
		}
		
		// Hexagonal to Cartesian coordinates conversion
		public function hexToCartesian(point:Point) : Point
		{
			//TODO: improve this method or remove the center attribute of the hexagonalCell
			var x:int = diapothem()*point.x*Math.cos(Math.PI/6) + Number(_stage.stageWidth)/2;
			var y:int = - diapothem()*(point.y + point.x*Math.sin(Math.PI/6)) + Number(_stage.stageHeight)/2;
			
			return new Point(x, y);
		}
		
		public function cartesianToHex(point:Point) : Point
		{
			var u:int = Math.round((point.x - Number(_stage.stageWidth)/2)/(diapothem()*Math.cos(Math.PI/6)));
			var v:int = Math.round(-(point.y - Number(_stage.stageHeight)/2)/diapothem() - u*Math.sin(Math.PI/6));

			return new Point(u, v);
		}
		
		public function get gridSize():int
		{
			return this._gridSize;
		}

		protected function diapothem():Number
		{
			return 2 * _gridSize * Math.cos(Math.PI/6);  // 1 diapothem = 2 times the apothem
		}
		
		public function get stage():Stage
		{
			return _stage;
		}
		
		public function cell(hexCoordinates:Point):HexagonalCell
		{
			if(hexCoordinates.x > 10) throw new Error("CACA !");
			return this._grid[[hexCoordinates.x,hexCoordinates.y]];
		}
		
		public static function get instance():HexagonalGrid
		{
			return _instance;
		}
	}
}
