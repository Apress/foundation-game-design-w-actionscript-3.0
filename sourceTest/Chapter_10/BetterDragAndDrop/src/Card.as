package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	{
		public class Card extends Sprite
		{
			//Embed the card background image
			[Embed(source="../images/card.png")]
			private var CardBackgroundImage:Class;
			
			//Private properties
			private var _cardBackgroundImage:DisplayObject 
			  = new CardBackgroundImage();
			  
			//Public properties
			public var isBeingDragged:Boolean = false;

			public function Card(cardImage:DisplayObject)
			{
				//Add the background image
				this.addChild(_cardBackgroundImage);
				cardImage. x = 12;
				cardImage. y = 12;
				
				//Add the foreground image to the card
				this.addChild(cardImage);
				cardImage.x = (_cardBackgroundImage.width - cardImage.width) / 2;
				cardImage.y = (_cardBackgroundImage.height - cardImage.height) / 2;
			}
		}
	}
}