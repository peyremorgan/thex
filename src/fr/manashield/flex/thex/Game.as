package fr.manashield.flex.thex 
{
	import fr.manashield.flex.thex.blocks.Block;
	import fr.manashield.flex.thex.blocks.BlockGenerator;
	import fr.manashield.flex.thex.blocks.HexagonalGrid;
	import fr.manashield.flex.thex.events.BlockLandingEvent;
	import fr.manashield.flex.thex.utils.Color;
	
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Game
	{
		private static const CELL_RADIUS:uint = 25;
		
		protected var _stage:Stage;
		protected var _origin:Point;
		protected var _score:uint;
		protected var _scoreField:TextField;
		
		public function Game(stage:Stage):void
		{
			// Game board
			_stage = stage;
			HexagonalGrid.init(_stage, CELL_RADIUS);
			_origin = _origin = HexagonalGrid.instance.hexToCartesian(new Point(0,0));
			
			// Score field
			_score = 0;
			
			_scoreField = new TextField();
			_scoreField.name = "_scoreField";
			// TODO : repositionner le texte en fonction du ratio d'aspect
			_scoreField.autoSize = TextFieldAutoSize.LEFT;
			stage.addChild(_scoreField);

			var format:TextFormat = new TextFormat();
			format.size = 100;
			format.font = "score";
			format.color = 0x555555;
			format.letterSpacing = 4;
			_scoreField.defaultTextFormat = format;
			_scoreField.embedFonts = true;
			_scoreField.text = _score.toString();
			
			// central hexagon
			var centralBlock:Block = new Block(HexagonalGrid.instance.cell(new Point(0,0)), new Color(0x5c5c5c));
			$(centralBlock); // Get rid of the annoying "not used" warning.
			
			// reate the initial blocks
			this.fillGrid();
			
			// initialze and launch the animation of the falling blocks
			Animation.initialize(this);
			Animation.instance.addEventListener(BlockLandingEvent.LANDING, this.blockLanded);
			
			// create first falling block
			BlockGenerator.instance.spawnBlock();
		}
		
		public function get stage():Stage	
		{
			return _stage;
		}
		
		public function blockLanded(e:BlockLandingEvent):void
		{
			if(e.block.sameColorNeighbors() >= 3)
			{
				_score += e.block.sameColorNeighbors() - 2;
				_scoreField.text = _score.toString();

				e.block.destroyIf(e.block.color);
			}
		}
		
		protected function fillGrid(radius:uint = 3):void
		{
			for(var i:uint=1; i<=radius; ++i)
			{
				for(var j:uint=0; j<6*i; ++j)
				{
					BlockGenerator.instance.spawnBlock(i, j, false);
				}
			}
		}
		
		//useless function used to get rid of a warning
		private function $(o:Object):void{}
	}
}
