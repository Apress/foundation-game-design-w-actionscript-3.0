package
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent; 
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class StateChange extends Sprite
	{	
		//Embed the character image
		[Embed(source="../images/character.png")]
		public var CharacterImage:Class;
		public var characterImage:DisplayObject = new CharacterImage();
		public var character:Sprite = new Sprite();
		
		//Embed the monster images
		[Embed(source="../images/monsterNormal.png")]
		public var MonsterNormalImage:Class;
		public var monsterNormalImage:DisplayObject = new MonsterNormalImage();
		[Embed(source="../images/monsterScared.png")]
		public var MonsterScaredImage:Class;
		public var monsterScaredImage:DisplayObject = new MonsterScaredImage();
		public var monster:Sprite = new Sprite();
		
		//Create and initialize the vx and vy variable
		public var vx:int = 0;
		public var vy:int = 0;
		
		public function StateChange()
		{
			createGameObjects();
			setupEventListeners();
		}
		public function createGameObjects():void
		{
			//Compose the monster and add it to the stage
			monster.addChild(monsterNormalImage);
			monster.addChild(monsterScaredImage);
			monsterScaredImage.visible = false;
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
				monsterScaredImage.visible = true;
				monsterNormalImage.visible = false;
			}
			else 
			{
				monsterScaredImage.visible = false;
				monsterNormalImage.visible = true; 
			}
		} 
	}
}