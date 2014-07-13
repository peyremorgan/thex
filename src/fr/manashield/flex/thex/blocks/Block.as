package fr.manashield.flex.thex.blocks {
	import fr.manashield.flex.thex.geometry.Hexagon;
	import fr.manashield.flex.thex.utils.Color;

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

		public function Block(startCell:HexagonalCell, color:Color):void
		{
			this._currentCell = startCell;
			this._color = color;
			this._symbol = new Hexagon(startCell.center, startCell.parent.gridSize, color.hexValue);
			
			startCell.occupied = true;
			startCell.block = this;
			startCell.parent.stage.addChild(this._symbol);
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
			this._currentCell.occupied = false;
			this._currentCell.block = null;
			this._currentCell = this._currentCell.parent.cell(newHexCoordinates);
			this._currentCell.occupied = true;
			this._currentCell.block = this;
			
			var newCartesianCoordinates:Point = this._currentCell.parent.hexToCartesian(newHexCoordinates);
			this._symbol.x = newCartesianCoordinates.x;
			this._symbol.y = newCartesianCoordinates.y;
		}
		
		public function destroy():void
		{			
			this.currentCell.occupied = false;
			this.currentCell.block = null;
			
			this.symbol.parent.removeChild(this.symbol);
		}
		
		public function destroyIf(color:Color, visitedBlocks:Vector.<Block> = null):void
		{
			if(!visitedBlocks)
			{
				visitedBlocks = new Vector.<Block>();
			}
			
			visitedBlocks.push(this);
			
			if (this._color == color)
			{
				for each(var neighbor:Block in this.neighbors)
				{
					if(neighbor.color == visitedBlocks[0].color && visitedBlocks.lastIndexOf(neighbor) == -1)
					{
						neighbor.destroyIf(color, visitedBlocks);
					}
				}
				
				this.destroy();
			}
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
		public function sameColorNeighbors(visitedBlocks:Vector.<Block> = null):uint
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
			
			return visitedBlocks.length;
		}
	}
}