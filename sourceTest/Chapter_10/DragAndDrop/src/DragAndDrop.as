package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]	
	
	public class DragAndDrop extends Sprite
	{
		//Embed the image for the card foreground
		[Embed(source="../images/cat.png")]
		private var CatImage:Class;
		
		//Private properties
		private var _catImage:DisplayObject = new CatImage();
		private var _card:Card = new Card(_catImage);
		private var _match:Match = new Match("cat");

		public function DragAndDrop()
		{
			this.addChild(_card);
			_card.x = 350;
			_card.y = 150;
			_card.buttonMode = true;
			_card.useHandCursor = true;
			
			this.addChild(_match);
			_match.x = 150;
			_match.y = 150;
			
			//Add event listeners
			_card.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler); 
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		public function enterFrameHandler(event:Event):void
		{
			if (_card.hitTestObject(_match))
			{
				if (!_card.isBeingDragged)
				{
					_card.x = _match.x + 5; 
					_card.y = _match.y + 5;
				}
			}
		}
		private function mouseDownHandler(event:MouseEvent):void
		{
			var card:Card = event.currentTarget as Card; 
			card.startDrag(); 
			setChildIndex(card, numChildren - 1); 
			card.isBeingDragged = true;
			card.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		private function mouseUpHandler(event:MouseEvent):void
		{
			var card:Card = event.currentTarget as Card;
			card.stopDrag(); 
			card.isBeingDragged = false;
			
			//For testing purposes you can 
			//Display the name of object that mouse is released over
			/*
			if(card.dropTarget != null)
			{
				trace(card.dropTarget.parent);
				trace(card.dropTarget);
			}
			*/
			
			//Remove this mouse listener
			card.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
	}
}