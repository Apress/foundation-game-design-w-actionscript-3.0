package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Tank extends Sprite
	{
		//Embed the images
		[Embed(source="../images/body.png")]
		private var BodyImage:Class;
		[Embed(source="../images/turret.png")]
		private var TurretImage:Class;
		
		//Private properties
		private var _bodyImage:DisplayObject = new BodyImage();
		public var _turretImage:DisplayObject = new TurretImage();
		public var turret:Sprite = new Sprite();
		
		//Public properties
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var speed:Number = 0;
		public var accelerate:Boolean = false;
		public var acceleration_X:Number = 0; 
		public var acceleration_Y:Number = 0; 
		public var speedLimit:Number = 5; 
		public var friction:Number = 0.97;
		public var rotationSpeed:Number = 0;

		public function Tank()
		{
			//Display and center the tank body image
			this.addChild(_bodyImage);
			_bodyImage.x -= _bodyImage.width / 2;
			_bodyImage.y -= _bodyImage.height / 2;
			
			//Add the turretImage to the turret sprite
			turret.addChild(_turretImage);
			
			//Center the turret image inside
			//the turret sprite
			//this.addChild(_turretImage);
			_turretImage.x -= _turretImage.width / 2;
			_turretImage.y -= _turretImage.height / 2;
			
			//Add the turret sprite
			this.addChild(turret);
		}
	}	
}