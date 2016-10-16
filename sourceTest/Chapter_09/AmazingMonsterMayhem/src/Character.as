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
		public var vx:int = 0;
		public var vy:int = 0;
		public var timesHit:int = 0;
		
		public function Character()
		{
			//Display the image in this class
			_character.addChild(_characterImage);
			this.addChild(_character);
		}
	}
}