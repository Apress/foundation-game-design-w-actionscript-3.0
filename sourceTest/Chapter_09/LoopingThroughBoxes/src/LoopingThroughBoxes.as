package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class LoopingThroughBoxes extends Sprite
	{
		//Embed the sound
		[Embed(source="../sounds/bounce.mp3")] 
		private var Bounce:Class;
		
		//Create the Sound and Sound channel 
		//objects for the sound
		private var _bounce:Sound = new Bounce(); 
		private var _bounceChannel:SoundChannel = new SoundChannel();
		
		private var _character:Character = new Character();
		private var _boxes:Array = new Array();
		private var _boxPositions:Array = new Array();
		
		public function LoopingThroughBoxes()
		{
			//Set the box x and y positions
			_boxPositions 
			= [
				[0, 200],
				[100, 100],
				[100, 250],
				[150, 50],
				[150, 250],
				[200, 50],
				[300, 200],
				[350, 150],
				[400, 150],
				[400, 300],
				[450, 150],
				[450, 300],
				[500, 250]
			]; 
			
			//Make the boxes
			for(var i:int = 0; i < _boxPositions.length; i++)
			{
				//Create a box object
				var box:Box = new Box();
				
				//Add the box to the stage
				addChild(box);
				box.x = _boxPositions[i][0];
				box.y = _boxPositions[i][1];
				
				//Add it to the boxes array
				//for future use
				_boxes.push(box);
			}
			
			//Add the character
			addChild(_character);
			_character.x = 150;
			_character.y = 300
			
			//Add the event listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
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
					
					//For a bouncy platform, replace the above
					//line of code with this one
					//_character.vy = -_character.vy / 2;
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