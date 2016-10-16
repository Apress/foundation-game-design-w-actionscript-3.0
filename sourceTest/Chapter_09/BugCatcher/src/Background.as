package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Background extends Sprite
	{
		//Embed the background image
		[Embed(source="../images/background.png")]
		private var BackgroundImage:Class;
		private var _backgroundImage:DisplayObject = new BackgroundImage();
		private var _background:Sprite = new Sprite();
		
		public function Background()
		{
			_background.addChild(_backgroundImage);
			this.addChild(_background);
		}
	}
}