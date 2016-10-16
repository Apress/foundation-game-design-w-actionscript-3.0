package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.*;
	
	public class MessageDisplay extends Sprite
	{
		//Embed the background image
		[Embed(source="../images/displayBackground.png")]
		private var DisplayBackgroundImage:Class;
		
		//Private properties
		private var _displayBackgroundImage:DisplayObject = new DisplayBackgroundImage();
		private var _displayBackground:Sprite = new Sprite();
		private var _timer:Timer;
		private var _format:TextFormat = new TextFormat();
		private var _output:TextField = new TextField();
		private var _message:String = "";
		
		public function MessageDisplay(message:String, time:int = 0)
		{
			_message = message;
			
			_displayBackground.addChild(_displayBackgroundImage);
			this.addChild(_displayBackground);
			this.visible = false;
			
			//Set the text format object
			_format.font = "Helvetica";
			_format.size = 24;
			_format.color = 0x000000;
			_format.align = TextFormatAlign.LEFT;
			
			//Configure the _output text field	
			_output.defaultTextFormat = _format;
			_output.width = 150;
			_output.height = 70;
			_output.border = false;
			_output.wordWrap = true;
			_output.text = "";
			
			//Display and position the _output text field
			this.addChild(_output);
			_output.x = 30;
			_output.y = 25;
			
			//The timer
			_timer = new Timer(time);
			_timer.addEventListener(TimerEvent.TIMER, displayMessageHandler);
			_timer.start();
		}
		
		//Private methods
		private function displayMessageHandler(event:TimerEvent):void
		{
			_output.text = _message;
			this.visible = true;
			_timer.removeEventListener(TimerEvent.TIMER, displayMessageHandler);
		}
	}
}