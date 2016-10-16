package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class BugCatcher extends Sprite
	{	
		//Properties to manage the game states
		private const RUNNING:uint = 1; 
		private const OVER:uint = 2;
		private var _gameState:uint = RUNNING;
		
		//The game objects
		private var _character:Character = new Character();
		private var _background:Background = new Background();
		private var _grass:Grass = new Grass();
		private var _frog:Frog = new Frog();
		private var _spider:Spider = new Spider();
		
		//Arrays to store the boxes and their x and y positions
		private var _boxes:Array = new Array();
		private var _boxPositions:Array = new Array();
		
		//Arrays to store the bugs and their initial x and y positions
		private var _bugs:Array = new Array();
		private var _bugPositions:Array = new Array();
		
		//Create the _sounds object from the custom Sounds class
		private var _sounds:Sounds = new Sounds();
		
		//Game variables
		private var _bugsCollected:uint = 0;
		
		public function BugCatcher()
		{
			//Add the game objects
			GameUtilities.addObjectToGame(_background, this);
			GameUtilities.addObjectToGame(_grass, this, 0, 370);
			GameUtilities.addObjectToGame(_character, this, 150, 300);
			GameUtilities.addObjectToGame(_frog, this, 0, 300);
			GameUtilities.addObjectToGame(_spider, this, 313, 175);
			
			//THE BUGS
			//Set the initial bug x and y positions
			_bugPositions 
			= [
				[25, 50],
				[400, 50],
				[250, 150]
			]; 
			
			//Make the bugs
			for(var i:int = 0; i < _bugPositions.length; i++)
			{
				//Create a bug object
				var bug:Bug = new Bug();
				
				//Add the bug to the stage
				GameUtilities.addObjectToGame
					(bug, this, _bugPositions[i][0], _bugPositions[i][1]);
				
				//Add it to the _bugs array
				//for future use
				_bugs.push(bug);
			}	
			
			//THE BOXES
			//Set the box x and y positions
			_boxPositions 
			= [
				[0, 350],
				[0, 200],
				[100, 100],
				[100, 250],
				[150, 50],
				[150, 250],
				[200, 50],
				[300, 200],
				[250, 150],
				[350, 150],
				[400, 150],
				[400, 300],
				[450, 150],
				[450, 300],
				[500, 250]
			]; 
			
			//Make the boxes
			for(var j:int = 0; j < _boxPositions.length; j++)
			{
				//Create a box object
				var box:Box = new Box();
				
				//Add the box to the stage
				GameUtilities.addObjectToGame
				  (box, this, _boxPositions[j][0], _boxPositions[j][1]);
				
				//Add it to the _boxes array
				//for future use
				_boxes.push(box);
			}
			//Add the event listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			//View the number of objects on the stage
			//trace(numChildren);
			
			//Find the third object on the display list
			//trace(getChildAt(2));
			
			//Find out the instane name of 
			//the third object on the display list
			//trace(getChildAt(2).name);
			
			//Assign an optional instance name an
			//view it
			//_character.name = "thisIsTheCharactersName";
			//trace(getChildAt(2).name);
			
			//View the stacking order of objects on the stage
			/*
			for (var k:int = 0;  k < numChildren;  k++)
			{
				trace(k + ".  " + getChildAt(k));
			}
			*/
			
			//Move the grass to the top of the stack
			setChildIndex(_grass, numChildren - 1);
			
			//Swap the display list positions of the
			//character and grass objects
			//swapChildren(_character, _grass);
			
			//View the updated stacking order
			/*
			for (var l:int = 0;  l < numChildren;  l++)
			{
				trace(l + ".  " + getChildAt(l));
			}
			*/

		}
		public function enterFrameHandler(event:Event):void
		{
			switch(_gameState) 
			{
				case RUNNING:
					runGame();
					break;
				case OVER:
					gameOver();
					break; 
			}
		} 
		public function runGame():void
		{
			//Move the bugs
			for(var i:int = 0; i < _bugs.length; i++)
			{
				//Create a temporary local variable
				//to easily access the current bug in the loop
				var bug:Bug = _bugs[i];
				
				if(bug.visible)
				{
					moveBug(bug);
				}
			}
			moveCharacter();
			
			//Make the frog's eyes follow the character
			makeFrogLook();
			
			//Check collisions between the character and the bugs
			for(var i:int = 0; i < _bugs.length; i++)
			{
				//Create a temporary local variable
				//to easily access the current bug in the loop
				var bug = _bugs[i];
				
				if(_character.hitTestObject(bug)
					&& bug.visible)
				{
					bug.visible = false;
					_sounds.chirpChannel = _sounds.chirp.play();
					_bugsCollected++;
					if(_bugsCollected == 3)
					{
						_gameState = OVER;
					}
				}
			}
			//Check collisions between the character and the spider
			if(_character.hitTestObject(_spider))
			{
				_sounds.meowChannel = _sounds.meow.play();
				_gameState = OVER;
			}

		}
		public function gameOver():void
		{
			//Create a String variable to store the 
			//game over message
		 	var message:String = "";
			
			//Figure out if the player won or lost
			if(_bugsCollected == 3)
			{
				message = "You collected the bugs!";
			}
			else
			{
				message = "You stepped on a spider!";
			}
			
			//Display the game over message in a MessageDisplay window
			var gameOverMessage = new MessageDisplay(message, 1000);
			stage.addChild(gameOverMessage);
			gameOverMessage.x = 180;
			gameOverMessage.y = 130;
			
			//Dim the character and remove the enterFrameHander
			_character.alpha = 0.5;
			stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function makeFrogLook():void
		{
			//Convert points from local to global coordinates
			//Right eye
			var frogsRightEye:Point 
			  = new Point(_frog.rightEye.x, _frog.rightEye.y);
			var frogsRightEye_X:Number 
			  = _frog.localToGlobal(frogsRightEye).x;
			var frogsRightEye_Y:Number 
			  = _frog.localToGlobal(frogsRightEye).y;
			//Left eye
			var frogsLeftEye:Point 
			  = new Point(_frog.leftEye.x, _frog.leftEye.y);
			var frogsLeftEye_X:Number 
			  = _frog.localToGlobal(frogsLeftEye).x;
			var frogsLeftEye_Y:Number 
			  = _frog.localToGlobal(frogsLeftEye).y;
			  
			//Rotate eyes
			_frog.rightEye.rotation 
				= Math.atan2
				(
					frogsRightEye_Y 
					- _character.y, 
					frogsRightEye_X 
					- _character.x
				) 
				* (180/Math.PI); 
			  
			  _frog.leftEye.rotation 
				= Math.atan2
				(
				  frogsLeftEye_Y 
				  - _character.y, 
			      frogsLeftEye_X 
				   - _character.x
				) 
				* (180/Math.PI);
		}
		private function moveCharacter():void
		{
			//Apply accelertion
			_character.vx += _character.accelerationX; 
			
			//Apply friction
			_character.vx *= _character.friction; 
			
			//Apply gravity
			_character.vy += _character.gravity;
			
			//Limit the speed, except when the character
			//is moving upwards
			if (_character.vx > _character.speedLimit)
			{
				_character.vx = _character.speedLimit;
			}
			if (_character.vx < -_character.speedLimit)
			{
				_character.vx = -_character.speedLimit;
			}
			if (_character.vy > _character.speedLimit * 2)
			{
				_character.vy = _character.speedLimit * 2;
			} 
			
			//Force the velocity to zero
			//after it falls below 0.1
			if (Math.abs(_character.vx) < 0.1)
			{
				_character.vx = 0;
			}
			if (Math.abs(_character.vy) < 0.1)
			{
				_character.vy = 0;
			}
			
			//Move the character 
			_character.x += _character.vx;
			_character.y += _character.vy;
			
			//Check stage boundaries
			if (_character.x < 0)
			{
				_character.vx = 0;
				_character.x = 0;
			}
			if (_character.y < 0)
			{
				_character.vy = 0;
				_character.y = 0;
			}
			if (_character.x + _character.width > stage.stageWidth)
			{
				_character.vx = 0;
				_character.x = stage.stageWidth - _character.width;
			}
			if (_character.y + _character.height > stage.stageHeight)
			{
				_character.vy = 0;
				_character.y = stage.stageHeight - _character.height;
				_character.isOnGround = true;
			}
			
			for(var i:int = 0; i < _boxes.length; i++)
			{
				Collision.block(_character, _boxes[i]);
				
				if(Collision.collisionSide == "Bottom")
				{
					//Tell the character that it's on the
					//ground if it's standing on top of
					//a platform
					_character.isOnGround = true;
					
					//Neutralize gravity by applying its
					//exact opposite force to the character's vy
					_character.vy = -_character.gravity;
				}
				else if(Collision.collisionSide == "Top")
				{
					_character.vy = 0;
				}
				else if(Collision.collisionSide == "Right"
				|| Collision.collisionSide == "Left")
				{
					_character.vx = 0;
				}
			}
		}

		private function moveBug(bug:Bug):void
		{
			//Add Brownian motion to the velocities 
			bug.vx += (Math.random() * 0.2 - 0.1) * 40;
			bug.vy += (Math.random() * 0.2 - 0.1) * 40;
				
			//Add some friction 
			bug.vx *= 0.96; 
			bug.vy *= 0.96;
			
			//Move the bug 
			bug.x += bug.vx; 
			bug.y += bug.vy;
				
			//Stage Boundaries
			if (bug.x > stage.stageWidth - bug.width)
			{
				bug.x = stage.stageWidth - bug.width;
					
				//Reverse (bounce) bug's velocity when it hits the stage edges
				bug.vx *= -1; 
			}
			if (bug.x < 0)
			{
				bug.x = 0;
				bug.vx *= -1; 
			}
			//Keep the bug above the grass
			if (bug.y > stage.stageHeight - 35)
			{
				bug.y = stage.stageHeight - 35;
				bug.vy *= -1;
			}
			if (bug.y < 0)
			{
				bug.y = 0;
				bug.vy *= -1;
			}
				
			//Apply collision detection with the platforms
			for(var j:int = 0; j < _boxes.length; j++)
			{
				Collision.block(bug, _boxes[j]);
			}
				
			//ARTIFICIAL INTELLIGENCE
			//Make the bugs avoid the frog
			if ((Math.abs(bug.x - _frog.x) < 100))
			{
				if (Math.abs(bug.y - _frog.y) < 100)
				{
					bug.vx *= - 1; 
					bug.vy *= - 1;
					trace(bug.name + ": Frog!");
				}
			}
			
			//Calculate the distance vector
			//between the center of the 
			//bug and the character
			var vx:Number 
			  = (bug.x + (bug.width / 2)) 
			  - (_character.x + (_character.width / 2));
			
			var vy:Number 
			  = (bug.y + (bug.height / 2)) 
			  - (_character.y + (_character.height / 2));
			
			
			if (Math.abs(vx) < 100 || Math.abs(vy) < 100)
			{
				//If the player is moving...
				bug.vy += _character.vy + ((Math.random() * 0.2 - 0.1) * 70); 
				bug.vx += _character.vx + ((Math.random() * 0.2 - 0.1) * 70); 
				trace(bug.name + ": Cat!");
						
				//If the player is sitting still... 
				if ((Math.abs(_character.vy) < 1) && (Math.abs(_character.vx) < 1))
				{
					bug.y += -bug.vy; 
					bug.x += -bug.vx; 
					bug.vy *= -1; 
					bug.vx *= -1; 
						
				}
			}
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				_character.accelerationX = -0.2;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				_character.accelerationX = 0.2;
			}
			else if (event.keyCode == Keyboard.UP
				|| event.keyCode == Keyboard.SPACE)
			{
				if(_character.isOnGround)
				{
					_sounds.bounceChannel = _sounds.bounce.play();
					_character.vy += _character.jumpForce;
					_character.gravity = 0.3;
					_character.isOnGround = false;
				}
			}
		}
		public function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT 
				|| event.keyCode == Keyboard.RIGHT)
			{
				_character.accelerationX = 0; 
			} 
		}
	}
}