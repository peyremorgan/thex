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
		
		public function spawnBlock(radius:uint = 5, index:int = undefined, addToFallingList:Boolean = true):Block
		{
			var newBlock:Block = new Block(HexagonalGrid.instance.cell(new Point(0,radius)), Color.RANDOM);
			
			// Spawn at specified index if any, coerced to [0..6*radius-1]. Else, spawn at random index
			// index = "angular" position on a given hexagonal ring
			var spawnIndex:int = index ? (index<0 ? (6*radius)+index%(6*radius) : index%(6*radius)) : Math.random()*6*radius;
			
			for(var i:int=0; i<spawnIndex; ++i)
			{
				newBlock.moveTo(newBlock.currentCell.clockwiseNeighbor.hexCoordinates);
			}
			
			if(addToFallingList)
			{
				Animation.instance.addBlock(newBlock);
			}
			return newBlock;
		}
		
		public function blockLanded(e:BlockLandingEvent):void
		{
			this.spawnBlock();
		}
	}
}
