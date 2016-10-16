package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	
	[SWF(width="700", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]	
	
	public class MatchingGame extends Sprite
	{
		//Embed the images for the card foregrounds
		[Embed(source="../images/cat.png")]
		private var CatImage:Class;
		[Embed(source="../images/frog.png")]
		private var FrogImage:Class;
		[Embed(source="../images/phobian.png")]
		private var PhobianImage:Class;
		[Embed(source="../images/bee.png")]
		private var BeeImage:Class;
		[Embed(source="../images/bug.png")]
		private var BugImage:Class;
		[Embed(source="../images/monster.png")]
		private var MonsterImage:Class;
		[Embed(source="../images/hedgehog.png")]
		private var HedgehogImage:Class;
		[Embed(source="../images/fairy.png")]
		private var FairyImage:Class;
		[Embed(source="../images/tiger.png")]
		private var TigerImage:Class;
		
		//Private properties
		private var cat:DisplayObject = new CatImage();
		private var frog:DisplayObject = new FrogImage();
		private var phobian:DisplayObject = new PhobianImage();
		private var bee:DisplayObject = new BeeImage();
		private var bug:DisplayObject = new BugImage();
		private var monster:DisplayObject = new MonsterImage();
		private var hedgehog:DisplayObject = new HedgehogImage();
		private var tiger:DisplayObject = new TigerImage();
		private var fairy:DisplayObject = new FairyImage();
		
		//Constants to store the columns and rows for the grid layout
		private const COLUMNS:uint = 3;
		private const ROWS:uint = 3;
		private const SPACE:uint = 10;
		
		//An array to store the names of all the cards
		private var _cardNames:Array = new Array()
		
		//Arrays to store the matchs and cards
		private var _matches:Array = new Array(); 
		private var _cards:Array = new Array();
		  
		private var _match:Match = new Match("cat");
		private var _rectangle:Rectangle = new Rectangle(0, 0, 615, 315);
		private const EASING:Number = 0.3;
		
		public function MatchingGame()
		{
			//Initialize the card names array
			_cardNames =
				[
					"cat", 
					"frog", 
					"phobian", 
					"bee", 
					"bug", 
					"monster", 
					"hedgehog", 
					"tiger",
					"fairy"
				];
			
			//MAKE THE MATCH OBJECTS
			
			//Shuffle the cards
			_cardNames.sort(shuffleArray);
			
			//A temporary variable to store the 
			//current match object
			var match:Match;
			
			for(var i:int = 0; i < _cardNames.length; i++)
			{
				match = new Match(_cardNames[i]);
				_matches.push(match);
			}
			
			//A variable to track the current index number
			//of the match object being accessed in the loop
			var matchCounter:uint = 0;
			
			//The x and y start positions of 
			//the match grid on the stage
			var matchGridStart_X:uint = 50;
			var matchGridStart_Y:uint = 50;
			
			for(var columns:int = 0; columns < COLUMNS; columns++) 
			{
				for(var rows:int = 0; rows < ROWS; rows++) 
				{
					//A temporary object to reference the
					//current match object in the loop
					match = _matches[matchCounter]
					addChild(match);
		
					//Position the match object in a square
					//on the grid
					match.x 
						= matchGridStart_X 
						+ (columns * (match.width + SPACE));
					
					match.y 
						= matchGridStart_Y 
						+ (rows * (match.height + SPACE));
					
					matchCounter++;
				}
			}
			
			//MAKE THE CARD OBJECTS
			
			//Shuffle the cards again
			_cardNames.sort(shuffleArray);
			
			//A temporary variable to store the 
			//current card object
			var card:Card;
			for(var j:int = 0; j < _cardNames.length; j++)
			{
				card = new Card(this[_cardNames[j]]);
				card.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler); 
				card.name = _cardNames[j];
				_cards.push(card);
			}
			
			//A variable to track the current index number
			//of the card object being accessed in the loop
			var cardCounter:uint = 0;
			
			//The x and y start positions of 
			//the card grid on the stage
			var cardGridStart_X:uint = 400;
			var cardGridStart_Y:uint = 65;
			
			for(columns = 0; columns < COLUMNS; columns++) 
			{
				for(rows = 0; rows < ROWS; rows++) 
				{
					//A temporary object to reference the
					//current card object in the loop
					card = _cards[cardCounter];
					addChild(card);
					
					//Position the match object in a square
					//on the grid
					card.x 
						= cardGridStart_X 
						+ (columns * (card.width + SPACE));
					
					card.y 
						= cardGridStart_Y 
						+ (rows * (card.height + SPACE));
					
					cardCounter++;
				}
			}
			
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		public function enterFrameHandler(event:Event):void
		{
			for(var i:int = 0; i < _cards.length; i++)
			{
				var card:Card = _cards[i];
				
				for(var j:int = 0; j < _matches.length; j++)
				{
					var match:Match = _matches[j];
					
					if (card.hitTestObject(match)
					&& card.name == match.name)
					{
						if (!card.isBeingDragged)
						{
							card.x += (match.x + 5 - card.x) * EASING; 
							card.y += (match.y + 5 - card.y) * EASING;
						}
					}
				}
			}		
		}
		private function shuffleArray
		  (valueOne:String, valueTwo:String):int
		{
			if (Math.random() < 0.5)
			{
				return -1;
			}
			else 
			{
				return 1;
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