package fr.manashield.flex.thex 
{
	import flash.geom.Point;
	/**
	 * @author Morgan
	 */
	public class HexagonalCell 
	{
		protected var _center:Point;
		protected var _parent:HexagonalGrid;
		
		public function HexagonalCell(x:int, y:int, parent:HexagonalGrid = null)
		{
			_center = new Point(x, y);
			_parent = parent;
		}
		
		public function get center():Point
		{
			return _center;
		}
		
		public function get parent():HexagonalGrid
		{
			return _parent;
		}
		
		public function get hexCoordinates():Point
		{
			return this.parent.cartesianToHex(this.center);
		}
	}
}
