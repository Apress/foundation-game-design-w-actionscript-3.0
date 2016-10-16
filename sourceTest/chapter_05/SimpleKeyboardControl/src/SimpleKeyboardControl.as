package
{
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent; 
	import flash.ui.Keyboard;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class SimpleKeyboardControl extends Sprite
	{
		//Create the game character objects
		public var characterURL:URLRequest = new URLRequest("../images/character.png");
		public var characterImage:Loader = new Loader();
		public var character:Sprite = new Sprite();

		public function SimpleKeyboardControl()
		{
		  //Load the image and add the character to the stage
		  characterImage.load(characterURL);
		  character.addChild(characterImage);
		  stage.addChild(character);
		  character.x = 225;
		  character.y = 150;
		  
		  //Add a KeyboardEvent listener
		  stage.addEventListener(KeyboardEvent.KEY_DOWN,  keyDownHandler);
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				character.x -= 10;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				character.x += 10;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				character.y += 10;
			}
			else if (event.keyCode == Keyboard.UP)
			{
				character.y -= 10; 
			}
		}
	}
}