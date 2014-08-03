package fr.manashield.flex.thex.userInterface {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * @author Paul
	 */
	public class buttonLayer extends Sprite
	{
		
		public function buttonLayer(X:uint, Y:uint, width:uint, height:uint, textFormat:TextFormat, text:String, selected:Boolean, backgroundColor:uint = 0xFFFFFF)
		{
			graphics.beginFill(backgroundColor);
			graphics.drawRect(X, Y, width, height);
			graphics.endFill();
			
			var buttonText:TextField = new TextField();
			buttonText.defaultTextFormat = textFormat;
			buttonText.embedFonts = true;
			buttonText.text = text;
			buttonText.height = height;
			buttonText.width = width;
			buttonText.x = X;
			buttonText.y = Y;
			buttonText.selectable = false;
			addChild(buttonText);
			
			if(selected)
			{
				var side:uint = height*0.5;
				
				var leftArrow:Sprite = new Sprite();
				leftArrow.graphics.beginFill(backgroundColor);
				leftArrow.graphics.lineTo(-side*Math.sqrt(3/4), -side/2);
				leftArrow.graphics.lineTo(-side*Math.sqrt(3/4), side/2);
				leftArrow.graphics.endFill();
				leftArrow.x = X-height/3;
				leftArrow.y = Y+height/2;
				addChild(leftArrow);
				
				var rightArrow:Sprite = new Sprite();
				rightArrow.graphics.beginFill(backgroundColor);
				rightArrow.graphics.lineTo(side*Math.sqrt(3/4), -side/2);
				rightArrow.graphics.lineTo(side*Math.sqrt(3/4), side/2);
				rightArrow.graphics.endFill();
				rightArrow.x = X+width+height/3;
				rightArrow.y = Y+height/2;
				addChild(rightArrow);
			}
		}
	}
}
