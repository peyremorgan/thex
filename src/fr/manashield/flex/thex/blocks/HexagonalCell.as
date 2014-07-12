package fr.manashield.flex.thex.blocks 
{
	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class HexagonalCell 
	{
		protected var _hexCoordinates:Point;
		protected var _parent:HexagonalGrid;
		protected var _isOccupied:Boolean;
		protected var _block:Block;
		
		public function HexagonalCell(position:Point, parent:HexagonalGrid = null, occupied:Boolean = false, block:Block = null)
		{
			_hexCoordinates = position;
			_parent = parent;
			_isOccupied = occupied;
			_block = block;
		}
		
		public function get center():Point
		{
			return this.parent.hexToCartesian(_hexCoordinates);
		}
		
		public function get parent():HexagonalGrid
		{
			return _parent;
		}
		
		public function get hexCoordinates():Point
		{
			return _hexCoordinates;
		}
		
		public function get neighbors():Vector.<HexagonalCell>
		{
			var neighbors:Vector.<HexagonalCell> = new Vector.<HexagonalCell>();
			for(var i:int=-1; i<=1; i+=2)
			{
				neighbors.push(this._parent.cell(new Point(_hexCoordinates.x + i, _hexCoordinates.y - i)));
				neighbors.push(this._parent.cell(new Point(_hexCoordinates.x + i, _hexCoordinates.y)));
				neighbors.push(this._parent.cell(new Point(_hexCoordinates.x, _hexCoordinates.y - i)));
			}

			return neighbors;
		}
		
		public function get nearestNeighborToCenter():HexagonalCell
		{
			if(this.hexCoordinates == new Point(0,0)) return this;
			
			var closeCell:HexagonalCell;
			var shortestSquareDistance:uint = uint.MAX_VALUE;
			var candidateSquareDistance:uint;
			
			for each(var cell:HexagonalCell in this.neighbors)
			{
				candidateSquareDistance = Math.pow(cell.center.x - _parent.stage.stageWidth/2, 2) + Math.pow(cell.center.y - _parent.stage.stageHeight/2, 2);
				
				if(candidateSquareDistance < shortestSquareDistance)
				{
					shortestSquareDistance = candidateSquareDistance;
					closeCell = cell;
				}
			}
			
			return closeCell;
		}
		
		public function get distanceToCenter():Number
		{
			var stage:Stage = this.parent.stage;
			var origin:Point = new Point(stage.stageWidth/2, stage.stageHeight/2);
			
			return Point.distance(this.center, origin);
		}
		
		public function get clockwiseNeighbor():HexagonalCell
		{
			var x:Number = _hexCoordinates.x;
			var y:Number = _hexCoordinates.y;
			var sign:Number;
			
			if(x*y > 0 || x == 0)
			{
				sign = (y>0?1:-1);
				
				x+=sign;
				y-=sign;
			} else
			{
				sign = (x>0?1:-1);
				
				Math.abs(x)>Math.abs(y)?y-=sign:x-=sign;
			}
			
			return this._parent.cell(new Point(x, y));
		}

		public function get counterClockwiseNeighbor():HexagonalCell
		{
			var x:Number = _hexCoordinates.x;
			var y:Number = _hexCoordinates.y;
			var sign:Number;
			
			if(x*y > 0 || y == 0)
			{
				sign = (x>0?1:-1);
				
				x-=sign;
				y+=sign;
			} else
			{
				sign = (y>0?1:-1);
				
				Math.abs(x)>=Math.abs(y)?y-=sign:x-=sign;
			}
			
			return this._parent.cell(new Point(x, y));
		}
		
		public function get occupied():Boolean
		{
			return this._isOccupied;
		}
		
		public function set occupied(newState:Boolean):void
		{
			this._isOccupied = newState;
		}
		
		public function get block():Block
		{
			return this._block;
		}
		
		public function set block(newBlock:Block):void
		{
			this._block = newBlock;
		}
	}
}
