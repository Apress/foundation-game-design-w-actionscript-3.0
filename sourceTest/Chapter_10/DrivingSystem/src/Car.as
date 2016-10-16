package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Car extends Sprite
	{
		//Embed the image
		[Embed(source="../images/car.png")]
		private var CarImage:Class;
		
		//Private properties
		private var _carImage:DisplayObject = new CarImage();
		
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

		public function Car()
		{
			//Display the image in this class
			this.addChild(_carImage);
			_carImage.x -= _carImage.width / 2;
			_carImage.y -= _carImage.height / 2;
		}
	}	
}