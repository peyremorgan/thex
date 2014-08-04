package fr.manashield.flex.thex.blocks {
	import fr.manashield.flex.thex.geometry.Hexagon;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class HexagonalGrid extends Sprite
	{
		protected static var _instance:HexagonalGrid;
		
		protected var _grid:Object;
		protected var _gridSize:int;
		
		/*
		 *  create the singleton
		 */
		public static function init(stage:Stage, cellRadius:int, width:int = 100, height:int = 100):void
		{
			_instance = new HexagonalGrid(stage, cellRadius, width, height);
		}
		
		/*
		 * constructor
		 */
		public function HexagonalGrid(stage:Stage, cellRadius:uint, childIndex:uint = 0, width:uint = 100, height:uint = 100) : void
		{
			_grid = new Object();
			_gridSize = cellRadius;
			
			stage.addChildAt(this, childIndex);
			
			for(var u:int = -width/2; u < width/2; ++u)
			for(var v:int = -height/2; v < height/2; ++v)
			{
				_grid[[u, v]] = new HexagonalCell(new Point(u, v), this);
			}
			
			// add background grid
			var radius:uint = Math.min(width,height)/2;
			for(var i:uint=1; i<radius; ++i)
			{
				var currentColor:uint = i%2?0xF5F5F5:0xFAFAFA;	
				var nextCell:HexagonalCell = _grid[[0, i]];
				for(var j:uint=0; j<i*6; ++j)
				{
					nextCell = nextCell.clockwiseNeighbor;
					var hex:Hexagon = new Hexagon(nextCell.center, HexagonalCell(_grid[[0, i]]).parent.gridSize, (j+1)%i?currentColor:0xE8E8E8, "flat");
					addChild(hex);
				}
			}
		}
		
		/*
		 * Hexagonal to Cartesian coordinates conversion (everyone knows that the cartesian doctrine is way better than the hexagonal. repent yourself sinners !)
		 */
		public function hexToCartesian(point:Point) : Point
		{
			var x:int = diapothem()*point.x*Math.cos(Math.PI/6) + Number(stage.stageWidth)/2;
			var y:int = - diapothem()*(point.y + point.x*Math.sin(Math.PI/6)) + Number(stage.stageHeight)/2;
			
			return new Point(x, y);
		}
		
		/*
		 * Cartesian to Hexagonal coordinates conversion
		 */
		public function cartesianToHex(point:Point) : Point
		{
			var u:int = Math.round((point.x - Number(stage.stageWidth)/2)/(diapothem()*Math.cos(Math.PI/6)));
			var v:int = Math.round(-(point.y - Number(stage.stageHeight)/2)/diapothem() - u*Math.sin(Math.PI/6));

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
		 * return the choosen cell. Even throw amazing Errors sometimes.
		 */
		public function cell(hexCoordinates:Point):HexagonalCell
		{
			return this._grid[[hexCoordinates.x,hexCoordinates.y]];
		}
		
		/*
		 * getter for the instance
		 */
		public static function get instance():HexagonalGrid
		{
			return _instance;
		}
		
		public function ring(radius:uint):Vector.<HexagonalCell>
		{
			var cells:Vector.<HexagonalCell> = new Vector.<HexagonalCell>();
			
			var currentCell:HexagonalCell = this.cell(new Point(0,radius));
			for(var i:uint=0; i<6*radius; ++i)
			{
				cells.push(currentCell);
				currentCell = currentCell.clockwiseNeighbor;
			}
			
			return cells;
		}
	}
}
