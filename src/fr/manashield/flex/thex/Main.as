package fr.manashield.flex.thex 
{
	import fr.manashield.flex.thex.geometry.Hexagon;
	import fr.manashield.flex.thex.geometry.HexagonBuilder;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	[SWF(width="600",height="400",backgroundColor="#ffffff")]
	/**
	 * @author Morgan Peyre
	 * @author Paul Bonnet
	 */
	public class Main extends Sprite 
	{
		protected var _origin : Point = new Point();

		public function Main() : void 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e : Event = null) : void 
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var gameGrid:HexagonalGrid = new HexagonalGrid(stage, 50);
			
			// Entry point
			//_origin.x = this.stage.stageWidth / 2;
			//_origin.y = this.stage.stageHeight / 2;
			_origin = gameGrid.hexToCart(0,0);

			// Central hexagon
			var mainHexagonBuilder : HexagonBuilder = new HexagonBuilder();
			mainHexagonBuilder.origin = _origin;
			mainHexagonBuilder.size = 50;
			mainHexagonBuilder.color = 0x1BBDCD;

			var centralHex : Hexagon = Hexagon(mainHexagonBuilder.build());			
			this.addChild(centralHex);
			
			// Others hexagons test
			Animation.initialize(this.stage);
			
			mainHexagonBuilder.origin = gameGrid.hexToCart(1, 0);
			var testBlock1:Hexagon = Hexagon(mainHexagonBuilder.build());
			this.addChild(testBlock1);
		}
	}
}