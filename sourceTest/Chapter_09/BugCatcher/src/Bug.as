package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Bug extends Sprite
	{
		//Embed the bug images 
		[Embed(source="../images/bugWingsUp.png")]
		private var WingsUpImage:Class;
		[Embed(source="../images/bugWingsDown.png")]
		private var WingsDownImage:Class;
		
		//Private properties
		private var _wingsUpImage:DisplayObject = new WingsUpImage();
		private var _wingsUp:Sprite = new Sprite();
		private var _wingsDownImage:DisplayObject = new WingsDownImage();
		private var _wingsDown:Sprite = new Sprite();
		private var _timer:Timer;
				
		//Public properties
		public var vx:int = 0;
		public var vy:int = 0;
		
		public function Bug()
		{
			_wingsUp.addChild(_wingsUpImage);
			this.addChild(_wingsUp);
			_wingsDown.addChild(_wingsDownImage);
			this.addChild(_wingsDown);
			_wingsDown.visible = false;
			
			//The wing timer
			_timer = new Timer(50);
			_timer.addEventListener(TimerEvent.TIMER, flapWingHandler);
			_timer.start();
		}
		
		//Private methods
		private function flapWingHandler(event:TimerEvent):void
		{
			_wingsDown.visible = !_wingsDown.visible;
			_wingsUp.visible = !_wingsUp.visible;
		}
	}
}