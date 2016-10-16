package
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent; 
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.text.*;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class BasicCollisionDetection extends Sprite
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
		
		//Embed the monster image
		[Embed(source="../images/monsterNormal.png")]
		public var MonsterNormalImage:Class;
		public var monsterNormalImage:DisplayObject = new MonsterNormalImage();
		public var monster:Sprite = new Sprite();
		
		//Create and initialize the vx and vy variable
		public var vx:int = 0;
		public var vy:int = 0;
		
		public function BasicCollisionDetection()
		{
			setupTextfields();
			createGameObjects();
			setupEventListeners();
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
			output.y = 65;
		}
		public function createGameObjects():void
		{
			//Add the monster to the stage
			monster.addChild(monsterNormalImage);
			stage.addChild(monster);
			monster.x = 125;
			monster.y = 150;
			
			//Add the character to the stage
			character.addChild(characterImage);
			stage.addChild(character);
			character.x = 300;
			character.y = 150;
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
			
			//Collision detection
			if (character.hitTestObject(monster))
			{
				output.text = "Hey!!!";
			}
			else {
				output.text = "No collision..."; 
			}
		} 
	}
}