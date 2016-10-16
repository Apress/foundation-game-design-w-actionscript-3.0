package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]	
	
	public class TimeBombPanic extends Sprite
	{
		//Create the text objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		public var input:TextField = new TextField();
		public var gameResult:TextField = new TextField();
		
		//Create the game objects
		public var character:Character = new Character();
		public var background:Background = new Background();
		public var gameOver:GameOver = new GameOver();
		
		//The bombs:
		public var bomb1:Bomb = new Bomb();
		public var bomb2:Bomb = new Bomb();
		public var bomb3:Bomb = new Bomb();
		public var bomb4:Bomb = new Bomb();
		public var bomb5:Bomb = new Bomb();
		//The boxes:
		public var box1:Box = new Box();
		public var box2:Box = new Box();
		public var box3:Box = new Box();
		public var box4:Box = new Box();
		public var box5:Box = new Box();
		public var box6:Box = new Box();
		public var box7:Box = new Box();
		public var box8:Box = new Box();
		public var box9:Box = new Box();
		public var box10:Box = new Box();
		public var box11:Box = new Box();
		public var box12:Box = new Box();
		public var box13:Box = new Box();
		public var box14:Box = new Box();
		
		//Create the timer
		public var timer:Timer;
		
		//Create and initialize the vx and vy variables
		public var vx:int = 0;
		public var vy:int = 0;
		
		//The bombsDefused variable that counts
		//the number of bombs collected
		public var bombsDefused:uint = 0;
		
		public function TimeBombPanic()
		{
			createGameObjects();
			setupTextfields()
			setupEventListeners();
		}
		public function createGameObjects():void
		{
			//Add the background
			addGameObjectToStage(background, 0, 0);
			
			//Add the character
			addGameObjectToStage(character, 50, 50);
			
			//Add the boxes
			addGameObjectToStage(box1, 100, 100);
			addGameObjectToStage(box2, 150, 100);
			addGameObjectToStage(box3, 200, 100);
			addGameObjectToStage(box4, 150, 150);
			addGameObjectToStage(box5, 100, 250);
			addGameObjectToStage(box6, 200, 250);
			addGameObjectToStage(box7, 250, 250);
			addGameObjectToStage(box8, 250, 200);
			addGameObjectToStage(box9, 300, 100);
			addGameObjectToStage(box10, 300, 300);
			addGameObjectToStage(box11, 350, 250);
			addGameObjectToStage(box12, 400, 100);
			addGameObjectToStage(box13, 400, 200);
			addGameObjectToStage(box14, 400, 250);
			//The bombs
			addGameObjectToStage(bomb1, 105, 160);
			addGameObjectToStage(bomb2, 205, 310);
			addGameObjectToStage(bomb3, 305, 260);
			addGameObjectToStage(bomb4, 355, 310);
			addGameObjectToStage(bomb5, 455, 110);
			
			//Add the gameOver image and
			//make it invisible when the game starts
			addGameObjectToStage(gameOver, 125, 50);
			gameOver.visible = false;
			
			//Initialize the timer
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, updateTimeHandler);
			timer.start();
		}
		public function setupTextfields():void
		{
			//Set the text format object
			format.font = "Helvetica";
			format.size = 38;
			format.color = 0xFFFFFF;
			format.align = TextFormatAlign.CENTER;
			
			//Configure the output text field	
			output.defaultTextFormat = format;
			output.autoSize = TextFieldAutoSize.CENTER;
			output.border = false;
			output.text = "0";
			
			//Display and position the output text field
			stage.addChild(output);
			output.x = 265;
			output.y = 7;
			
			//Configure and display the gameResult Textfield
			format.color = 0x000000;
			format.size = 32;
			gameResult.defaultTextFormat = format;
			gameResult.autoSize = TextFieldAutoSize.CENTER; 
			gameResult.text = "";
			gameOver.addChild(gameResult);
			gameResult.x = 145;
			gameResult.y = 160;
		}
		public function setupEventListeners():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		public function updateTimeHandler(event:TimerEvent):void
		{
			output.text = String(timer.currentCount);
			
			//Stop the timer when it reaches 10 
			if(timer.currentCount == 10)
			{
				checkGameOver();
			}
		}
		public function enterFrameHandler(event:Event):void
		{
			//Move the player 
			character.x += vx; 
			character.y += vy; 
			
			//Stage boundaries
			if (character.x < 50)
			{
				character.x = 50;
			}
			else if (character.y < 50)
			{
				character.y = 50;
			}
			else if (character.x + character.width > stage.stageWidth - 50)
			{
				character.x = stage.stageWidth - character.width - 50;
			}
			else if (character.y + character.height > stage.stageHeight -50)
			{
				character.y = stage.stageHeight - character.height - 50;
			}
			
			//Box Collision code
			Collision.block(character, box1);
			Collision.block(character, box2);
			Collision.block(character, box3);
			Collision.block(character, box4);
			Collision.block(character, box5);
			Collision.block(character, box6);
			Collision.block(character, box7);
			Collision.block(character, box8);
			Collision.block(character, box9);
			Collision.block(character, box10);
			Collision.block(character, box11);
			Collision.block(character, box12);
			Collision.block(character, box13);
			Collision.block(character, box14);
			
			//Bomb collision code
			if(character.hitTestObject(bomb1) && bomb1.visible == true)
			{
				bomb1.visible = false;
				bombsDefused++;
			}
			if(character.hitTestObject(bomb2) && bomb2.visible == true)
			{
				bomb2.visible = false;
				bombsDefused++;
				checkGameOver();
			}
			if(character.hitTestObject(bomb3) && bomb3.visible == true)
			{
				bomb3.visible = false;
				bombsDefused++;
				checkGameOver();
			}
			if(character.hitTestObject(bomb4) && bomb4.visible == true)
			{
				bomb4.visible = false;
				bombsDefused++;
				checkGameOver();
			}
			if(character.hitTestObject(bomb5) && bomb5.visible == true)
			{
				bomb5.visible = false;
				bombsDefused++;
				checkGameOver();
			}
		}
		public function checkGameOver():void
		{
			if(bombsDefused == 5)
			{
				gameOver.visible = true;
				gameResult.text = "You Won!";
				character.alpha = 0.5;
				background.alpha = 0.5;
				timer.removeEventListener(TimerEvent.TIMER, updateTimeHandler);
				stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			else if(timer.currentCount == 10)
			{
				gameOver.visible = true;
				gameResult.text = "You Lost!";
				character.alpha = 0.5;
				background.alpha = 0.5;
				timer.removeEventListener(TimerEvent.TIMER, updateTimeHandler);
				stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		public function addGameObjectToStage
		  (gameObject:Sprite, xPos:int, yPos:int):void
		{
		  stage.addChild(gameObject);
		  gameObject.x = xPos;
		  gameObject.y = yPos;
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				vx = -5;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				vx = 5;
			}
			else if (event.keyCode == Keyboard.UP)
			{
				vy = -5;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				vy = 5;
			}
		}
		public function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT 
				|| event.keyCode == Keyboard.RIGHT)
			{
				vx = 0;
			} 
			else if (event.keyCode == Keyboard.DOWN 
				|| event.keyCode == Keyboard.UP)
			{
				vy = 0;
			} 
		}
	}
}