package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class GameOver extends Sprite
	{
		//Embed the images
		[Embed(source="../images/levelComplete.png")]
		private var LevelCompleteImage:Class;
		[Embed(source="../images/youLost.png")]
		private var YouLostImage:Class;
		
		//Private properties
		private var _levelCompleteImage:DisplayObject = new LevelCompleteImage();
		private var _youLostImage:DisplayObject = new YouLostImage();
		
		//Public properties
		public var levelComplete:Sprite = new Sprite();
		public var youLost:Sprite = new Sprite();
		
		public function GameOver()
		{
			//Add the objects to this class
			//and make them invisible
			levelComplete.addChild(_levelCompleteImage);
			this.addChild(levelComplete);
			levelComplete.visible = false;
			
			youLost.addChild(_youLostImage);
			this.addChild(youLost);
			youLost.visible = false;
		}
	}
}