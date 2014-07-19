package fr.manashield.flex.thex.geometry 
{
	import flash.geom.Point;

	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class PolygonBuilder 
	{
		/* Default values */
		protected static const defaultSidesNumber : uint = 3;
		protected static const defaultOrigin : Point = new Point();
		protected static const defaultSize : uint = 0;
		protected static const defaultColor : uint = 0xFFFFFF;
		protected static const defaultShape : String = "emboss";
		protected static const defaultRotation : Number = 0;
		
		/* Parameters */
		protected var _sidesNumber : uint;
		protected var _origin : Point;
		protected var _size : uint;
		protected var _color : uint;
		protected var _shape : String;
		protected var _rotation : Number;
		
		/* Constructor */
		public function PolygonBuilder() {
			_sidesNumber = defaultSidesNumber;
			_origin = defaultOrigin;
			_size = defaultSize;
			_color = defaultColor;
			_shape = defaultShape;
			_rotation = defaultRotation;
		}
		
		/* Setters */
		public function set sidesNumber(newSidesNumber : uint) : void { _sidesNumber = newSidesNumber; }
		public function set origin(newOrigin : Point) : void { _origin = newOrigin; }
		public function set size(newSize : uint) : void { _size = newSize; }
		public function set color(newColor : uint) : void { _color = newColor; }
		public function set rotation(newRotation : Number) : void { _rotation = newRotation; }
		
		/* Build method */
		public function build() : Polygon
		{
			return new Polygon(_sidesNumber, _origin, _size, _color, _shape, _rotation);
		}
	}
}
