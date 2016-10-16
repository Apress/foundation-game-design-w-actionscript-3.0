package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class TimeDisplay extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/timeDisplay.png")]
		public var GameObjectImage:Class;
		public var gameObjectImage:DisplayObject = new GameObjectImage();
		public var gameObject:Sprite = new Sprite();
		
		public function TimeDisplay()
		{
			gameObject.addChild(gameObjectImage);
			this.addChild(gameObject);
		}
	}
}