package fr.manashield.flex.thex.geometry {
	import flash.display.Shape;
	import flash.geom.Point;
	/**
	 * @author Morgan
	 */
	public class Polygon extends Shape
	{
		protected var _size:uint;
		protected var _color:uint;
		
		public function Polygon(
			sides:uint, 
			origin:Point,
			size:uint, 
			color:uint = 0xFFFFFF, 
			rotation:Number=0)
		{
			this._size = size;
			this._color = color;
			var theta:Number;
			
			this.graphics.lineStyle(2, 0x000000, 0.5);
			
			this.graphics.moveTo(size * Math.cos(rotation), size * Math.sin(rotation));
			this.graphics.beginFill(color);

			for (var i:uint = 1; i<sides; ++i)
			{
				theta = i*2*Math.PI/sides + rotation;
				this.graphics.lineTo(
					size * Math.cos(theta), 
					size * Math.sin(theta)
				);
			}
			
			this.x = origin.x;
			this.y = origin.y;

			this.graphics.endFill();
		}
		
		public function get size():uint
		{
			return _size;
		}
	}
}
