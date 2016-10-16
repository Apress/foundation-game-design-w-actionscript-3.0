package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class Follow extends Sprite
	{
		//Embed images
		[Embed(source="../images/bee.png")]
		private var BeeImage:Class;
		
		//Properties
		private const SPEED:Number = 3;
		private const TURN_SPEED:Number = 0.3;
		private const RANGE:Number = 200;
		private const FRICTION:Number = 0.96;
		private var _beeImage:DisplayObject = new BeeImage();
		private var _bee:GameObject = new GameObject(_beeImage);
		
		//The bee's angle of rotation
		private var _beeAngle:Number;

		public function Follow()
		{
			stage.addChild(_bee);
			_bee.x = 275;
			_bee.y = 175;
			
			//Add the event listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
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
				
				//Find total distance to move
				var moveDistance:Number = Math.sqrt(_bee.vx * _bee.vx + _bee.vy * _bee.vy);
				
				//Apply easing
				_bee.vx = SPEED * _bee.vx / moveDistance;
				_bee.vy = SPEED * _bee.vy / moveDistance;
				
				//Rotate the bee towards the target
				//Find the angle in radians
				_beeAngle = Math.atan2(_bee.vy, _bee.vx);
				
				//Convert the radians to degrees to rotate
				//the bee correctly
				_bee.rotation = _beeAngle * 180 / Math.PI + 90;

			}
			//Apply friction 
			_bee.vx *= FRICTION;
			_bee.vy *= FRICTION;
			
			//Move the bee
			_bee.x += _bee.vx;
			_bee.y += _bee.vy;
		}
	}
}