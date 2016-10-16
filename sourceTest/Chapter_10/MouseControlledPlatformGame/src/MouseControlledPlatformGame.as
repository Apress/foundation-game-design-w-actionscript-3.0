package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class MouseControlledPlatformGame extends Sprite
	{	
		private var _character:Character = new Character();
		private var _boxes:Array = new Array();
		private var _boxPositions:Array = new Array();
		
		public function MouseControlledPlatformGame()
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
			_character.y = 300;
			
			//Hide the mouse
			Mouse.hide();
			
			//Add the event listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		public function enterFrameHandler(event:Event):void
		{
			
			_character.vx = (stage.mouseX - (_character.x + _character.width / 2)) * 0.2;
			
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
					_character.isOnGround = true;
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
		private function mouseDownHandler(event:MouseEvent):void
		{
			if(_character.isOnGround)
			{
				_character.vy += _character.jumpForce;
				_character.gravity = 0.3;
				_character.isOnGround = false;
			}
		}
	}
}