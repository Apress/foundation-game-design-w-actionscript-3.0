package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Character extends Sprite
	{
		//Embed the image
		[Embed(source="../images/character.png")]
		private var CharacterImage:Class;
		
		//Private properties
		private var _characterImage:DisplayObject = new CharacterImage();
		private var _character:Sprite = new Sprite();
		
		//Public properties
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var accelerationX:Number = 0; 
		public var accelerationY:Number = 0; 
		public var speedLimit:Number = 5; 
		public var friction:Number = 0.96; 
		public var bounce:Number = -0.7;
		public var gravity:Number =0.3; 
		public var isOnGround:Boolean = undefined; 
		public var jumpForce:Number = -10;

		public function Character()
		{
			//Display the image in this class
			_character.addChild(_characterImage);
			this.addChild(_character);
		}
	}
}