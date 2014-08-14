package fr.manashield.flex.thex.blocks {
	import fr.manashield.flex.thex.geometry.Hexagon;
	import fr.manashield.flex.thex.utils.CellAlreadyOccupiedError;
	import fr.manashield.flex.thex.utils.Color;

	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Block 
	{
		protected var _currentCell:HexagonalCell;
		protected var _symbol:Hexagon;
		protected var _color:Color;
		protected var _frameNb:uint;
		protected var _frameNbDestroy:uint;

		public function Block(startCell:HexagonalCell, color:Color):void
		{
			if(!startCell.occupied)
			{
				startCell.occupied = true;
			}
			else
			{
				throw new CellAlreadyOccupiedError("Target cell is occupied");
			}
			
			_currentCell = startCell;
			_color = color;
			_symbol = new Hexagon(startCell.center, startCell.parent.gridSize, color.hexValue);
			
			startCell.block = this;
			HexagonalGrid.instance.addChild(this._symbol);
		}
		
		protected function zboing(e:Event):void
		{
			if(_frameNb < 5)
			{
				_symbol.scaleX+=0.06;
				_symbol.scaleY+=0.06;
			}
			else if(_frameNb < 13)
			{
				_symbol.scaleX-=0.06;
				_symbol.scaleY-=0.06;
			}
			else if(_frameNb < 17)
			{
				_symbol.scaleX+=0.06;
				_symbol.scaleY+=0.06;
			}
			else if(_frameNb < 18)
			{
				_symbol.scaleX-=0.06;
				_symbol.scaleY-=0.06;
			}
			else
			{
				_symbol.removeEventListener(Event.ENTER_FRAME, zboing);
			}
			++_frameNb;
		}
		
		public function get symbol():Hexagon
		{
			return _symbol;
		}
		
		public function get distanceToCenter():Number
		{
			return this._currentCell.distanceToCenter;
		}
		
		public function get currentCell():HexagonalCell
		{
			return this._currentCell;
		}
		
		public function moveTo(newHexCoordinates:Point):void
		{
			_currentCell.occupied = false;
			_currentCell.block = null;
			_currentCell = _currentCell.parent.cell(newHexCoordinates);
			_currentCell.occupied = true;
			_currentCell.block = this;
			
			var newCartesianCoordinates:Point = _currentCell.parent.hexToCartesian(newHexCoordinates);
			_symbol.x = newCartesianCoordinates.x;
			_symbol.y = newCartesianCoordinates.y;
			_frameNb = 0;
			_symbol.scaleX = _symbol.scaleY = 1;
			_symbol.addEventListener(Event.ENTER_FRAME, zboing);
		}
		
		public function destroy():void
		{
			_currentCell.occupied = false;
			_currentCell.block = null;

			_frameNbDestroy = 0;
			_symbol.addEventListener(Event.ENTER_FRAME, destroySymbol);
		}
		
		protected function destroySymbol(event:Event):void
		{
			if(_frameNbDestroy < 5)
			{
				_symbol.scaleX += 0.06;
				_symbol.scaleY += 0.06;
			}
			else
			{
				_symbol.removeEventListener(Event.ENTER_FRAME, destroySymbol);
				_symbol.parent.removeChild(this.symbol);
			}
			++_frameNbDestroy;
		}
		
		public function get neighbors():Vector.<Block>
		{
			var neighbors:Vector.<Block> = new Vector.<Block>();
			
			for each(var cell:HexagonalCell in this._currentCell.neighbors)
			{
				if(cell.occupied)
				{
					neighbors.push(cell.block);
				}
			}
			
			return neighbors;
		}
		
		public function get color():Color
		{
			return this._color;
		}
		
		/*
		 * counts the blocks of the same color from near to near
		 */
		public function sameColorNeighbors(visitedBlocks:Vector.<Block> = null):Vector.<Block>
		{		
			if(!visitedBlocks)
			{
				visitedBlocks = new Vector.<Block>();
			}
			
			visitedBlocks.push(this);
			
			for each(var neighbor:Block in this.neighbors)
			{
				if(neighbor.color == visitedBlocks[0].color && visitedBlocks.lastIndexOf(neighbor) == -1)
				{
					neighbor.sameColorNeighbors(visitedBlocks);
				}
			}
			
			return visitedBlocks;
		}
	}
}