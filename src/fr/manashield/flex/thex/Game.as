package fr.manashield.flex.thex {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fr.manashield.flex.thex.blocks.Block;
	import fr.manashield.flex.thex.blocks.BlockGenerator;
	import fr.manashield.flex.thex.blocks.HexagonalGrid;
	import fr.manashield.flex.thex.events.BlockLandingEvent;
	import fr.manashield.flex.thex.utils.Color;

	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Game
	{
		private static const CELL_RADIUS:uint = 50;
		
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
			stage.addChild(_scoreField);

			var format:TextFormat = new TextFormat();
			format.size = 42;
			format.font = "Showcard Gothic";
			format.color = 0x1bbdcd;
			_scoreField.defaultTextFormat = format;
			_scoreField.text = _score.toString();
			
			/*
			 * click to display score with a different font (and the font name after it)
			 */

//			stage.addEventListener(MouseEvent.MOUSE_DOWN, changeFont);
//			
//			scoreField.width = 9000;
//			
//			var allFonts:Array = Font.enumerateFonts(true);
//			allFonts.sortOn("fontName", Array.CASEINSENSITIVE);
//			
//			var i:uint = 0;
//			function changeFont(e:Event):void
//			{
//				format.font = allFonts[i].fontName;
//				scoreField.defaultTextFormat = format;
//				scoreField.text = _score.toString() + " : " + allFonts[i].fontName;
//				i<allFonts.length-1?i++:1;
//			}
			
			
			// Central hexagon
			var centralBlock:Block = new Block(HexagonalGrid.instance.cell(new Point(0,0)), new Color(0x5c5c5c));
			$(centralBlock); // Get rid of the annoying "not used" warning.
			
			// create first falling block
			BlockGenerator.instance.spawnBlock();
			
			// initialze and launch the animation of the falling blocks
			Animation.initialize(this);
			Animation.instance.addEventListener(BlockLandingEvent.LANDING, this.blockLanded);
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
		
		private function $(o:Object):void{}
	}
}
