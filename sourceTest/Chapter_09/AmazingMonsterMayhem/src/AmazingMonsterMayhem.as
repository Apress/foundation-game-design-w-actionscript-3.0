package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class AmazingMonsterMayhem extends Sprite
	{
		//Declare the variables to hold
		//the game objects
		private var _character:Character;
		private var _background:Background;
		private var _monster1:Monster;
		private var _monster2:Monster;
				
		//Arrays to store the boxes and their x and y positions
		private var _boxes:Array = new Array();
		private var _boxPositions:Array = new Array();
		
		//Arrays to store the monsters and their x and y positions
		private var _monsters:Array = new Array();
		private var _monsterPositions:Array = new Array();
		
		//A variable to count the frames
		private var _frameCounter:uint = 0;
		
		//A constant to represent the size of one of
		//the boxes that makes up the maze walls
		private const BOX_SIZE:uint = 50;
		
		public function AmazingMonsterMayhem()
		{
			//Create the game objects
			_character = new Character();
			_background = new Background();
			
			//Add the game objects to the stage
			addGameObjectToStage(_background, 0, 0);
			addGameObjectToStage(_character, 250, 300);
						
			//Event listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			//The Monsters
			//Set the monster x and y positions
			_monsterPositions 
				= [
					[50, 300],
					[450, 50]
				  ];
			
			//Make the monsters
			for(var i:int = 0; i < _monsterPositions.length; i++)
			{
				//Create a monster object
				var monster:Monster = new Monster();
				
				//Add the monster to the stage
				addChild(monster);
				monster.x = _monsterPositions[i][0];
				monster.y = _monsterPositions[i][1];
				
				//Add it to the monsters array
				//for future use
				_monsters.push(monster);
			}
			
			//The Boxes
			//Set the box x and y positions
			_boxPositions 
				= [
					[100, 100],
					[100, 150],
					[150, 200],
					[250, 50],
					[250, 150],
					[250, 250],
					[300, 150],
					[350, 300],
					[400, 100],
					[400, 200]
				]; 
			
			//Make the boxes
			for(var j:int = 0; j < _boxPositions.length; j++)
			{
				//Create a box object
				var box:Box = new Box();
				
				//Add the box to the stage
				addChild(box);
				box.x = _boxPositions[j][0];
				box.y = _boxPositions[j][1];
				
				//Add it to the boxes array
				//for future use
				_boxes.push(box);
			}
		}
				
		private function enterFrameHandler(event:Event):void
		{	
			//Move the game character and 
			//check its stage boundaries
			_character.x += _character.vx; 
			_character.y += _character.vy;
			checkStageBoundaries(_character);
			
			//Collision bettween the character and boxes
			for(var i:int = 0; i < _boxes.length; i++)
			{
				Collision.block(_character, _boxes[i]);
			}
			
			//The monsters
			//Update the frame counter
			_frameCounter++;
			
			for(var j:int = 0; j < _monsters.length; j++)
			{
				//Create a temporary local variable
				//to easily access the current monster in the loop
				var monster:Monster = _monsters[j];
				
				//Make the monsters change direction
				//every 50 frames
				if(_frameCounter == BOX_SIZE)
				{
				  changeMonsterDirection(monster);
				}
				
				//Move the monster
				monster.x += monster.vx;
				monster.y += monster.vy;
				
				//Check its stage boundaries
				checkStageBoundaries(monster);
				
				//Check for collisions with the boxes
				for(var k:int = 0; k < _boxes.length; k++)
				{
					Collision.block(monster, _boxes[k]);
				}
			}
			
			//Reset the frame counter if it equals
			//the size of a box that makes up
			//the maze walls (50)
			if(_frameCounter == BOX_SIZE)
			{
				_frameCounter = 0;
			}
		}
		private function checkStageBoundaries(gameObject:Sprite):void
		{
			if (gameObject.x < 50)
			{
				gameObject.x = 50;
			}
			if (gameObject.y < 50)
			{
				gameObject.y = 50;
			}
			if (gameObject.x + gameObject.width > stage.stageWidth - 50)
			{
				gameObject.x = stage.stageWidth - gameObject.width - 50;
			}
			if (gameObject.y + gameObject.height > stage.stageHeight - 50)
			{
				gameObject.y = stage.stageHeight - gameObject.height - 50;
			}
		}
		
		private function changeMonsterDirection(monster:Monster):void
		{
			var randomNumber:int = Math.ceil(Math.random() * 4);
			if(randomNumber == 1)
			{
				//Right
				monster.vx = 1;
				monster.vy = 0;
			}
			else if (randomNumber == 2)
			{
				//Left
				monster.vx = -1;
				monster.vy = 0;
			}
			else if(randomNumber == 3)
			{
				//Up
				monster.vx = 0;
				monster.vy = -1;
			}
			else
			{
				//Down
				monster.vx = 0;
				monster.vy = 1;
			}
		}
		private function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				_character.vx = -5;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				_character.vx = 5;
			}
			else if (event.keyCode == Keyboard.UP)
			{
				_character.vy = -5;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				_character.vy = 5;
			}
		}
		private function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT 
				|| event.keyCode == Keyboard.RIGHT)
			{
				_character.vx = 0;
			} 
			else if (event.keyCode == Keyboard.DOWN 
				|| event.keyCode == Keyboard.UP)
			{
				_character.vy = 0;
			}
		}
		private function addGameObjectToStage
			(gameObject:Sprite, xPos:int, yPos:int):void
		{
			this.addChild(gameObject);
			gameObject.x = xPos;
			gameObject.y = yPos;
		}
	}
}