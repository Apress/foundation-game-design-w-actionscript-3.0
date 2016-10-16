package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class BigBackground extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/bigBackground.png")]
		private var BackgroundImage:Class;
		private var _backgroundImage:DisplayObject = new BackgroundImage();
		private var _background:Sprite = new Sprite();
		
		//Public properties
		public var vx:int = 0;
		public var vy:int = 0;
		
		public function BigBackground()
		{
			_background.addChild(_backgroundImage);
			this.addChild(_background);
		}
	}
}