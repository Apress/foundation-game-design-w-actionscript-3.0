package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Grass extends Sprite
	{
		//Embed the grass image
		[Embed(source="../images/grass.png")]
		private var GrassImage:Class;
		
		//Private properties
		private var _grassImage:DisplayObject = new GrassImage();
		private var _grass:Sprite = new Sprite();
		
		public function Grass()
		{
			_grass.addChild(_grassImage);
			this.addChild(_grass);
		}
	}
}