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
		
		//Create the button objects
		public var buttonUpURL:URLRequest = new URLRequest("../images/buttonUp.png");
		public var buttonOverURL:URLRequest = new URLRequest("../images/buttonOver.png");
		public var buttonDownURL:URLRequest = new URLRequest("../images/buttonDown.png");
		public var buttonUpImage:Loader = new Loader();
		public var buttonOverImage:Loader = new Loader();
		public var buttonDownImage:Loader = new Loader();
		public var button:Sprite = new Sprite();
		
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
			makeButton();
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
		public function makeButton():void
		{
			//Load the images
			buttonUpImage.load(buttonUpURL);
			buttonDownImage.load(buttonDownURL);
			buttonOverImage.load(buttonOverURL);
			
			//Make the images invisible, except
			//for the up image
			buttonUpImage.visible = true;
			buttonDownImage.visible = false;
			buttonOverImage.visible = false;
			
			//Add the images to the button Sprite
			button.addChild(buttonUpImage);
			button.addChild(buttonDownImage);
			button.addChild(buttonOverImage);
			
			//Set the Sprite's button properties
			button.buttonMode = true;
			button.mouseEnabled = true;
			button.useHandCursor = true;
			button.mouseChildren = false;
			
			//Add the button Sprite to the stage
			stage.addChild(button);
			button.x = 175;
			button.y = 155;
			
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
			
			//Add the button event listeners
			button.addEventListener(MouseEvent.ROLL_OVER, overHandler);
			button.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			button.addEventListener(MouseEvent.ROLL_OUT, resetHandler);
			button.addEventListener(MouseEvent.CLICK, clickHandler);
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
			
			button.removeEventListener(MouseEvent.ROLL_OVER, overHandler);
			button.removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			button.removeEventListener(MouseEvent.ROLL_OUT, resetHandler);
			button.removeEventListener(MouseEvent.CLICK, clickHandler);
			button.alpha = 0.5;
			button.mouseEnabled = false;
			
			
		}
		public function keyPressHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ENTER)
			{
				playGame();
			}
		}
		public function overHandler(event:MouseEvent):void
		{
			buttonUpImage.visible = false;
			buttonDownImage.visible = false;
			buttonOverImage.visible = true;
		}
		public function downHandler(event:MouseEvent):void
		{
			buttonUpImage.visible = false;
			buttonDownImage.visible = true;
			buttonOverImage.visible = false;
		}
		public function clickHandler(event:MouseEvent):void
		{
			buttonUpImage.visible = true;
			buttonDownImage.visible = false;
			buttonOverImage.visible = false;
			playGame();
		}
		public function resetHandler(event:MouseEvent):void
		{
			buttonUpImage.visible = true;
			buttonDownImage.visible = false;
			buttonOverImage.visible = false;
		}
	}
}