package fr.manashield.flex.thex 
{
	import fr.manashield.flex.thex.geometry.Hexagon;

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
			this._currentCell = this._currentCell.parent.cell(newHexCoordinates);
			
			var newCartesianCoordinates:Point = this._currentCell.parent.hexToCartesian(newHexCoordinates);
			this._symbol.x = newCartesianCoordinates.x;
			this._symbol.y = newCartesianCoordinates.y;
		}
	}
}