package
{
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent; 
	import flash.ui.Keyboard;
	import flash.text.*;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class NumberGuessingGame extends Sprite
	{
		//Create the text objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		public var input:TextField = new TextField();
		
		public function NumberGuessingGame()
		{
			setupTextfields();
			startGame();
		}
		public function setupTextfields():void
		{
			//Set the text format object
			format.font = "Helvetica";
			format.size = 32;
			format.color = 0xFF0000;
			format.align = TextFormatAlign.LEFT;
			
			//Configure the output text field	
			output.defaultTextFormat = format;
			output.width = 400;
			output.height = 70;
			output.border = true;
			output.wordWrap = true;
			output.text = "This is the output text field";
			
			//Display and position the output text field
			stage.addChild(output);
			output.x = 70;
			output.y = 65;
			
			//Configure the input text field
			format.size = 60;
			input.defaultTextFormat = format;
			input.width = 80;
			input.height = 60;
			input.border = true;
			input.type = "input";
			input.maxChars = 2;
			input.restrict = "0-9";
			input.background = true;
			input.backgroundColor = 0xCCCCCC;
			input.text = "";
			
			//Display and position the input text field
			stage.addChild(input);
			input.x = 70;
			input.y = 150;
			stage.focus = input;
		}
		public function startGame():void
		{
			trace("Game started")
		}
	}
}