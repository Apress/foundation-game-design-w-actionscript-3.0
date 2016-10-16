package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class EasingWithMouse extends Sprite
	{
		private var _fairy:Fairy = new Fairy();
		private const EASING:Number = 0.1
		
		public function EasingWithMouse()
		{
			stage.addChild(_fairy);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function enterFrameHandler(event:Event):void
		{
			//Figure out the distance between the
			//mouse and the center of the fairy
			var vx:Number 
			  = stage.mouseX - (_fairy.x + _fairy.width / 2); 
			var vy:Number 
			  = stage.mouseY - (_fairy.y + _fairy.height / 2);  
			var distance:Number = Math.sqrt(vx * vx + vy * vy);
			
			//Move the fairy if it's more than 1 pixel away from the mouse 
			if (distance >= 1)
			{
				_fairy.x += vx * EASING; 
				_fairy.y += vy * EASING;
			}			
		}
	}
}