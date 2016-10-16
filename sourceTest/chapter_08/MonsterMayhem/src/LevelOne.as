package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;

	public class LevelOne extends Sprite
	{
		//Declare the variables to hold
		//the game objects
		private var _character:Character;
		private var _background:Background;
		private var _gameOver:GameOver;		
		private var _monster1:Monster;
		private var _monster2:Monster;
		private var _star:Star;
		private var _levelWinner:String;
		
		//The timers
		private var _monsterTimer:Timer;
		private var _gameOverTimer:Timer;
		
		//A variable to store the reference
		//to the stage from the application class
		private var _stage:Object;
		
		public function LevelOne(stage:Object)
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
			_background = new Background();
			_monster1 = new Monster();
			_monster2 = new Monster();
			_gameOver = new GameOver();
			
			//Add the game objects to the stage
			addGameObjectToLevel(_background, 0, 0);
			addGameObjectToLevel(_monster1, 400, 150);
			addGameObjectToLevel(_monster2, 150, 150);
			addGameObjectToLevel(_character, 250, 300);
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
		}
		private function enterFrameHandler(event:Event):void
		{	
			//Move the game character and 
			//check its stage boundaries
			_character.x += _character.vx; 
			_character.y += _character.vy;
			checkStageBoundaries(_character);
			
			
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
			
			//If the star has been launched,
			//move it, check its stage
			//boundaries and collisions
			//with the monsters
			if(_star.launched)
			{
				//If it has been launched, 
				//make it visible
				_star.visible = true;
				
				//Move it
				_star.y -= 3;
				_star.rotation += 5;
				
				//Check its stage boundaries
				checkStarStageBoundaries(_star);
				
				//Check for collisions with the monsters
				starVsMonsterCollision(_star, _monster1);
				starVsMonsterCollision(_star, _monster2);
			}
			else
			{
				_star.visible = false;
			}
			
			//Collision detection between the 
			//character and  monsters
			characterVsMonsterCollision(_character, _monster1);
			characterVsMonsterCollision(_character, _monster2);
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
			&& _monster2.timesHit == 3)
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
			if (gameObject.x < 50)
			{
				gameObject.x = 50;
			}
			if (gameObject.y < 50)
			{
				gameObject.y = 50;
			}
			if (gameObject.x + gameObject.width > _stage.stageWidth - 50)
			{
				gameObject.x = _stage.stageWidth - gameObject.width - 50;
			}
			if (gameObject.y + gameObject.height > _stage.stageHeight - 50)
			{
				gameObject.y = _stage.stageHeight - gameObject.height - 50;
			}
		}
		private function checkStarStageBoundaries(star:Star):void
		{
			if (star.y < 50)
			{
				star.launched = false;
			}
		}
		private function monsterTimerHandler(event:TimerEvent):void
		{
			changeMonsterDirection(_monster1);
			changeMonsterDirection(_monster2);
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
					dispatchEvent(new Event("levelOneComplete", true));
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