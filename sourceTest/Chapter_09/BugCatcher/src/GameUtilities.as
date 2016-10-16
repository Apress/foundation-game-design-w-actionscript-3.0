package
{
	import flash.display.Sprite;

	public class GameUtilities
	{
		public function GameUtilities()
		{
		}
		
		//Add an object to the game
		static public function addObjectToGame
			(
				gameObject:Sprite, 
			 	gameWorld:Object,
			 	xPos:int = 0, 
			 	yPos:int = 0
			):void
		{
			gameWorld.addChild(gameObject);
			gameObject.x = xPos;
			gameObject.y = yPos;
		}
		
		//Rotate an object towards another object
		static public function rotateToObject(objectOne:Sprite, objectTwo:Sprite):void
		{
			objectOne.rotation 
				= Math.atan2(objectOne.y - objectTwo.y, objectOne.x - objectTwo.x) 
				* (180/Math.PI); 
		}
		
	}
}