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
	
	public class PickingUpObjects extends Sprite
	{	
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
		
		//Embed the star image
		[Embed(source="../images/star.png")]
		public var StarImage:Class;
		public var starImage:DisplayObject = new StarImage();
		public var star:Sprite = new Sprite();
		
		//Create and initialize the vx and vy variable
		public var vx:int = 0;
		public var vy:int = 0;
		
		//A variable for checking whether the cat has the star
		public var characterHasStar:Boolean = false;
		
		public function PickingUpObjects()
		{
			createGameObjects();
			setupEventListeners();
		}
		public function createGameObjects():void
		{
			//Add the monster to the stage
			monster.addChild(monsterNormalImage);
			stage.addChild(monster);
			monster.x = 50;
			monster.y = 50;
			
			//Add the character to the stage
			character.addChild(characterImage);
			stage.addChild(character);
			character.x = 220;
			character.y = 150;
			
			//Add the star
			star.addChild(starImage);
			stage.addChild(star);
			star.x = 425;
			star.y = 275;
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
			
			if (event.keyCode == Keyboard.SPACE 
			&& character.hitTestObject(star))
			{
				if (!characterHasStar)
				{
					character.addChild(star);
					star.x = 0;
					star.y = 0;
					characterHasStar = true;
				}
				else 
				{
					stage.addChild(star);
					star.x = character.x;
					star.y = character.y;
					characterHasStar = false;
					if (monster.hitTestObject(star))
					{
						trace("Thanks!!");
					}
				}
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
			/*
			if (character.hitTestObject(monster))
			{
				if(meterInsideImage.width > 0)
				{	
					meterInsideImage.width--;
				}
			}
			if(meterInsideImage.width < 1)
			{
				trace("Game over");
			}
			*/
		} 
	}
}