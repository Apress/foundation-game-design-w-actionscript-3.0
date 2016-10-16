package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class Bounce extends Sprite
	{
		private var _character:Character = new Character();;
		
		public function Bounce()
		{
			//Add the character to the stage
			stage.addChild(_character);
			_character.x = 250;
			_character.y = 175;
			
			//Add the event listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
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
			else if (event.keyCode == Keyboard.UP)
			{
				_character.accelerationY = -0.2;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				_character.accelerationY = 0.2;
			}
		}
		public function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT 
				|| event.keyCode == Keyboard.RIGHT)
			{
				_character.accelerationX = 0; 
			} 
			else if (event.keyCode == Keyboard.DOWN 
				|| event.keyCode == Keyboard.UP)
			{
				_character.accelerationY = 0; 
			} 
		}
		public function enterFrameHandler(event:Event):void
		{
			//Apply acceleration 
			_character.vx += _character.accelerationX; 
			_character.vy += _character.accelerationY;
			
			//Apply friction
			_character.vx *= _character.friction; 
			_character.vy *= _character.friction;
			
			
			//Limit the speed
			if (_character.vx > _character.speedLimit)
			{
				_character.vx = _character.speedLimit;
			}
			if (_character.vx < -_character.speedLimit)
			{
				_character.vx = -_character.speedLimit;
			}
			if (_character.vy > _character.speedLimit)
			{
				_character.vy = _character.speedLimit;
			} 
			if (_character.vy < -_character.speedLimit)
			{
				_character.vy = -_character.speedLimit;
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
				_character.vx *= _character.bounce;
				_character.x = 0;
			}
			else if (_character.y < 0)
			{
				_character.vy *= _character.bounce;
				_character.y = 0;
			}
			else if (_character.x + _character.width > stage.stageWidth)
			{
				_character.vx *= _character.bounce;
				_character.x = stage.stageWidth - _character.width;
			}
			else if (_character.y + _character.height > stage.stageHeight)
			{
				_character.vy *= _character.bounce;
				_character.y = stage.stageHeight - _character.height;
			}
		} 
	}
}