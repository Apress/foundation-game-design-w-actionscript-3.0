package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Bullet extends Sprite
	{
		//Embed the bullet image
		[Embed(source="../images/bullet.png")]
		private var BulletImage:Class;
		
		//Private properties
		private var _bulletImage:DisplayObject = new BulletImage();
		
		//Public properties
		public var vx:Number = 0;
		public var vy:Number = 0;
		
		public function Bullet()
		{
			this.addChild(_bulletImage);
			
			//Center the image
			_bulletImage.x = -(_bulletImage.width / 2);
			_bulletImage.y = -(_bulletImage.height / 2);
		}
	}
}