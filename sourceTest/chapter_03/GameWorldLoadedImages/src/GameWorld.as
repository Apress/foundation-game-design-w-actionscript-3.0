package
{
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class GameWorld extends Sprite
	{
		//Declare the variables we need
		public var backgroundURL:URLRequest;
		public var backgroundLoader:Loader;
		public var background:Sprite;
		
		//Character
		public var characterURL:URLRequest;
		public var characterLoader:Loader;
		public var character:Sprite;
		
		//upButton
		public var upButtonURL:URLRequest;
		public var upButtonLoader:Loader;
		public var upButton:Sprite;
		
		//downButton
		public var downButtonURL:URLRequest;
		public var downButtonLoader:Loader;
		public var downButton:Sprite;
		
		//growButton
		public var growButtonURL:URLRequest;
		public var growButtonLoader:Loader;
		public var growButton:Sprite;
		
		//shrinkButton
		public var shrinkButtonURL:URLRequest;
		public var shrinkButtonLoader:Loader;
		public var shrinkButton:Sprite;
		
		//vanishButton
		public var vanishButtonURL:URLRequest;
		public var vanishButtonLoader:Loader;
		public var vanishButton:Sprite;
		
		//spinButton
		public var spinButtonURL:URLRequest;
		public var spinButtonLoader:Loader;
		public var spinButton:Sprite;
		
		public function GameWorld()
		{
			//Add the background to the stage
			backgroundURL = new URLRequest();
			backgroundLoader = new Loader();
			background = new Sprite();
		
			backgroundURL.url = "../images/background.png";
			backgroundLoader.load(backgroundURL);
			background.addChild(backgroundLoader);
			stage.addChild(background);
			
			//Add the character to the stage
			characterURL = new URLRequest();
			characterLoader = new Loader();
			character = new Sprite();
			characterURL.url = "../images/character.png";
			characterLoader.load(characterURL);
			character.addChild(characterLoader);
			stage.addChild(character);
			character.x = 225;
			character.y = 150;
			
			//Add the upButton
			upButtonURL = new URLRequest();
			upButtonLoader = new Loader();
			upButton = new Sprite();
			upButtonURL.url = "../images/up.png";
			upButtonLoader.load(upButtonURL);
			upButton.addChild(upButtonLoader);
			stage.addChild(upButton);
			upButton.x = 25;
			upButton.y = 25;
			
			//Add the downButton
			downButtonURL = new URLRequest();
			downButtonLoader = new Loader();
			downButton = new Sprite();
			downButtonURL.url = "../images/down.png";
			downButtonLoader.load(downButtonURL);
			downButton.addChild(downButtonLoader);
			stage.addChild(downButton);
			downButton.x = 25;
			downButton.y = 85;
			
			//Add the growButton
			growButtonURL = new URLRequest();
			growButtonLoader = new Loader();
			growButton = new Sprite();
			growButtonURL.url = "../images/grow.png";
			growButtonLoader.load(growButtonURL);
			growButton.addChild(growButtonLoader);
			stage.addChild(growButton);
			growButton.x = 25;
			growButton.y = 145;
			
			//Add the shrinkButton
			shrinkButtonURL = new URLRequest();
			shrinkButtonLoader = new Loader();
			shrinkButton = new Sprite();
			shrinkButtonURL.url = "../images/shrink.png";
			shrinkButtonLoader.load(shrinkButtonURL);
			shrinkButton.addChild(shrinkButtonLoader);
			stage.addChild(shrinkButton);
			shrinkButton.x = 25;
			shrinkButton.y = 205;
			
			//Add the vanishButton
			vanishButtonURL = new URLRequest();
			vanishButtonLoader = new Loader();
			vanishButton = new Sprite();
			vanishButtonURL.url = "../images/vanish.png";
			vanishButtonLoader.load(vanishButtonURL);
			vanishButton.addChild(vanishButtonLoader);
			stage.addChild(vanishButton);
			vanishButton.x = 25;
			vanishButton.y = 265;
			
			//Add the spinButton
			spinButtonURL = new URLRequest();
			spinButtonLoader = new Loader();
			spinButton = new Sprite();
			spinButtonURL.url = "../images/spin.png";
			spinButtonLoader.load(spinButtonURL);
			spinButton.addChild(spinButtonLoader);
			stage.addChild(spinButton);
			spinButton.x = 25;
			spinButton.y = 325;
		}
	}
}