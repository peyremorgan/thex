package fr.manashield.flex.thex {
	import flash.display.Stage;
	/**
	 * @author Morgan
	 */
	public class HexagonalGrid 
	{
		protected var grid:Object = new Object();
		
		public function HexagonalGrid(stage:Stage, cellRadius:int, width:int = 10, height:int = 10) : void
		{
			var diapothem:Number = 2 * cellRadius * Math.cos(Math.PI/6);  // 1 diapothem = 2 times the apothem
			var x:int, y:int;
			
			for(var u:int = -width/2; u < width/2; ++u)
			for(var v:int = -height/2; v < height/2; ++v)
			{
				x = diapothem*u*Math.cos(Math.PI/6) + stage.stageWidth/2;
				y = diapothem*(u*Math.sin(Math.PI/6) + v) + stage.stageHeight/2;
				
				this.grid[[u, v]] = new HexagonalCell(x, y);
			}
		}
		
		public function 
	}
}
