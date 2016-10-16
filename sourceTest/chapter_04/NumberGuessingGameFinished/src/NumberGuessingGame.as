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
		
		//Game variables
		public var startMessage:String;
		public var mysteryNumber:uint;
		public var currentGuess:uint;
		public var guessesRemaining:int;
		public var guessesMade:uint;
		public var gameStatus:String;
		public var gameWon:Boolean;
		
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
			//Initialize variables
			startMessage = "I am thinking of a number between 0 and 99";
			mysteryNumber = Math.floor(Math.random() * 100);
			
			//Initialize text fields 
			output.text = startMessage 
			input.text = "";
			guessesRemaining = 10;
			guessesMade = 0;
			gameStatus = "";
			gameWon = false;
			
			//Trace the mystery number
			trace("The mystery number: " + mysteryNumber);
			
			//Add an event listener for key presses
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressHandler);
		}
		public function playGame():void
		{
			guessesRemaining--;
			guessesMade++;
			
			gameStatus = "Guess: " + guessesMade + ", Remaining: " + guessesRemaining;
			currentGuess = uint(input.text);
			
			if (currentGuess > mysteryNumber)
			{
				output.text = "That's too high." + "\n" + gameStatus;
				checkGameOver();
			} 
			else if (currentGuess < mysteryNumber)
			{
				output.text = "That's too low." + "\n" + gameStatus;
				checkGameOver();
			}
			else 
			{
				output.text = "You got it!";
				gameWon = true;
				endGame();
			}
		}
		public function checkGameOver():void
		{
			if (guessesRemaining < 1)
			{
				endGame();
			}
		}
		public function endGame():void
		{
			if (gameWon)
			{
				output.text 
					= "Yes, it's " + mysteryNumber + "!" + "\n" 
					+ "It only took you " + guessesMade + " guesses.";
			}
			else 
			{
				output.text 
					= "No more guesses left!" + "\n" 
					+ "The number was: " + mysteryNumber + ".";
			}
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressHandler);
			input.type = "dynamic";
			input.alpha = 0.5;
		}
		public function keyPressHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ENTER)
			{
				playGame();
			}
		}
	}
}