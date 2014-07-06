package fr.manashield.flex.thex {
	import fr.manashield.flex.thex.geometry.Polygon;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Morgan
	 */
	public final class Animation
	{
		public static function initialize(stage:Stage):void
		{
			trace("init : Animation");
			_stage = stage;
			
			_instance.fallTimer.addEventListener(TimerEvent.TIMER, _instance.moveBlocksToCenter);
			_instance.fallTimer.start();
		}
		
		private static var _instance:Animation = new Animation();
		private static var _stage:Stage;
		
		private var fallingBlocks:Vector.<Polygon> = new Vector.<Polygon>();
		private var staticBlocks:Vector.<Polygon> = new Vector.<Polygon>();
		private var fallTimer:Timer = new Timer(1000, 0);
		
		public static function get instance():Animation
		{
			return _instance;
		}
		
		public function addBlock(newBlock:Polygon):void
		{
			this.fallingBlocks.push(newBlock);
		}
		
		private function moveBlocksToCenter(e : Event):void
		{
			for each(var block:Polygon in fallingBlocks)
			{
				moveToCenter(block, block.size);
			}
		}
		
		private function moveToCenter(block:Polygon, shift:Number):void
		{
			// definition de la distance au centre du block
			var distanceX:Number = block.x - _stage.stageWidth/2;
			var distanceY:Number = block.y - _stage.stageHeight/2;
			var apothem:Number = shift*Math.cos(Math.PI/6);

			// Conversion en coordonnées polaires
			var theta:Number = Math.atan2(distanceY,distanceX);
			var r:Number = Math.sqrt(Math.pow(distanceX, 2) + Math.pow(distanceY, 2));
			
			// Cleanup
			if(r <= 3*apothem)
			{
				fallingBlocks.splice(fallingBlocks.lastIndexOf(block), 1);
				staticBlocks.push(block);
			}
			else
			{
				// Translation en r
				var newRadius:Number = r - 2*apothem;
				block.x = _stage.stageWidth/2 + newRadius*Math.cos(theta);
				block.y = _stage.stageHeight/2 + newRadius*Math.sin(theta);
			}
		}
	}
}
