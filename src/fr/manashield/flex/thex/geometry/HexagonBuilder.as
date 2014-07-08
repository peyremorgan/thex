package fr.manashield.flex.thex.geometry {
	import flash.errors.IllegalOperationError;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class HexagonBuilder extends PolygonBuilder
	{
		public override function build() : Polygon
		{
			return new Hexagon(_origin, _size, _color, _rotation);
		}
		
		public override function set sidesNumber(newSidesNumber:uint):void
		{
			throw new IllegalOperationError();
		}
	}
}
