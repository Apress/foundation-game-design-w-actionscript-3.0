package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class BigBackground extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/bigBackground.png")]
		public var GameObjectImage:Class;
		public var gameObjectImage:DisplayObject = new GameObjectImage();
		public var gameObject:Sprite = new Sprite();
		
		public function BigBackground()
		{
			gameObject.addChild(gameObjectImage);
			this.addChild(gameObject);
		}
	}
}