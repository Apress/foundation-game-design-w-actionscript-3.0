package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]	
	
	public class TimeBombScroll extends Sprite
	{
		//Create the text objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		public var input:TextField = new TextField();
		public var gameResult:TextField = new TextField();
		
		//Create the game objects
		public var character:Character = new Character();
		public var background:BigBackground = new BigBackground();
		public var gameOver:GameOver = new GameOver();
		public var timeDisplay:TimeDisplay = new TimeDisplay();
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
		
		//Variables for the inner boundary
		public var rightInnerBoundary:uint;
		public var leftInnerBoundary:uint;
		public var topInnerBoundary:uint;
		public var bottomInnerBoundary:uint;
		
		public function TimeBombScroll()
		{
			createGameObjects();
			setupTextfields()
			setupEventListeners();
		}
		public function createGameObjects():void
		{
			//Add the background
			addGameObjectToStage(background, -275, -200);
			
			//Add the character
			addGameObjectToStage(character, 250, 175);
			
			//Add the time display
			addGameObjectToStage(timeDisplay, 200, 5);
			
			//Add the boxes
			addGameObjectToStage(box1, background.x + 100, background.y + 100);
			addGameObjectToStage(box2, background.x + 200, background.y + 300);
			addGameObjectToStage(box3, background.x + 400, background.y + 450);
			addGameObjectToStage(box4, background.x + 100, background.y + 600);
			addGameObjectToStage(box5, background.x + 300, background.y + 700);
			addGameObjectToStage(box6, background.x + 500, background.y + 200);
			addGameObjectToStage(box7, background.x + 600, background.y + 600);
			addGameObjectToStage(box8, background.x + 500, background.y + 500);
			addGameObjectToStage(box9, background.x + 700, background.y + 200);
			addGameObjectToStage(box10, background.x + 700, background.y + 400);
			addGameObjectToStage(box11, background.x + 800, background.y + 500);
			addGameObjectToStage(box12, background.x + 100, background.y + 700);
			addGameObjectToStage(box13, background.x + 900, background.y + 300);
			addGameObjectToStage(box14, background.x + 800, background.y + 200);
			//The bombs
			addGameObjectToStage(bomb1, background.x + 55, background.y + 710);
			addGameObjectToStage(bomb2, background.x + 255, background.y + 310);
			addGameObjectToStage(bomb3, background.x + 355, background.y + 160);
			addGameObjectToStage(bomb4, background.x + 855, background.y + 510);
			addGameObjectToStage(bomb5, background.x + 755, background.y + 610);
			
			//Add the time display
			addGameObjectToStage(timeDisplay, 225, 4);
			
			//Add the gameOver image and
			//make it invisible when the game starts
			addGameObjectToStage(gameOver, 120, 50);
			gameOver.visible = false;
			
			//Initialize the timer
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, updateTimeHandler);
			timer.start();
			
			//Define the inner boundary variables
			rightInnerBoundary = (stage.stageWidth / 2) + (stage.stageWidth / 4);
			leftInnerBoundary = (stage.stageWidth / 2) - (stage.stageWidth / 4); 
			topInnerBoundary = (stage.stageHeight / 2) - (stage.stageHeight / 4); 
			bottomInnerBoundary = (stage.stageHeight / 2) + (stage.stageHeight / 4);
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
			if(timer.currentCount == 20)
			{
				checkGameOver();
			}
		}
		public function enterFrameHandler(event:Event):void
		{
			//Move the player 
			character.x += vx; 
			character.y += vy; 
			
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
				checkGameOver();
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
			
			//Calculate the scroll velocity
			var temporaryX:int = background.x;
			var temporaryY:int = background.y;
			
			//Check the inner boundaries
			if (character.x < leftInnerBoundary)
			{
				character.x = leftInnerBoundary;
				rightInnerBoundary 
				  = (stage.stageWidth / 2) + (stage.stageWidth / 4);
				background.x -= vx; 
			}
			else if (character.x + character.width > rightInnerBoundary)
			{
				character.x = rightInnerBoundary - character.width
				leftInnerBoundary 
				  = (stage.stageWidth / 2) - (stage.stageWidth / 4);
				
				background.x -= vx;
			}
			if (character.y < topInnerBoundary)
			{
				character.y = topInnerBoundary;
				bottomInnerBoundary 
				  = (stage.stageHeight / 2) + (stage.stageHeight / 4);
				background.y -= vy;
			}
			else if (character.y + character.height > bottomInnerBoundary)
			{
				character.y = bottomInnerBoundary - character.height;
				topInnerBoundary 
				  = (stage.stageHeight / 2) - (stage.stageHeight / 4);
				background.y -= vy;
			}
			
			//Background stage boundaries
			if (background.x > 0)
			{
				background.x = 0;
				leftInnerBoundary = 0;
			}
			else if (background.y > 0)
			{
				background.y = 0;
				topInnerBoundary = 0;
			}
			else if (background.x < stage.stageWidth - background.width)
			{
				background.x = stage.stageWidth - background.width;
				rightInnerBoundary = stage.stageWidth;
			}
			else if (background.y < stage.stageHeight - background.height)
			{
				background.y = stage.stageHeight - background.height;
				bottomInnerBoundary = stage.stageHeight; 
			}
			
			//Character stage boundaries
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
			
			//Calculate the scroll velocity
			var scroll_Vx:int = background.x - temporaryX; 
			var scroll_Vy:int = background.y - temporaryY;
			
			//Use the scroll velocity to move the game objects
			//box1.x += scroll_Vx;
			//box1.y += scroll_Vy;
			scroll(box1, scroll_Vx, scroll_Vy);
			scroll(box2, scroll_Vx, scroll_Vy);
			scroll(box3, scroll_Vx, scroll_Vy);
			scroll(box4, scroll_Vx, scroll_Vy);
			scroll(box5, scroll_Vx, scroll_Vy);
			scroll(box6, scroll_Vx, scroll_Vy);
			scroll(box7, scroll_Vx, scroll_Vy);
			scroll(box8, scroll_Vx, scroll_Vy);
			scroll(box9, scroll_Vx, scroll_Vy);
			scroll(box10, scroll_Vx, scroll_Vy);
			scroll(box11, scroll_Vx, scroll_Vy);
			scroll(box12, scroll_Vx, scroll_Vy);
			scroll(box13, scroll_Vx, scroll_Vy);
			scroll(box14, scroll_Vx, scroll_Vy);
			scroll(bomb1, scroll_Vx, scroll_Vy);
			scroll(bomb2, scroll_Vx, scroll_Vy);
			scroll(bomb3, scroll_Vx, scroll_Vy);
			scroll(bomb4, scroll_Vx, scroll_Vy);
			scroll(bomb5, scroll_Vx, scroll_Vy);
			
		}
		public function scroll(gameObject:Sprite, scroll_Vx:int, scroll_Vy:int):void
		{
			gameObject.x += scroll_Vx;
			gameObject.y += scroll_Vy;
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
			else if(timer.currentCount == 20)
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