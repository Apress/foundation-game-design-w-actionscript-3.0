package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Box extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/box.png")]
		public var GameObjectImage:Class;
		public var gameObjectImage:DisplayObject = new GameObjectImage();
		public var gameObject:Sprite = new Sprite();
		
		public function Box()
		{
			gameObject.addChild(gameObjectImage);
			this.addChild(gameObject);
		}
	}
}