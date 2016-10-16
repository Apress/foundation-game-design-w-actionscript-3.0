package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Explosion extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/explosion.png")]
		private var ExplosionObjectImage:Class;
		
		//Private properties
		private var _explosionImage:DisplayObject = new ExplosionObjectImage();
		private var _explosion:Sprite = new Sprite();
		private var _timer:Timer;
		
		public function Explosion()
		{
			_explosion.addChild(_explosionImage);
			_explosion.visible = false;
			this.addChild(_explosion);	
			
			_timer = new Timer(2000);
		}
		
		//Public methods
		public function explode():void
		{
			_explosion.visible = true;
			_timer.addEventListener(TimerEvent.TIMER, explosionTimeHandler);
			_timer.start();
		}
		
		//Private methods
		private function explosionTimeHandler(event:TimerEvent):void
		{
			_explosion.visible = false;
			_timer.reset();
			_timer.removeEventListener(TimerEvent.TIMER, explosionTimeHandler);
		}
	}
}