package
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent; 
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class ParalaxScrolling extends Sprite
	{
		//Embed the distant background image
		[Embed(source="../images/distantBackground.png")]
		public var DistantBackgroundImage:Class;
		public var distantBackgroundImage:DisplayObject = new DistantBackgroundImage();
		public var distantBackground:Sprite = new Sprite();
		
		//Embed the distant foreground image
		[Embed(source="../images/foreground.png")]
		public var ForegroundImage:Class;
		public var foregroundImage:DisplayObject = new ForegroundImage();
		public var foreground:Sprite = new Sprite();
		
		//Embed the character image
		[Embed(source="../images/character.png")]
		public var CharacterImage:Class;
		public var characterImage:DisplayObject = new CharacterImage();
		public var character:Sprite = new Sprite();
		
		//Create and initialize the vx variable
		public var vx:int = 0;
		
		//Variables for the inner boundary
		public var rightInnerBoundary:uint;
		public var leftInnerBoundary:uint;
		
		public function ParalaxScrolling()
		{
			//Add the distant background
			distantBackground.addChild(distantBackgroundImage);
			stage.addChild(distantBackground);
			distantBackground.x = -1155;
			distantBackground.y = 0;
			
			//Add the foreground
			foreground.addChild(foregroundImage);
			stage.addChild(foreground);
			foreground.x = -1155;
			foreground.y = 0;
			
			//Add the character
			character.addChild(characterImage);
			stage.addChild(character);
			character.x = 225;
			character.y = 290;
			
			//Define the inner boundary variables
			rightInnerBoundary = (stage.stageWidth / 2) + (stage.stageWidth / 4);
			leftInnerBoundary = (stage.stageWidth / 2) - (stage.stageWidth / 4); 
			
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
		}
		public function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT 
				|| event.keyCode == Keyboard.RIGHT)
			{
				vx = 0;
			} 
		}
		public function enterFrameHandler(event:Event):void
		{	
			//Move the player 
			character.x += vx 
			
			//Check the inner boundaries
			if (character.x < leftInnerBoundary)
			{
				character.x = leftInnerBoundary;
				rightInnerBoundary 
				  = (stage.stageWidth / 2) + (stage.stageWidth / 4);
				distantBackground.x -= vx / 2; 
				foreground.x -= vx;
			}
			else if (character.x + character.width > rightInnerBoundary)
			{
				character.x = rightInnerBoundary - character.width
				leftInnerBoundary 
				  = (stage.stageWidth / 2) - (stage.stageWidth / 4);
				distantBackground.x -= vx / 2; 
				foreground.x -= vx;
			}
			
			//Check the stage boundaries
			if (foreground.x > 0)
			{
				foreground.x = 0;
				distantBackground.x = -distantBackground.width / 4;
				leftInnerBoundary = 0;
			}
			else if (foreground.x < stage.stageWidth - foreground.width)
			{
				foreground.x = stage.stageWidth - foreground.width;
				distantBackground.x 
					= (-distantBackground.width / 4) * 3 
					+ (stage.stageWidth / 2);
				rightInnerBoundary = stage.stageWidth;
			}
		} 
	}
}