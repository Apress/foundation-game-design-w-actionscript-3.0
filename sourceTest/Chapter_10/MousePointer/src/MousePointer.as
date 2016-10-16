package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class MousePointer extends Sprite
	{
		private var _fairy:Fairy = new Fairy();
		
		public function MousePointer()
		{
			stage.addChild(_fairy);
			
			//Hide the mouse
			Mouse.hide();
			
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function enterFrameHandler(event:Event):void
		{
			//Center the fairy over the mouse
			_fairy.x = stage.mouseX - (_fairy.width / 2);
			_fairy.y = stage.mouseY - (_fairy.height / 2);
			
		}
	}
}