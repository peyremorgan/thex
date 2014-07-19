package fr.manashield.flex.thex.geometry {
	import flash.display.Shape;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
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
			var innerSize:uint = size*0.7;
			
			this.graphics.lineStyle(2, 0x000000, 0.5);
			
			//outer polygon
			this.graphics.moveTo(size * Math.cos(rotation), size * Math.sin(rotation));
			this.graphics.beginFill(color);

			for (var i:uint=1; i<sides; ++i)
			{
				theta = i*2*Math.PI/sides + rotation;
				this.graphics.lineTo(
					size * Math.cos(theta), 
					size * Math.sin(theta)
				);
			}
			this.graphics.endFill();
			
			//inner polygon
			var innerColorString:String = "";
			
			for(i=0; i<3; ++i)
			{
				var tempString:String = (parseInt(color.toString(16).slice(0+2*i, 2+2*i), 16)*0.8).toString(16);
				innerColorString = innerColorString.concat((tempString.length==1?"0":"")+tempString);
			}
			var innerColor:uint = parseInt(innerColorString, 16);
			
			this.graphics.moveTo(innerSize * Math.cos(rotation), innerSize * Math.sin(rotation));
			this.graphics.beginFill(innerColor);

			for (i=1; i<sides; ++i)
			{
				theta = i*2*Math.PI/sides + rotation;
				this.graphics.lineTo(
					innerSize * Math.cos(theta), 
					innerSize * Math.sin(theta)
				);
			}
			this.graphics.endFill();
			
			//sides
			for (i=0; i<sides; ++i)
			{
				var sideColor:uint;
				var sideColorString:String = "";
				
				if(i<uint(sides/2)-1)
				{
					for(var j:uint=0; j<3; ++j)
					{
						tempString = (parseInt(color.toString(16).slice(0+2*j, 2+2*j), 16)*0.5).toString(16);
						sideColorString = sideColorString.concat((tempString.length==1?"0":"")+tempString);
					}
					sideColor = parseInt(sideColorString, 16);
				}
				else if(i==uint(sides/2)-1 || i==sides-1)
				{
					for(j=0; j<3; ++j)
					{
						tempString = (parseInt(color.toString(16).slice(0+2*j, 2+2*j), 16)*0.7).toString(16);
						sideColorString = sideColorString.concat((tempString.length==1?"0":"")+tempString);
					}
					sideColor = parseInt(sideColorString, 16);
				}
				else
				{
					sideColor = color;
				}

				this.graphics.beginFill(sideColor);
				
				theta = i*2*Math.PI/sides + rotation;
				var thetaPlus:Number = (i+1)*2*Math.PI/sides + rotation;
				
				this.graphics.moveTo(
					size * Math.cos(theta), 
					size * Math.sin(theta)
				);
				this.graphics.lineTo(
					innerSize * Math.cos(theta), 
					innerSize * Math.sin(theta)
				);
				this.graphics.lineTo(
					innerSize * Math.cos(thetaPlus), 
					innerSize * Math.sin(thetaPlus)
				);
				this.graphics.lineTo(
					size * Math.cos(thetaPlus), 
					size * Math.sin(thetaPlus)
				);
				this.graphics.endFill();
			}
			
			//object placement
			this.x = origin.x;
			this.y = origin.y;
		}
		
		public function get size():uint
		{
			return _size;
		}
	}
}
