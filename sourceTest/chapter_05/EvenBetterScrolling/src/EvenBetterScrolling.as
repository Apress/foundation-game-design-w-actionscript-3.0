package
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent; 
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class EvenBetterScrolling extends Sprite
	{
		//Embed the background image
		[Embed(source="../images/background.png")]
		public var BackgroundImage:Class;
		public var backgroundImage:DisplayObject = new BackgroundImage();
		public var background:Sprite = new Sprite();
		
		//Embed the character image
		[Embed(source="../images/character.png")]
		public var CharacterImage:Class;
		public var characterImage:DisplayObject = new CharacterImage();
		public var character:Sprite = new Sprite();
		
		//Create and initialize the vx and vy variables
		public var vx:int = 0;
		public var vy:int = 0;
		
		//Variables for the inner boundary
		public var rightInnerBoundary:uint;
		public var leftInnerBoundary:uint;
		public var topInnerBoundary:uint;
		public var bottomInnerBoundary:uint;
		
		
		public function EvenBetterScrolling()
		{
			//Add the background
			background.addChild(backgroundImage);
			stage.addChild(background);
			background.x = -1325;
			background.y = -961;
			
			//Add the character
			character.addChild(characterImage);
			stage.addChild(character);
			character.x = 225;
			character.y = 150;
			
			//Define the inner boundary variables
			rightInnerBoundary = (stage.stageWidth / 2) + (stage.stageWidth / 4);
			leftInnerBoundary = (stage.stageWidth / 2) - (stage.stageWidth / 4); 
			topInnerBoundary = (stage.stageHeight / 2) - (stage.stageHeight / 4); 
			bottomInnerBoundary = (stage.stageHeight / 2) + (stage.stageHeight / 4);
			
			
			//Add the event listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
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
		public function enterFrameHandler(event:Event):void
		{	
			//Move the player 
			character.x += vx 
			character.y += vy;
			
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
			
			//Check the stage boundaries
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
		} 
	}
}