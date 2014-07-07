package fr.manashield.flex.thex 
{
	import fr.manashield.flex.thex.geometry.Hexagon;
	/**
	 * @author Morgan
	 */
	public class Block 
	{
		protected var _currentCell:HexagonalCell;
		protected var _symbol:Hexagon;
		
		public function Block(startCell:HexagonalCell, color:Color):void
		{
			this._currentCell = startCell;
			this._symbol = new Hexagon(startCell.center, startCell.parent.gridSize, color.hexValue);
		}
	}
}
