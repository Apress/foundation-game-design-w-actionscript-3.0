package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class Spaceship extends Sprite
	{
		//Private properties
		private var _rocket:Rocket = new Rocket();
		private var _bullets:Array = new Array();
		private var _angle:Number;
		
		public function Spaceship()
		{
			stage.addChild(_rocket);
			_rocket.x = 275;
			_rocket.y = 175
				
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);	
		}
		public function enterFrameHandler(event:Event):void
		{	
			//Calculate the angle of rotation
			_angle = _rocket.rotation  * (Math.PI / 180); 
			
			//Figure out the acceleration based on the angle
			_rocket.acceleration_X = Math.cos(_angle) * _rocket.speed; 
			_rocket.acceleration_Y = Math.sin(_angle) * _rocket.speed;
			
			//Add the acceleration to the velocity
			_rocket.vx += _rocket.acceleration_X; 
			_rocket.vy += _rocket.acceleration_Y;
			
			//Add friction
			_rocket.vx *= _rocket.friction;
			_rocket.vy *= _rocket.friction;
			
			
			//Force the rocket's velocity to zero
			//after it falls below 0.1
			if(Math.abs(_rocket.vx) < 0.1 
			&& Math.abs(_rocket.vy) < 0.1) 
			{
				_rocket.vx = 0;
				_rocket.vy = 0;
			}
			
			//Move and rotate the rocket
			_rocket.x += _rocket.vx;
			_rocket.y += _rocket.vy;
			_rocket.rotation += _rocket.rotationSpeed;
			
			//Move the bullets
			for(var i:int = 0; i < _bullets.length; i++)
			{
				var bullet:Bullet = _bullets[i];
				bullet.x += bullet.vx;
				bullet.y += bullet.vy;
				
				//check the bullet's stage boundaries
				if (bullet.y < 0
				|| bullet.x < 0
				|| bullet.x > stage.stageWidth
				|| bullet.y > stage.stageHeight)
				{
					//Remove the bullet from the stage
					stage.removeChild(bullet);
					bullet = null;
					
					//Remove the bullet from the _bullets
					//array
					_bullets.splice(i,1);
					
					//Reduce the loop counter 
					//by one to compensate
					//for the removed bullet
					i--;
				}
			}
			
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				_rocket.rotationSpeed = -10;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				_rocket.rotationSpeed = 10;
			}
			else if (event.keyCode == Keyboard.UP)
			{
				_rocket.speed = 0.2;
				_rocket.friction = 1;
			}
			else if (event.keyCode == Keyboard.SPACE)
			{
				//Create a bullet and add it to the stage
				var bullet:Bullet = new Bullet();
				stage.addChild(bullet);
				
				//Set the bullet's starting position
				var radius:int = 30;
				bullet.x = _rocket.x + (radius * Math.cos(_angle));
				bullet.y = _rocket.y + (radius * Math.sin(_angle));
				
				//Set the bullet's velocity based
				//on the angle 
				bullet.vx = Math.cos(_angle) * 7 + _rocket.vx;
				bullet.vy = Math.sin(_angle) * 7 + _rocket.vy;
				
				//Push the bullet into the _bullets array
				_bullets.push(bullet);
			}
		}
		public function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP) 
			{
				_rocket.speed = 0;
				_rocket.friction = 0.96;
			}
			if (event.keyCode == Keyboard.LEFT 
			|| event.keyCode == Keyboard.RIGHT)
			{
				_rocket.rotationSpeed = 0;
			}
		}
	}
}