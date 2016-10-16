package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class DrivingSystem extends Sprite
	{
		//Private properties
		private var _car:Car = new Car();
		private var _angle:Number;
		
		public function DrivingSystem()
		{
			stage.addChild(_car);
			_car.x = 275;
			_car.y = 175
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);	
		}
		public function enterFrameHandler(event:Event):void
		{	
			//Increase the car's speed if the up key is being pressed
			if(_car.accelerate)
			{
				_car.speed += 0.1;
				
				//Add some optional drag
				_car.speed *= _car.friction; 
			}
			else
			{
				//Add friction to the speed if the car is 
				//not accelerating
				_car.speed *= _car.friction; 
			}
			//Calculate the acceleration based on the angle of rotation
			_angle = _car.rotation  * (Math.PI / 180); 
			_car.acceleration_X = _car.speed * Math.cos(_angle); 
			_car.acceleration_Y = _car.speed * Math.sin(_angle);
			
			//Update the car's velocity
			_car.vx = _car.acceleration_X; 
			_car.vy = _car.acceleration_Y;
			
			//Force the cars's velocity to zero
			//it falls below 0.1
			if(Math.abs(_car.vx) < 0.1 
				&& Math.abs(_car.vy) < 0.1) 
			{
				_car.vx = 0;
				_car.vy = 0;
			}
			
			//Move and rotate the car
			_car.x += _car.vx;
			_car.y += _car.vy;
			_car.rotation += _car.rotationSpeed;
			
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
			switch (event.keyCode) 
			{
				case Keyboard.LEFT: 
					_car.rotationSpeed = -3; 
					break;
				
				case Keyboard.RIGHT: 
					_car.rotationSpeed = 3; 
					break;
				
				case Keyboard.UP:
					_car.accelerate = true;
			}
		}
		public function keyUpHandler(event:KeyboardEvent):void
		{
			switch (event.keyCode) 
			{
				case Keyboard.LEFT: 
					_car.rotationSpeed = 0; 
					break;
				
				case Keyboard.RIGHT: 
					_car.rotationSpeed = 0; 
					break;
				
				case Keyboard.UP: 
					_car.accelerate = false;
			}
		}
	}
}