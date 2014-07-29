package fr.manashield.flex.thex.blocks {
	import fr.manashield.flex.thex.Animation;
	import fr.manashield.flex.thex.events.BlockLandingEvent;
	import fr.manashield.flex.thex.utils.Color;

	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class BlockGenerator
	{
		public static var _instance:BlockGenerator;
		
		/*static*/
		{
			Animation.instance.addEventListener(BlockLandingEvent.LANDING, BlockGenerator.instance.blockLanded);
		}
		
		public static function get instance():BlockGenerator
		{
			return _instance?_instance:_instance=new BlockGenerator();
		}
		
		public function spawnBlock(radius:uint = 7, index:int = Infinity, addToFallingList:Boolean = true):Block
		{
			var cell:HexagonalCell = HexagonalGrid.instance.cell(new Point(0,radius));
			
			// Spawn at specified index if any, coerced to [0..6*radius-1]. Else, spawn at random index
			// index = "angular" position on a given hexagonal ring
			var spawnIndex:int = (index != Infinity ? (index<0 ? (6*radius)+index%(6*radius) : index%(6*radius)) : Math.random()*6*radius);
			
			for(var i:int=0; i<spawnIndex; ++i)
			{
				cell = cell.clockwiseNeighbor;
			}
			
			var blockColor:Color;
			if(addToFallingList)
			{
				blockColor = Animation.instance.activeColors()[uint(Math.random()*Animation.instance.activeColors().length)];
			}
			else
			{
				blockColor = Color.RANDOM;
			}
			
			var newBlock:Block = new Block(cell, blockColor);
			Animation.instance.addBlock(newBlock, addToFallingList);
			
			return newBlock;
		}
		
		public function blockLanded(e:BlockLandingEvent):void
		{
			this.spawnBlock();
		}
	}
}
