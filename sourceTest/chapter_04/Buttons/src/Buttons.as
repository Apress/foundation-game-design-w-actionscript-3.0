package
{
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class Buttons extends Sprite
	{
		//Create URLRequest objects to get the paths to the images
		public var buttonUpURL:URLRequest = new URLRequest("../images/buttonUp.png");
		public var buttonOverURL:URLRequest = new URLRequest("../images/buttonOver.png");
		public var buttonDownURL:URLRequest = new URLRequest("../images/buttonDown.png");
		
		//Create Loaders for the images
		public var buttonUpImage:Loader = new Loader();
		public var buttonOverImage:Loader = new Loader();
		public var buttonDownImage:Loader = new Loader();
		
		//Create a single Sprite to contain the images
		public var button:Sprite = new Sprite();
		
		public function Buttons()
		{
			makeButton();
		}
		public function makeButton():void
		{
			//Load the images
			buttonUpImage.load(buttonUpURL);
			buttonDownImage.load(buttonDownURL);
			buttonOverImage.load(buttonOverURL);
			
			//Make the images invisible, except
			//for the up image
			buttonUpImage.visible = true;
			buttonDownImage.visible = false;
			buttonOverImage.visible = false;
			
			//Add the images to the button Sprite
			button.addChild(buttonUpImage);
			button.addChild(buttonDownImage);
			button.addChild(buttonOverImage);
			
			//Set the Sprite's button properties
			button.buttonMode = true;
			button.mouseEnabled = true;
			button.useHandCursor = true;
			button.mouseChildren = false;
			
			//Add the button Sprite to the stage
			stage.addChild(button);
			button.x = 225;
			button.y = 175;
			
			//Add the button event listeners
			button.addEventListener(MouseEvent.ROLL_OVER, overHandler);
			button.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			button.addEventListener(MouseEvent.ROLL_OUT, resetHandler);
			button.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		public function overHandler(event:MouseEvent):void
		{
			buttonUpImage.visible = false;
			buttonDownImage.visible = false;
			buttonOverImage.visible = true;
			trace("over");
		}
		public function downHandler(event:MouseEvent):void
		{
			buttonUpImage.visible = false;
			buttonDownImage.visible = true;
			buttonOverImage.visible = false;
			trace("down");
		}
		public function clickHandler(event:MouseEvent):void
		{
			buttonUpImage.visible = true;
			buttonDownImage.visible = false;
			buttonOverImage.visible = false;
			trace("click");
		}
		public function resetHandler(event:MouseEvent):void
		{
			buttonUpImage.visible = true;
			buttonDownImage.visible = false;
			buttonOverImage.visible = false;
			trace("reset");
		}
		
	}
}