package fr.manashield.flex.thex.geometry {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Sparkle extends Sprite
	{
		protected var _frame:uint;

		public function Sparkle(pos:Point)
		{			
			this.graphics.moveTo(0, 8);
			this.graphics.beginFill(0xffffff);
			/*
			this.graphics.cubicCurveTo(0.4, 0.4, 0.4, 0.4, 8, 0);
			this.graphics.cubicCurveTo(0.4, -0.4, 0.4, -0.4, 0, -8);
			this.graphics.cubicCurveTo(-0.4, -0.4, -0.4, -0.4, -8, 0);
			this.graphics.cubicCurveTo(-0.4, 0.4, -0.4, 0.4, 0, 8);
			/*/
			this.graphics.curveTo(0.4, 0.4, 8, 0);
			this.graphics.curveTo(0.4, -0.4, 0, -8);
			this.graphics.curveTo(-0.4, -0.4, -8, 0);
			this.graphics.curveTo(-0.4, 0.4, 0, 8);
			this.graphics.endFill();
			 /**/
			
			this.x = pos.x;
			this.y = pos.y;
			
			this.alpha = 0;
			
			_frame = 0;
			this.addEventListener(Event.ENTER_FRAME, shine);
		}
		
		private function shine(e:Event=null):void {
			if(_frame < 10) {
				this.alpha += 0.1;
			}
			else if(_frame < 20) {
				this.alpha -= 0.1;
			}
			else {
				this.removeEventListener(Event.ENTER_FRAME, shine);
				this.parent.removeChild(this);
			}
			++_frame;
		}
	}
}