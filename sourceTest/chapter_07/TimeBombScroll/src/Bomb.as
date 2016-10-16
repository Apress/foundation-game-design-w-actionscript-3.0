package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Bomb extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/bomb.png")]
		public var GameObjectImage:Class;
		public var gameObjectImage:DisplayObject = new GameObjectImage();
		public var gameObject:Sprite = new Sprite();
		
		public function Bomb()
		{
			gameObject.addChild(gameObjectImage);
			this.addChild(gameObject);
		}
	}
}