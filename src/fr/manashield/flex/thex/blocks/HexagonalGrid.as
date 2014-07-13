package fr.manashield.flex.thex.blocks {
	import fr.manashield.flex.thex.geometry.Hexagon;
	import fr.manashield.flex.thex.utils.Color;

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
		
		
		/*
		 *  create the singleton
		 */
		public static function init(stage:Stage, cellRadius:int, width:int = 25, height:int = 25):void
		{
			_instance = new HexagonalGrid(stage, cellRadius, width, height);
		}
		
		/*
		 * constructor
		 */
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
			
			// add background grid
			for(var i:uint=1; i<6; ++i)
			{
				var currentColor:uint = Color.COLORS[i].hexValue;
				var hex:Hexagon = new Hexagon(_grid[[0, i]].center, _grid[[0, i]].parent.gridSize, currentColor);
				hex.alpha = 0.1;
				_stage.addChild(hex);
				
				var nextCell:HexagonalCell = _grid[[0, i]];
				while((nextCell = nextCell.clockwiseNeighbor) != _grid[[0, i]])
				{
					hex = new Hexagon(nextCell.center, _grid[[0, i]].parent.gridSize, currentColor);
					hex.alpha = 0.1;
					_stage.addChild(hex);
				}
			}
			
			HexagonalCell(_grid[[0,0]]).occupied = true;
		}
		
		/*
		 * Hexagonal to Cartesian coordinates conversion (everyone knows that the cartesian doctrine is way better than the hexagonal. repent yourself sinners !)
		 */ 
		public function hexToCartesian(point:Point) : Point
		{
			var x:int = diapothem()*point.x*Math.cos(Math.PI/6) + Number(_stage.stageWidth)/2;
			var y:int = - diapothem()*(point.y + point.x*Math.sin(Math.PI/6)) + Number(_stage.stageHeight)/2;
			
			return new Point(x, y);
		}
		
		/*
		 * Cartesian to Hexagonal coordinates conversion
		 */
		public function cartesianToHex(point:Point) : Point
		{
			var u:int = Math.round((point.x - Number(_stage.stageWidth)/2)/(diapothem()*Math.cos(Math.PI/6)));
			var v:int = Math.round(-(point.y - Number(_stage.stageHeight)/2)/diapothem() - u*Math.sin(Math.PI/6));

			return new Point(u, v);
		}
		
		/*
		 * getter for the grid's size
		 */
		public function get gridSize():int
		{
			return this._gridSize;
		}

		/*
		 * Super badass function to calculate the apothem (i'm sure you didn't even heard about it before),
		 * and then multiply it by 2 ! How crazy is that ?
		 */
		protected function diapothem():Number
		{
			return 2 * _gridSize * Math.cos(Math.PI/6);
		}
		
		/*
		 * getter for the stage, where you can add all your displayable objects
		 */
		public function get stage():Stage
		{
			return _stage;
		}
		
		/*
		 * return the cell choosen. Even throw amazing Error sometimes.
		 */
		public function cell(hexCoordinates:Point):HexagonalCell
		{
			if(hexCoordinates.x > 10) throw new Error("CACA !");
			return this._grid[[hexCoordinates.x,hexCoordinates.y]];
		}
		
		/*
		 * getter for the instance
		 */
		public static function get instance():HexagonalGrid
		{
			return _instance;
		}
	}
}
