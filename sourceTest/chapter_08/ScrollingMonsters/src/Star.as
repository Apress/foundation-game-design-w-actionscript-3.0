package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Star extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/star.png")]
		private var StarImage:Class;
		
		//Private properties
		private var _starImage:DisplayObject = new StarImage();
		private var _star:Sprite = new Sprite();
		
		//Public properties
		public var vx:int = 0;
		public var vy:int = 3;
		public var launched:Boolean = false;
		
		public function Star()
		{
			_star.addChild(_starImage);
			
			//Center the star image in the sprite
			_starImage.x = -(_starImage.width / 2);
			_starImage.y = -(_starImage.height / 2);
			
			//Add the star game object to this class
			this.addChild(_star);	
		}
	}
}