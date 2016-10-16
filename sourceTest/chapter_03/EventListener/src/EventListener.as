package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class EventListener extends Sprite
	{
		public function EventListener()
		{
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		public function clickHandler(event:MouseEvent):void
		{
		  trace("You clicked on the stage");
		}	
	}
}