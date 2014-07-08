package fr.manashield.flex.thex.geometry
{
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Hexagon extends Polygon
	{
		public function Hexagon(
			origin:Point,
			size:uint,
			color:uint = 0xFFFFFF,
			rotation:Number=0)
		{
			super(6, origin, size, color, rotation);
		}
	}
}
