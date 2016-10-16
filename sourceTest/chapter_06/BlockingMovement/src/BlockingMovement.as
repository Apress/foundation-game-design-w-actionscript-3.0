package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.*;
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class BlockingMovement extends Sprite
	{	
		//Create the text objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		public var input:TextField = new TextField();
		
		//Embed the character image
		[Embed(source="../images/character.png")]
		public var CharacterImage:Class;
		public var characterImage:DisplayObject = new CharacterImage();
		public var character:Sprite = new Sprite();
		
		//Embed the box image
		[Embed(source="../images/box.png")]
		public var BoxImage:Class;
		public var boxImage:DisplayObject = new BoxImage();
		public var box:Sprite = new Sprite();
		
		//Create and initialize the vx and vy variable
		public var vx:int = 0;
		public var vy:int = 0;
		
		public function BlockingMovement()
		{
			createGameObjects();
			setupTextfields()
			setupEventListeners();
		}
		public function createGameObjects():void
		{	
			//Add the box
			box.addChild(boxImage);
			stage.addChild(box);
			box.x = 300;
			box.y = 125;
			
			//Add the character to the stage
			character.addChild(characterImage);
			stage.addChild(character);
			character.x = 75;
			character.y = 150;
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
			output.width = 300;
			output.height = 36;
			output.border = true;
			output.text = "";
			
			//Display and position the output text field
			stage.addChild(output);
			output.x = 125;
			output.y = 350;
		}
		public function setupEventListeners():void
		{
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
			character.x += vx; 
			character.y += vy; 
			
			//Collision code
			Collision.block(character, box);
			
			//Display the collision side in the output text field
			output.text = Collision.collisionSide;
		}
	}
}