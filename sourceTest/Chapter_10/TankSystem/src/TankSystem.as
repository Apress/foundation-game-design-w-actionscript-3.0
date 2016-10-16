package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class TankSystem extends Sprite
	{
		//Private properties
		private var _tank:Tank = new Tank();
		private var _tankAngle:Number;
		private var _turretAngle:Number;
		private var _bullets:Array = new Array();
		
		public function TankSystem()
		{
			stage.addChild(_tank);
			_tank.x = 275;
			_tank.y = 175
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		public function enterFrameHandler(event:Event):void
		{	
			//THE TANK
			//Increase the tank's speed if the up key is being pressed
			if(_tank.accelerate)
			{
				_tank.speed += 0.1;
				
				//Add some optional drag
				_tank.speed *= _tank.friction; 
			}
			else
			{
				//Add friction to the speed if the tank is 
				//not accelerating
				_tank.speed *= _tank.friction; 
			}
			//Calculate the acceleration based on the angle of rotation
			_tankAngle = _tank.rotation  * (Math.PI / 180); 
			_tank.acceleration_X = _tank.speed * Math.cos(_tankAngle); 
			_tank.acceleration_Y = _tank.speed * Math.sin(_tankAngle);
			
			//Update the tank's velocity
			_tank.vx = _tank.acceleration_X; 
			_tank.vy = _tank.acceleration_Y;
			
			//Force the tanks's velocity to zero
			//it falls below 0.1
			if(Math.abs(_tank.vx) < 0.1 
				&& Math.abs(_tank.vy) < 0.1) 
			{
				_tank.vx = 0;
				_tank.vy = 0;
			}
			
			//Move and rotate the tank
			_tank.x += _tank.vx;
			_tank.y += _tank.vy;
			_tank.rotation += _tank.rotationSpeed;
			
			//THE TURRET
			//Convert turrets points from local to global coordinates
			var turretPoint:Point 
				= new Point(_tank.turret.x, _tank.turret.y);
			var turretPoint_X:Number 
				= _tank.localToGlobal(turretPoint).x;
			var turretPoint_Y:Number 
				= _tank.localToGlobal(turretPoint).y;
			
			//Find the turret's angle based on the
			//position of the mouse
			_turretAngle 
				= Math.atan2
				(
					turretPoint_Y - stage.mouseY, 
					turretPoint_X - stage.mouseX
				) 
				* (180/Math.PI); 
			
			//Compensate for the rotation of the tank
			_turretAngle -= _tank.rotation;
			
			//Rotate the turret towards the mouse
			_tank.turret.rotation = _turretAngle;
			
			//MOVE THE BULLETS
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
		private function fireBullet():void
		{
			//Create a bullet and add it to the stage
			var bullet:Bullet = new Bullet();
			stage.addChild(bullet);
			
			//Set the bullet's starting position
			//1. Set the radius
			var radius:int = -30;
			
			//2. Add the tank and turrets rotation values together
			//and convert the result to radians
			var angle:Number = (_tank.rotation + _tank.turret.rotation)  / (180/Math.PI);
			
			//3. Position the bullet
			bullet.x = _tank.x + (radius * Math.cos(angle));
			bullet.y = _tank.y + (radius * Math.sin(angle));
			
			//Set the bullet's velocity based
			//on the angle 
			bullet.vx = Math.cos(angle) * -7 + _tank.vx;
			bullet.vy = Math.sin(angle) * -7 + _tank.vy;
			
			
			//Push the bullet into the _bullets array
			_bullets.push(bullet);;
		}
		private function mouseDownHandler(event:MouseEvent):void
		{
			fireBullet();
		}
		private function keyDownHandler(event:KeyboardEvent):void
		{	
			switch (event.keyCode) 
			{
				case Keyboard.LEFT: 
					_tank.rotationSpeed = -3; 
					break;
				
				case Keyboard.RIGHT: 
					_tank.rotationSpeed = 3; 
					break;
				
				case Keyboard.UP:
					_tank.accelerate = true;
					break;
					
				case Keyboard.SPACE:
					fireBullet();
			}
		}
		private function keyUpHandler(event:KeyboardEvent):void
		{
			switch (event.keyCode) 
			{
				case Keyboard.LEFT: 
					_tank.rotationSpeed = 0; 
					break;
				
				case Keyboard.RIGHT: 
					_tank.rotationSpeed = 0; 
					break;
				
				case Keyboard.UP: 
					_tank.accelerate = false;
			}
		}
	}
}