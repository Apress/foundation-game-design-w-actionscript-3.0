package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Monster extends Sprite
	{
		//Embed the monster images 
		[Embed(source="../images/monsterMouthClosed.png")]
		private var MonsterMouthClosedImage:Class;
		[Embed(source="../images/monsterMouthOpen.png")]
		private var MonsterMouthOpenImage:Class;
		
		//Private properties
		private var _monsterMouthClosedImage:DisplayObject = new MonsterMouthClosedImage();
		private var _monsterMouthClosed:Sprite = new Sprite();
		private var _monsterMouthOpenImage:DisplayObject = new MonsterMouthOpenImage();
		private var _monsterMouthOpen:Sprite = new Sprite();
		private var _timer:Timer;
				
		//Public properties
		public var vx:int = 0;
		public var vy:int = 0;
		public var timesHit:int = 0;
		
		public function Monster()
		{
			_monsterMouthClosed.addChild(_monsterMouthClosedImage);
			this.addChild(_monsterMouthClosed);
			_monsterMouthOpen.addChild(_monsterMouthOpenImage);
			this.addChild(_monsterMouthOpen);
			_monsterMouthOpen.visible = false;
			
			//The mouth timer
			_timer = new Timer(2000);
		}
		
		//Public methods
		public function openMouth():void
		{
			_monsterMouthOpen.visible = true;
			_monsterMouthClosed.visible = false;
			_timer.addEventListener(TimerEvent.TIMER, mouthTimeHandler);
			_timer.start();
		}
		
		//Private methods
		private function mouthTimeHandler(event:TimerEvent):void
		{
			_monsterMouthOpen.visible = false;
			_monsterMouthClosed.visible = true;
			_timer.reset();
			_timer.removeEventListener(TimerEvent.TIMER, mouthTimeHandler);
		}
	}
}