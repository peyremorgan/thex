package fr.manashield.flex.thex 
{
	import flash.geom.Point;
	/**
	 * @author Morgan
	 */
	public class HexagonalCell 
	{
		protected var _center:Point;
		//protected var neighbors:Vector.<HexagonalCell>;
		
		public function HexagonalCell(x:int, y:int)
		{
			_center = new Point(x, y);
		}
		
		public function get center():Point
		{
			return _center;
		}
	}
}
