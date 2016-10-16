package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.geom.Rectangle;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]	
	
	public class BetterDragAndDrop extends Sprite
	{
		//Embed the image for the card foreground
		[Embed(source="../images/cat.png")]
		private var CatImage:Class;
		
		//Private properties
		private var _catImage:DisplayObject = new CatImage();
		private var _card:Card = new Card(_catImage);
		private var _match:Match = new Match("cat");
		private var _rectangle:Rectangle = new Rectangle(0, 0, 465, 315);
		private const EASING:Number = 0.3;
				
		public function BetterDragAndDrop()
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
					_card.x += (_match.x + 5 - _card.x) * EASING; 
					_card.y += (_match.y + 5 - _card.y) * EASING;
				}
			}
		}
		public function addDropShadow(gameObject:Sprite):void
		{
			var shadow:DropShadowFilter = new DropShadowFilter();
			shadow.distance = 4; 
			shadow.angle = 45; 
			shadow.strength = 0.6;
			shadow.quality = BitmapFilterQuality.LOW;
			gameObject.filters = [shadow];

		}
		public function changeCardSize(card:Card):void
		{
			if(card.isBeingDragged)
			{
				card.height = 85;
				card.width = 85;
				card.x -= 5;
				card.y -= 5;
			}
			else
			{
				card.height = 75;
				card.width = 75;
				card.x += 5;
				card.y += 5;
			}
		}
		private function mouseDownHandler(event:MouseEvent):void
		{
			var card:Card = event.currentTarget as Card; 
			card.startDrag(false, _rectangle); 
			setChildIndex(card, numChildren - 1); 
			card.isBeingDragged = true;
			
			//Change the size of the card
			changeCardSize(card);
			
			//Add a drop shadow filter
			addDropShadow(card);
				
			card.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		private function mouseUpHandler(event:MouseEvent):void
		{
			var card:Card = event.currentTarget as Card;
			card.stopDrag(); 
			card.isBeingDragged = false;
			
			//Change the size of the card
			changeCardSize(card);
			
			//Remove the drop shadow filter if there is one
			if(card.filters != null)
			{
			  card.filters = null;
			}
			
			//Remove this listener
			card.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
	}
}