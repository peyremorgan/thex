package fr.manashield.flex.thex.userInterface {
	import fr.manashield.flex.thex.utils.Color;

	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Matrix;
	/**
	 * @author Paul
	 */
	public class Banner extends Sprite
	{
		
		protected var _background:Sprite;
		protected var _banner:Sprite;
		protected var _gradientMatrix:Matrix;
		
		public function Banner(stage:Stage):void
		{
			_background = new Sprite();
			_background.graphics.beginFill(Color.WHITE.hexValue);
			_background.graphics.drawRect(-stage.fullScreenWidth,-stage.fullScreenHeight,2*stage.fullScreenWidth, 2*stage.fullScreenHeight);
			_background.graphics.endFill();
			_background.alpha = 0.5;
			this.addChild(_background);
			
			_banner = new Sprite();
			_gradientMatrix = new Matrix();
			_gradientMatrix.createGradientBox(2*stage.fullScreenWidth, stage.stageHeight/2, Math.PI/2, 0, stage.stageHeight/4);
			_banner.graphics.beginGradientFill(GradientType.LINEAR, [0xCCCCCC,0xAAAAAA], [1,1], [0,255], _gradientMatrix);
			_banner.graphics.drawRect(-stage.fullScreenWidth, stage.stageHeight/4, 2*stage.fullScreenWidth, stage.stageHeight/2);
			_banner.graphics.endFill();
			this.addChild(_banner);
		}
	}
}
