package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Rocket extends Sprite
	{
		//Embed the image
		[Embed(source="../images/rocket.png")]
		private var RocketImage:Class;
		
		//Private properties
		private var _rocketImage:DisplayObject = new RocketImage();
		
		//Public properties
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var speed:Number = 0;
		public var acceleration_X:Number = 0; 
		public var acceleration_Y:Number = 0; 
		public var speedLimit:Number = 5; 
		public var friction:Number = 0.96;
		public var rotationSpeed:Number = 0;

		public function Rocket()
		{
			//Display the image in this class
			this.addChild(_rocketImage);
			_rocketImage.x -= _rocketImage.width / 2;
			_rocketImage.y -= _rocketImage.height / 2;
		}
	}	
}