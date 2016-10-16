package
{
	import flash.display.Sprite;
	
	public class MethodWithoutParameters extends Sprite
	{
		public function MethodWithoutParameters()
		{
			displayText();
		}
		
		public function displayText():void 
		{
			trace("This is text from the function definition"); 
		}
	}
}