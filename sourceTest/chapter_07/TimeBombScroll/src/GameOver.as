package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class GameOver extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/gameOver.png")]
		public var GameObjectImage:Class;
		public var gameObjectImage:DisplayObject = new GameObjectImage();
		public var gameObject:Sprite = new Sprite();
		
		public function GameOver()
		{
			gameObject.addChild(gameObjectImage);
			this.addChild(gameObject);
		}
	}
}