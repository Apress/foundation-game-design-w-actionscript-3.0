package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class Acceleration extends Sprite
	{
		private var _character:Character = new Character();;
		
		public function Acceleration()
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
				_character.vx = 0;
			} 
			else if (event.keyCode == Keyboard.DOWN 
			|| event.keyCode == Keyboard.UP)
			{
				_character.accelerationY = 0; 
				_character.vy = 0;
			} 
		}
		public function enterFrameHandler(event:Event):void
		{
			//Apply acceleration 
			_character.vx += _character.accelerationX; 
			_character.vy += _character.accelerationY;
			
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
			
			//Move the character 
			_character.x += _character.vx;
			_character.y += _character.vy;
			
			//Check stage boundaries
			if (_character.x < 0)
			{
				_character.x = 0;
			}
			if (_character.y < 0)
			{
				_character.y = 0;
			}
			if (_character.x + _character.width > stage.stageWidth)
			{
				_character.x = stage.stageWidth - _character.width;
			}
			if (_character.y + _character.height > stage.stageHeight)
			{
				_character.y = stage.stageHeight - _character.height;
			}
			
			//Trace the result
			trace("_character.vx:  " + _character.vx);
			trace("_character.x:  " + _character.x);
			trace("----------");

		} 
	}
}