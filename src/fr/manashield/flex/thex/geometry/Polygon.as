package fr.manashield.flex.thex.geometry {
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Polygon extends Sprite
	{
		protected var _size:uint;
		protected var _color:uint;
		
		public function Polygon(
			sides:uint, 
			origin:Point,
			size:uint, 
			color:uint = 0xFFFFFF,
			shape:String="emboss", 
			rotation:Number=0)
		{
			_size = size;
			_color = color;
			var innerSize:uint = size*0.7;
			var shadingRatio:Number = 0.3;
			
			var theta:Number;
			
			switch(shape){
				case "emboss":
					break;
					
				case "flat":
					this.graphics.lineStyle(2, 0xD8D8D8, 0.5);
					break;
			}
			
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
			
			if(shape == "emboss")
			{
				//inner polygon
				this.graphics.moveTo(innerSize * Math.cos(rotation), innerSize * Math.sin(rotation));
				this.graphics.beginFill(darkenColor(color, 0.7));
	
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
					var sideColor:uint = darkenColor(color, shadingRatio*Math.min(i, sides-i));

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
			}
			//object placement
			this.x = origin.x;
			this.y = origin.y;
		}
		
		public function get size():uint
		{
			return _size;
		}
		
		protected function darkenColor(color:uint, factor:Number):uint
		{
			var newColorString:String = "";
			for(var i:uint=0; i<3; ++i)
			{
				var tempString:String = (parseInt(color.toString(16).slice(0+2*i, 2+2*i), 16)*factor).toString(16);
				newColorString = newColorString.concat((tempString.length==1?"0":"")+tempString);
			}
			return parseInt(newColorString, 16);
		}
	}
}
