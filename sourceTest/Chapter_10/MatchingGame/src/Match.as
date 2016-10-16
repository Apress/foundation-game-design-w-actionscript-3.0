package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.*;
	
	{
		public class Match extends Sprite
		{
			//Embed the card background image
			[Embed(source="../images/matchBackground.png")]
			private var MatchBackgroundImage:Class;
			
			//Private properties
			private var _matchBackgroundImage:DisplayObject 
			  = new MatchBackgroundImage();
			private var _format:TextFormat = new TextFormat();
			private var _output:TextField = new TextField();
			
			public function Match(matchName:String)
			{
				//Assign the matchName from the application
				//class to this class's name property
				this.name = matchName;
				
				//Add the background image
				this.addChild(_matchBackgroundImage);
				
				//Set the text format object
				_format.font = "Helvetica";
				_format.size = 16;
				_format.color = 0x000000;
				_format.align = TextFormatAlign.CENTER;
				
				//Configure the _output text field	
				_output.defaultTextFormat = _format;
				_output.width = _matchBackgroundImage.width;
				_output.border = false;
				_output.wordWrap = true;
				_output.autoSize = TextFieldAutoSize.CENTER;
				_output.text = this.name;
				
				//Display and position the _output text field
				this.addChild(_output);
				_output.x = 0;
				_output.y = 30;
			}
		}
	}
}