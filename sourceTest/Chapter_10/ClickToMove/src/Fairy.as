package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Fairy extends Sprite
	{
		//Embed the image
		[Embed(source="../images/fairy.png")]
		private var FairyImage:Class;
		
		//Private properties
		private var _fairyImage:DisplayObject = new FairyImage();
		private var _fairy:Sprite = new Sprite();
		
		//Public properties
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var accelerationX:Number = 0; 
		public var accelerationY:Number = 0; 
		public var speedLimit:Number = 5; 
		public var friction:Number = 0.96;

		public function Fairy()
		{
			//Display the image in this class
			_fairy.addChild(_fairyImage);
			this.addChild(_fairy);
		}
	}
}