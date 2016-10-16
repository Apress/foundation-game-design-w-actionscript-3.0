package 
{
	import flash.display.Sprite;
	import flash.text.*;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class UsingATimer extends Sprite
	{
		//The Timer object
		public var timer:Timer;
		
		//The Text objects
		public var output:TextField = new TextField();
		public var format:TextFormat = new TextFormat();
		
		public function UsingATimer()
		{
			//Initialize the timer
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, updateTimeHandler);
			timer.start();
			
			//Set the text format object
			format.font = "Helvetica";
			format.size = 200;
			format.color = 0x000000;
			format.align = TextFormatAlign.CENTER;
			
			//Configure the output text field	
			output.defaultTextFormat = format;
			output.autoSize = TextFieldAutoSize.CENTER;
			output.border = true;
			output.text = "0";
			
			//Display and position the output text field
			stage.addChild(output);
			output.x = 200;
			output.y = 100;
		}
		public function updateTimeHandler(event:TimerEvent):void
		{
			output.text = String(timer.currentCount);
			
			//Reset and restart the timer when it reaches 10 
			if(timer.currentCount == 10)
			{
				timer.reset(); 
				timer.start();
			}
		}
	}
}
