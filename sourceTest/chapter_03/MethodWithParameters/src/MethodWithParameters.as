package
{
	import flash.display.Sprite;
	
	public class MethodWithParameters extends Sprite
	{
		public function MethodWithParameters()
		{
			displayText("You can write any text you like here!");
		}
		
		public function displayText(textYouWantToDisplay:String):void 
		{
			trace(textYouWantToDisplay); 
		}
	}
}