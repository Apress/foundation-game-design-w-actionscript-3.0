package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	{
		public class GameObject extends Sprite
		{
			//Public properties
			public var vx:Number = 0;
			public var vy:Number = 0;
			
			public function GameObject(image:DisplayObject, center:Boolean = true)
			{
				//Add the image
				this.addChild(image);
				
				//Center the image if the "center" option is true
				if(center)
				{
					image.x -= image.width / 2;
					image.y -= image.height / 2;
				}
			}
		}
	}
}