package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	//Classes needed to play sounds
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class JumpingWithSound extends Sprite
	{
		//Embed the sound
		[Embed(source="../sounds/bounce.mp3")] 
		private var Bounce:Class;
		
		//Create the Sound and Sound channel 
		//objects for the sound
		private var _bounce:Sound = new Bounce(); 
		private var _bounceChannel:SoundChannel = new SoundChannel();
		
		private var _character:Character = new Character();;
		
		public function JumpingWithSound()
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
			else if (event.keyCode == Keyboard.UP
			|| event.keyCode == Keyboard.SPACE)
			{
				if(_character.isOnGround)
				{
					_bounceChannel = _bounce.play();
					_character.vy += _character.jumpForce;
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
		public function enterFrameHandler(event:Event):void
		{
			//Apply acceleration 
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
		} 
	}
}