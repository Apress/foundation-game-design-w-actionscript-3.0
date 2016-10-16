package
{
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class ScrollingLevel extends Sprite
	{
		//Declare the variables to hold
		//the game objects
		private var _character:Character;
		private var _background:BigBackground;
		private var _gameOver:GameOver;		
		private var _monster1:Monster;
		private var _monster2:Monster;
		private var _monster3:Monster;
		private var _monster4:Monster;
		private var _star:Star;
		private var _levelWinner:String;
		private var _stage:Object;
		private var _starDirection:String;
		
		//The timers
		private var _monsterTimer:Timer;
		private var _gameOverTimer:Timer;
		
		//Variables needed for scrolling
		private var _temporaryX:int;
		private var _temporaryY:int;
		private var _scroll_Vx:int; 
		private var _scroll_Vy:int;
		private var _rightInnerBoundary:uint;
		private var _leftInnerBoundary:uint;
		private var _topInnerBoundary:uint;
		private var _bottomInnerBoundary:uint;
		private var _currentExplosion:Sprite = null;
		
		public function ScrollingLevel(stage:Object)
		{
			_stage = stage;	
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		private function addedToStageHandler(event:Event):void
		{
			startGame();
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		private function startGame():void
		{
			//Create the game objects
			_character = new Character();
			_star = new Star();
			_background = new BigBackground();
			_monster1 = new Monster();
			_monster2 = new Monster();
			_monster3 = new Monster();
			_monster4 = new Monster();
			_gameOver = new GameOver();
			
			//Add the game objects to the stage
			addGameObjectToLevel(_background, -275, -200);
			addGameObjectToLevel(_monster1, 400, 125);
			addGameObjectToLevel(_monster2, 150, 125);
			addGameObjectToLevel(_monster3, 400, 250);
			addGameObjectToLevel(_monster4, 150, 250);
			addGameObjectToLevel(_character, 250, 175);
			addGameObjectToLevel(_star, 250, 300);
			_star.visible = false;
			addGameObjectToLevel(_gameOver, 140, 130);
			
			//Initialize the monster timer
			_monsterTimer = new Timer(1000);
			_monsterTimer.addEventListener(TimerEvent.TIMER, monsterTimerHandler);
			_monsterTimer.start();
			
			//Event listeners
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			//Define the inner boundary variables
			_rightInnerBoundary = (_stage.stageWidth / 2) + (_stage.stageWidth / 4);
			_leftInnerBoundary = (_stage.stageWidth / 2) - (_stage.stageWidth / 4); 
			_topInnerBoundary = (_stage.stageHeight / 2) - (_stage.stageHeight / 4); 
			_bottomInnerBoundary = (_stage.stageHeight / 2) + (_stage.stageHeight / 4);
		}
		private function enterFrameHandler(event:Event):void
		{	
			//Move the game character and 
			//check its stage boundaries
			_character.x += _character.vx; 
			_character.y += _character.vy;
			//checkStageBoundaries(_character);
			
			//Move the monsters and 
			//check their stage boundaries
			if(_monster1.visible)
			{
				_monster1.x += _monster1.vx;
				_monster1.y += _monster1.vy;
				checkStageBoundaries(_monster1);
			}
			if(_monster2.visible)
			{
				_monster2.x += _monster2.vx; 
				_monster2.y += _monster2.vy;
				checkStageBoundaries(_monster2);
			}
			if(_monster3.visible)
			{
				_monster3.x += _monster3.vx;
				_monster3.y += _monster3.vy;
				checkStageBoundaries(_monster3);
			}
			if(_monster4.visible)
			{
				_monster4.x += _monster4.vx; 
				_monster4.y += _monster4.vy;
				checkStageBoundaries(_monster4);
			}
			
			
			//Has the star been launched?
			if(_star.launched)
			{
				//If it has, make it visible
				_star.visible = true;
				
				//Set the star's velcocity based on the
				//_starDirection variable set in the
				//keyDownHandler
				if(_starDirection == "up")
				{
					_star.vy = -3;
					_star.vx = 0;
				}
				else if(_starDirection == "down")
				{
					_star.vy = 3;
					_star.vx = 0;
				}
				else if(_starDirection == "left")
				{
					_star.vy = 0;
					_star.vx = -3;
				}
				else if(_starDirection == "right")
				{
					_star.vy = 0;
					_star.vx = 3;
				}
				
				//Move and rotate the star
				_star.x += _star.vx;
				_star.y += _star.vy;
				_star.rotation += 5;
				
				//Check its stage boundaries
				checkStarStageBoundaries(_star);
				
				//Check for collisions with the monsters
				starVsMonsterCollision(_star, _monster1);
				starVsMonsterCollision(_star, _monster2);
				starVsMonsterCollision(_star, _monster3);
				starVsMonsterCollision(_star, _monster4);
			}
			else
			{
				_star.visible = false;
			}
			
			//Collision detection between the 
			//character and  monsters
			//Uncomment this code to re-enable the collisions
			/*
			characterVsMonsterCollision(_character, _monster1);
			characterVsMonsterCollision(_character, _monster2);
			characterVsMonsterCollision(_character, _monster3);
			characterVsMonsterCollision(_character, _monster4);
			*/
			
			//Scroll background
			//Calculate the scroll velocity
			_temporaryX = _background.x;
			_temporaryY = _background.y;
			
			//Check the inner boundaries
			if (_character.x < _leftInnerBoundary)
			{
				_character.x = _leftInnerBoundary;
				_rightInnerBoundary 
				= (_stage.stageWidth / 2) + (_stage.stageWidth / 4);
				_background.x -= _character.vx; 
			}
			else if (_character.x + _character.width > _rightInnerBoundary)
			{
				_character.x = _rightInnerBoundary - _character.width
				_leftInnerBoundary 
				  = (_stage.stageWidth / 2) - (_stage.stageWidth / 4);
				_background.x -= _character.vx;
			}
			if (_character.y < _topInnerBoundary)
			{
				_character.y = _topInnerBoundary;
				_bottomInnerBoundary 
				  = (_stage.stageHeight / 2) + (_stage.stageHeight / 4);
				_background.y -= _character.vy;
			}
			else if (_character.y + _character.height > _bottomInnerBoundary)
			{
				_character.y = _bottomInnerBoundary - _character.height;
				_topInnerBoundary 
				  = (_stage.stageHeight / 2) - (_stage.stageHeight / 4);
				_background.y -= _character.vy;
			}
			
			//Background stage boundaries
			if (_background.x > 0)
			{
				_background.x = 0;
				_leftInnerBoundary = 0;
			}
			else if (_background.y > 0)
			{
				_background.y = 0;
				_topInnerBoundary = 0;
			}
			else if (_background.x < _stage.stageWidth - _background.width)
			{
				_background.x = _stage.stageWidth - _background.width;
				_rightInnerBoundary = _stage.stageWidth;
			}
			else if (_background.y < _stage.stageHeight - _background.height)
			{
				_background.y = _stage.stageHeight - _background.height;
				_bottomInnerBoundary = _stage.stageHeight; 
			}
			
			//Character stage boundaries
			if (_character.x < 50)
			{
				_character.x = 50;
			}
			else if (_character.y < 50)
			{
				_character.y = 50;
			}
			else if (_character.x + _character.width > _stage.stageWidth - 50)
			{
				_character.x = _stage.stageWidth - _character.width - 50;
			}
			else if (_character.y + _character.height > _stage.stageHeight -50)
			{
				_character.y = _stage.stageHeight - _character.height - 50;
			}
			
			//Calculate the scroll velocity
			_scroll_Vx = _background.x - _temporaryX; 
			_scroll_Vy = _background.y - _temporaryY;
			
			//Scroll the moving objects
			
			//Scroll the monsters
			scroll(_monster1);
			scroll(_monster2);
			scroll(_monster3);
			scroll(_monster4);
			
			//Scroll the star
			if(_star.launched)
			{
			  scroll(_star);
			}
			
			//Scroll the current explosion
			if(_currentExplosion != null)
			{
			  scroll(_currentExplosion);
			}
			
		}
		public function scroll(gameObject:Sprite):void
		{
			gameObject.x += _scroll_Vx;
			gameObject.y += _scroll_Vy;
		}
		private function characterVsMonsterCollision
			(character:Character, monster:Monster):void
		{
			if(character.hitTestObject(monster)
				&& monster.visible)
			{
				character.timesHit++;
				checkGameOver();
			}
		}
		private function starVsMonsterCollision
			(star:Star, monster:Monster):void
		{
			if(star.hitTestObject(monster) 
				&& monster.visible)
			{
				//Call the monster's "openMouth"
				//method to make it open its mouth
				monster.openMouth();
				
				//Deactivate the star
				star.launched = false;
				
				//Add 1 to the monster's
				//timesHit variable
				monster.timesHit++;
				
				//Has the monster been hit
				//3 times?
				if(monster.timesHit == 3)
				{
					//call the "killMonster"
					//method
					killMonster(monster);
					
					//Check to see if the
					//game is over
					checkGameOver();
				}
			}
		}
		private function killMonster(monster:Monster):void
		{
			//Make the monster invisible
			monster.visible = false;
			
			//Create a new explosion object
			//and add it to the stage
			var explosion:Explosion = new Explosion();
			this.addChild(explosion);
			_currentExplosion = explosion;
			
			//Center the explosion over
			//the monster
			explosion.x = monster.x -21;
			explosion.y = monster.y -18;
			
			//Call the exlposion's
			//"explode" method
			explosion.explode();
		}
		private function checkGameOver():void
		{
			if(_monster1.timesHit == 3
			&& _monster2.timesHit == 3
			&& _monster3.timesHit == 3
			&& _monster4.timesHit == 3)
			{
				_levelWinner = "character"
				_gameOverTimer = new Timer(2000);
				_gameOverTimer.addEventListener(TimerEvent.TIMER, gameOverTimerHandler);
				_gameOverTimer.start();
				_monsterTimer.removeEventListener(TimerEvent.TIMER, monsterTimerHandler);
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			if(_character.timesHit == 1)
			{
				_levelWinner = "monsters"
				_character.alpha = 0.5;
				_gameOverTimer = new Timer(2000);
				_gameOverTimer.addEventListener(TimerEvent.TIMER, gameOverTimerHandler);
				_gameOverTimer.start();
				_monsterTimer.removeEventListener(TimerEvent.TIMER, monsterTimerHandler);
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		private function checkStageBoundaries(gameObject:Sprite):void
		{
			if (gameObject.x < _background.x + 50)
			{
				gameObject.x = _background.x + 50;
			}
			if (gameObject.y < _background.y + 50)
			{
				gameObject.y = _background.y + 50;
			}
			if (gameObject.x + gameObject.width > _background.x + _background.width - 50)
			{
				gameObject.x = _background.x + _background.width - gameObject.width - 50;
			}
			if (gameObject.y + gameObject.height > _background.y + _background.height - 50)
			{
				gameObject.y = _background.y + _background.height - gameObject.height - 50;
			}
		}
		private function checkStarStageBoundaries(star:Star):void
		{
			if (star.y < 0
			|| star.x < 0
			|| star.x > _stage.stageWidth
			|| star.y > _stage.stageHeight)
			{
				_star.launched = false;
			}
		}
		private function monsterTimerHandler(event:TimerEvent):void
		{
			changeMonsterDirection(_monster1);
			changeMonsterDirection(_monster2);
			changeMonsterDirection(_monster3);
			changeMonsterDirection(_monster4);
		}
		private function changeMonsterDirection(monster:Monster):void
		{
			var randomNumber:int = Math.ceil(Math.random() * 4);
			if(randomNumber == 1)
			{
				//Right
				monster.vx = 2;
				monster.vy = 0;
			}
			else if (randomNumber == 2)
			{
				//Left
				monster.vx = -2;
				monster.vy = 0;
			}
			else if(randomNumber == 3)
			{
				//Up
				monster.vx = 0;
				monster.vy = -2;
			}
			else
			{
				//Down
				monster.vx = 0;
				monster.vy = 2;
			}
		}
		private function gameOverTimerHandler(event:TimerEvent):void
		{
			if(_levelWinner == "character")
			{
				if(_gameOverTimer.currentCount == 1)
				{
					_gameOver.levelComplete.visible = true;
				}
				if(_gameOverTimer.currentCount == 2)
				{
					_gameOverTimer.reset();
					_gameOverTimer.removeEventListener(TimerEvent.TIMER, gameOverTimerHandler);
					//dispatchEvent(new Event("levelOneComplete", true));
				}
			}
			if(_levelWinner == "monsters")
			{
				_gameOver.youLost.visible = true;
				_gameOverTimer.removeEventListener(TimerEvent.TIMER, gameOverTimerHandler);
			}
		}
		private function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				_character.vx = -5;
				if(!_star.launched)
				{
					_starDirection = "left";
				}
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				_character.vx = 5;
				if(!_star.launched)
				{
					_starDirection = "right";
				}
			}
			else if (event.keyCode == Keyboard.UP)
			{
				_character.vy = -5;
				if(!_star.launched)
				{
					_starDirection = "up";
				}
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				_character.vy = 5;
				if(!_star.launched)
				{
					_starDirection = "down";
				}
			}
			if(event.keyCode == Keyboard.SPACE)
			{
				if(!_star.launched)
				{
					_star.x = _character.x + _star.width / 2;
					_star.y = _character.y + _star.width / 2;
					_star.launched = true;
				}
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
		private function addGameObjectToLevel
			(gameObject:Sprite, xPos:int, yPos:int):void
		{
			this.addChild(gameObject);
			gameObject.x = xPos;
			gameObject.y = yPos;
		}
	}
}