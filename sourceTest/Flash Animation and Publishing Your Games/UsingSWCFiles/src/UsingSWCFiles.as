package
{
	import flash.display.*;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class UsingSWCFiles extends Sprite
	{
		public function UsingSWCFiles()
		{
			//Create a new rocket object
			var rocket:Rocket = new Rocket();
			addChild(rocket);
			rocket.x = 200;
			rocket.y = 175;
			
			//Create a new flame object
			var flame:Flame = new Flame();
			addChild(flame);
			flame.x = 300;
			flame.y = 175;
			
			flame.stop();

			rocket.flame.stop();
		}
	}
}
