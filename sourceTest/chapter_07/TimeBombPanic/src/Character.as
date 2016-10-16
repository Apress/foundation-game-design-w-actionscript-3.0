package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Character extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/character.png")]
		public var GameObjectImage:Class;
		public var gameObjectImage:DisplayObject = new GameObjectImage();
		public var gameObject:Sprite = new Sprite();
		
		public function Character()
		{
			gameObject.addChild(gameObjectImage);
			this.addChild(gameObject);
		}
	}
}