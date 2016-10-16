package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class RotateAndShoot extends Sprite
	{
		//Embed the images
		[Embed(source="../images/bee.png")]
		private var BeeImage:Class;
		[Embed(source="../images/bullet.png")]
		private var BulletImage:Class;
		
		//Properties
		private const SPEED:Number = 3;
		private const TURN_SPEED:Number = 0.3;
		private const RANGE:Number = 200;
		private const FRICTION:Number = 0.96;
		private var _beeImage:DisplayObject = new BeeImage();
		private var _bee:GameObject = new GameObject(_beeImage);
		
		//The bee's angle of rotation
		private var _beeAngle:Number;
		
		//A timer to fire bullets
		private var _bulletTimer:Timer;
		
		//An array to store the bullets
		private var _bullets:Array = new Array();
		
		public function RotateAndShoot()
		{
			//Add the bee to the stage
			stage.addChild(_bee);
			_bee.x = 275;
			_bee.y = 175;
			
			//Initialize the timer
			_bulletTimer = new Timer(1000);
			_bulletTimer.addEventListener(TimerEvent.TIMER, bulletTimerHandler);
			
			//Add the event listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function bulletTimerHandler(event:TimerEvent):void
		{
			//Create a bullet and add it to the stage
			var bulletImage:DisplayObject = new BulletImage();
			var bullet:GameObject = new GameObject(bulletImage);
			stage.addChild(bullet);
			
			//Set the bullet's starting position
			var radius:int = 30; 
			bullet.x = _bee.x + (radius * Math.cos(_beeAngle));
			bullet.y = _bee.y + (radius * Math.sin(_beeAngle));
			
			//Set the bullet's velocity based
			//on the angle 
			bullet.vx = Math.cos(_beeAngle) * 2 + _bee.vx;
			bullet.vy = Math.sin(_beeAngle) * 2 + _bee.vy;
			
			//Push the bullet into the _bullets array
			_bullets.push(bullet);
			
			//Find a random start time for the next bullet
			var randomFireTime:Number = Math.round(Math.random() * 1000) + 200;
			_bulletTimer.delay = randomFireTime;

		}
		private function enterFrameHandler(event:Event):void
		{
			//Get the target object
			var target_X:Number = stage.mouseX;
			var target_Y:Number = stage.mouseY;
			
			//Calculate the distance between the target and the bee
			var vx:Number = target_X - _bee.x;
			var vy:Number = target_Y - _bee.y;
			
			var distance:Number = Math.sqrt(vx * vx + vy * vy);
			if (distance <= RANGE)
			{
				//Find out how much to move
				var move_X:Number = TURN_SPEED * vx / distance;
				var move_Y:Number = TURN_SPEED * vy / distance;
				
				//Increase the bee's velocity 
				_bee.vx += move_X; 
				_bee.vy += move_Y;
				
				//Find the total distance to move
				var moveDistance:Number = Math.sqrt(_bee.vx * _bee.vx + _bee.vy * _bee.vy);
				
				//Apply easing
				_bee.vx = SPEED * _bee.vx / moveDistance;
				_bee.vy = SPEED * _bee.vy / moveDistance;
				
				//Rotate towards the bee towards the target
				//Find the angle in radians
				_beeAngle = Math.atan2(_bee.vy, _bee.vx);
				
				//Convert the radians to degrees to rotate
				//the bee corectly
				_bee.rotation = _beeAngle * 180 / Math.PI + 90;
				
				//Start the bullet timer
				_bulletTimer.start();
				
			}
			else
			{
				_bulletTimer.stop();
			}
			
			//Apply friction 
			_bee.vx *= FRICTION;
			_bee.vy *= FRICTION;
			
			//Move the bee
			_bee.x += _bee.vx;
			_bee.y += _bee.vy;
			
			//Move the bullets
			for(var i:int = 0; i < _bullets.length; i++)
			{
				var bullet:GameObject = _bullets[i];
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
	}
}