package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Background extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/background.png")]
		public var GameObjectImage:Class;
		public var gameObjectImage:DisplayObject = new GameObjectImage();
		public var gameObject:Sprite = new Sprite();
		
		public function Background()
		{
			gameObject.addChild(gameObjectImage);
			this.addChild(gameObject);
		}
	}
}