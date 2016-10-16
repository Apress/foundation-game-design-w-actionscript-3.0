package
{
	import flash.display.*;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class EmbeddingAssets extends Sprite
	{
		//Embed the symbols from the SWF file
		[Embed(source="../swfs/resourceLibrary.swf", symbol="Rocket")]
		private var Rocket:Class;
		
		[Embed(source="../swfs/resourceLibrary.swf", symbol="Flame")]
		private var Flame:Class;
		
		public function EmbeddingAssets()
		{
			//Create a new rocket object
			var rocket:Sprite = new Rocket();
			addChild(rocket);
			rocket.x = 200;
			rocket.y = 175;
			
			//Create a new flame object
			var flame:MovieClip = new Flame();
			addChild(flame);
			flame.x = 300;
			flame.y = 175;
			
			//flame.stop();
			
			//Get access to rocket's flame sub object
			var rocketFlame:MovieClip 
			= rocket.getChildByName("flame") as MovieClip;
			
			//rocketFlame.stop();
		}
	}
}
