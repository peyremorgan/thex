package fr.manashield.flex.thex {
	import fr.manashield.flex.thex.events.MenuEvent;
	import fr.manashield.flex.thex.events.NewGameEvent;
	import fr.manashield.flex.thex.events.ThexEventDispatcher;
	import fr.manashield.flex.thex.userInterface.ButtonLayer;

	import flash.display.GradientType;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Menu extends Sprite
	{
		//private static const BUTTON:String = "button";
		
		protected var _activeButton:SimpleButton;
		protected var _frame:uint;
		protected var _stage:Stage;
		protected const _fadeOutDuration:Number = 0.5; // In seconds
		
		/*
		protected const _buttons:Object = [
			["Campaign", campaign],
			["Normal", normal],
			["Settings", settings]
		];*/
		protected const _buttons:Object = [
			{
				title:"Campaign",
				method:campaign,
				button:null
			},
			{
				title:"Normal",
				method:normal,
				button:null
			},
			{
				title:"Settings",
				method:settings,
				button:null
			}
		];
		
		/*
		 * graphic elements
		 */
		protected var _background:Sprite;
		protected var _banner:Sprite;

		/*
		 * scaling constants
		 */
		protected static const _bannerWidthScale:Number 		= 1;
		protected static const _bannerHeightScale:Number 		= 1;
		
		protected static const _buttonsWidthScale:Number 		= 0.5;
		protected static const _buttonsHeightScale:Number 		= 0.5;
		
		protected static const _titleWidthScale:Number 			= 0.8;
		protected static const _titleHeightScale:Number 		= 0.2;
		
		protected static const _topMarginScale:Number 			= 0;
		protected static const _interButtonScale:Number			= 0.1;
		protected static const _buttonsTopMarginScale:Number	= 0.1;


		/*
		 * working variables
		 */
		protected var _bannerWidth:uint;
		protected var _bannerHeight:uint;
		
		protected var _buttonWidth:uint;
		protected var _buttonHeight:uint;
		
		protected var _titleWidth:uint;
		protected var _titleHeight:uint;
		
		protected var _topMargin:uint;
		protected var _buttonsTopMargin:uint;
		protected var _interbuttonMargin:uint;
		
		public function Menu(stage:Stage, animateIn:Boolean=true)
		{
			_frame = 0;
			_stage = stage;
			
			calculateResolutionDependentVariables();
			createBanner("THEX");
			createButtons();
			addEventListeners();
			
			if(animateIn)
			{
				this.y -= _stage.stageHeight;
				_stage.addChild(this);
				fadeIn();
			}
			else
			{
				_stage.addChild(this);
			}
		}
		
		protected function calculateResolutionDependentVariables():void
		{
			_bannerWidth = _stage.stageWidth*_bannerWidthScale;
			_bannerHeight = _stage.stageHeight*_bannerHeightScale;
			_buttonWidth = _stage.stageWidth*_buttonsWidthScale;
			_buttonHeight = _stage.stageWidth*(_buttonsHeightScale/numberOfButtons-_interButtonScale);
			_titleWidth = _stage.stageWidth*_titleWidthScale;
			_titleHeight = _stage.stageHeight*_titleHeightScale;
			_topMargin = _stage.stageHeight*_topMarginScale;
			_buttonsTopMargin = _stage.stageHeight*_buttonsTopMarginScale;
			_interbuttonMargin = _stage.stageHeight*_interButtonScale;
		}
		
		protected function createBanner(title:String = ""):void
		{
			var _gradientMatrix:Matrix = new Matrix();
			_gradientMatrix.createGradientBox(2*_stage.fullScreenWidth, _stage.stageHeight/2, Math.PI/2, 0, _stage.stageHeight/4);
			_banner = new Sprite();
			_banner.graphics.beginGradientFill(GradientType.LINEAR, [0xCCCCCC,0xAAAAAA], [1,1], [0,255], _gradientMatrix);
			_banner.graphics.drawRect((_stage.stageWidth-_bannerWidth)/2, (_stage.stageHeight-_bannerHeight)/2, _bannerWidth, _bannerHeight);
			_banner.graphics.endFill();
			this.addChild(_banner);
			
			_banner.addChild(createTitle(title));
		}
		
		private function createTitle(title:String):TextField {
			var titleText:TextField = new TextField();
			var titleTextFormat:TextFormat = new TextFormat("menuTitle", _titleHeight, 0xFFFFFF);
			titleTextFormat.align = TextFormatAlign.CENTER;
			titleText.defaultTextFormat = titleTextFormat;
			titleText.embedFonts = true;
			titleText.text = title;
			titleText.height = height;
			titleText.width = width;
			titleText.x = (_stage.stageWidth - titleText.width)/2;
			titleText.y = _topMargin;
			titleText.selectable = false;
			return titleText;
		}
		
		protected function createButtons():void
		{
			for (var i:uint=0; i < numberOfButtons; ++i)
			{
				_buttons[i].button = createButton(
					_buttons[i], 
					_buttonWidth, 
					_buttonHeight,
					(_stage.stageWidth - _buttonWidth)/2,
					_titleHeight+_buttonsTopMargin+(i+1)*(_buttonHeight+_interbuttonMargin)
				);
			}
			
			toggleON(_activeButton = _buttons[0].button);
		}
		
		private function addEventListeners():void {
			ThexEventDispatcher.instance.addEventListener(MenuEvent.NEXT_ITEM, nextItem);
			ThexEventDispatcher.instance.addEventListener(MenuEvent.PREVIOUS_ITEM, previousItem);
			ThexEventDispatcher.instance.addEventListener(MenuEvent.SELECT, select);
		}
		
		public function fadeIn(e:Event=null):void
		{
			++_frame;
			
			if(_frame == 1)
			{
				addEventListener(Event.ENTER_FRAME, fadeIn);
			}
			
			if(_frame<=_stage.frameRate*_fadeOutDuration)
			{
				this.y += _stage.stageHeight/(_stage.frameRate*_fadeOutDuration);
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, fadeIn);
				_frame = 0;
			}
		}
		
		public function fadeOut(e:Event=null):void
		{
			++_frame;
			
			if(_frame == 1)
			{
				addEventListener(Event.ENTER_FRAME, fadeOut);
			}
			
			if(_frame<=_stage.frameRate*_fadeOutDuration)
			{
				this.y -= _stage.stageHeight/(_stage.frameRate*_fadeOutDuration);
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, fadeOut);
				this.destroy();
				_frame = 0;
			}
		}
		
		private function destroy():void
		{
			for(var i:String in _buttons)
			{
				_buttons[i].button.removeEventListener(MouseEvent.CLICK, _buttons[i].method);
				_buttons[i].button.removeEventListener(MouseEvent.MOUSE_OVER, mouseEntered);
			}
			
			ThexEventDispatcher.instance.removeEventListener(MenuEvent.NEXT_ITEM, nextItem);
			ThexEventDispatcher.instance.removeEventListener(MenuEvent.PREVIOUS_ITEM, previousItem);
			ThexEventDispatcher.instance.removeEventListener(MenuEvent.SELECT, select);
			
			_stage.removeChild(this);
		}
		
		private function nextItem(e:Event = null):void
		{
			activate(nextButton());
		}
		
		private function previousItem(e:Event = null):void
		{
			activate(previousButton());
		}
		
		private function select(e:Event = null):void
		{
			for each(var o:Object in _buttons)
			{
				if(o.button == _activeButton)
				{
					o.method();
				}
			}
		}
		
		private function mouseEntered(e:Event = null):void
		{
			activate(SimpleButton(e.currentTarget));
		}
		
		private function get numberOfButtons():uint
		{
			var buttonsCount:uint = 0;
			for(var id:String in _buttons) buttonsCount=parseInt(id)+1;
			
			return buttonsCount;
		}
		
		public function createButton(
			buttonPrototype:Object,
			 width:uint, 
			 height:uint, 
			 X:uint, 
			 Y:uint
		):SimpleButton
		{
			// let the magic happen
			var toto:Sprite = new ButtonLayer
			(
				X,
				Y,
				width,
				height,
				new TextFormat("buttons", height*0.8, 0x888888),
				buttonPrototype.title,
				false
			);
			var titi:Sprite = new ButtonLayer
			(
				X,
				Y,
				width,
				height,
				new TextFormat("buttons", height*0.8, 0x888888),
				buttonPrototype.title,
				true
			);
			
			var button:SimpleButton = new SimpleButton(toto, titi, toto, toto);
			this.addChild(button);
			
			button.addEventListener(MouseEvent.CLICK, buttonPrototype.method);
			button.addEventListener(MouseEvent.MOUSE_OVER, mouseEntered);
			
			return button;
		}
		
		private function toggleON(b:SimpleButton):void
		{
			b.downState = b.upState;
			b.upState = b.overState;
		}
		
		private function toggleOFF(b:SimpleButton):void
		{
			b.upState = b.downState;
			b.downState = b.overState;
		}
		
		private function activate(button:SimpleButton):void
		{
			if(button != _activeButton)
			{
				toggleOFF(_activeButton);
				toggleON(button);
				
				_activeButton = button;
			}
		}
		
		private function nextButton():SimpleButton
		{
			var returnValue:SimpleButton = null;
			
			for(var i:String in _buttons)
			{
				if(_buttons[i].button == _activeButton)
				{
					if(parseInt(i) < numberOfButtons-1)
					{
						returnValue = _buttons[parseInt(i)+1].button;
					}
					else
					{
						returnValue = _buttons[0].button;
					}
				}
			}
			
			if(returnValue == null)
			{
				returnValue = _buttons[0].button;
				trace("[WARNING]: Unexpected state for _activeButton: "+_activeButton);
			}
			return returnValue;
		}
		
		private function previousButton():SimpleButton
		{
			var returnValue:SimpleButton = null;
			
			for(var i:String in _buttons)
			{
				if(_buttons[i].button == _activeButton)
				{
					if(parseInt(i) > 0)
					{
						returnValue = _buttons[parseInt(i)-1].button;
					}
					else
					{
						returnValue = _buttons[numberOfButtons-1].button;
					}
				}
			}
			
			if(returnValue == null)
			{
				returnValue = _buttons[numberOfButtons-1].button;
				trace("[WARNING]: Unexpected state for _activeButton: "+_activeButton);
			}
			return returnValue;
		}
		
		private function campaign(e:Event = null):void
		{
			trace("campaign");
		}
		
		private function normal(e:Event = null):void
		{
			_stage.focus = stage;
			ThexEventDispatcher.instance.dispatchEvent(new NewGameEvent());
		}
		
		private function settings(e:Event = null):void
		{
			trace("settings");
		}
	}
}
