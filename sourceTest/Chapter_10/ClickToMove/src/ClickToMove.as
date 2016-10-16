package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class ClickToMove extends Sprite
	{
		private const EASING:Number = 0.1
		private var _fairy:Fairy = new Fairy();
		
		//Variables to capture the point that
		//the mouse clicks
		private var _target_X:Number;
		private var _target_Y:Number;
		
		public function ClickToMove()
		{
			stage.addChild(_fairy);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler)
		}
		private function mouseDownHandler(event:MouseEvent):void
		{
			_target_X = stage.mouseX;
			_target_Y = stage.mouseY;
		}
		private function enterFrameHandler(event:Event):void
		{
			//Figure out the distance between the
			//target position and the center of the fairy
			var vx:Number 
				= _target_X - (_fairy.x + _fairy.width / 2); 
			var vy:Number 
				= _target_Y - (_fairy.y + _fairy.height / 2);  
			var distance:Number = Math.sqrt(vx * vx + vy * vy);
			
			//Move the fairy if it's more than 1 pixel 
			//away from the target position
			if (distance >= 1)
			{
				_fairy.x += vx * EASING; 
				_fairy.y += vy * EASING;
			}
		}
	}
}