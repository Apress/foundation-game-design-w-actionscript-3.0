package
{
	import flash.display.Sprite;
	
	public class ArraysInsideArrays extends Sprite
	{
		//Declare the array
		private var _collectionJar:Array;
		
		public function ArraysInsideArrays()
		{
			//Initialize the 2 dimensional array
			_collectionJar 
			  = [
			  		["mosquito", "bee", "fly"],
					["lark", "magpie", "albatross"],
					["snail", "slug", "worm"]
			    ];
			
			//View the entire first array
			//mosquito, bee, fly  
			trace("Array 0: " + _collectionJar[0]);
			
			//View the entire second array
			//lark, magpie, albatross
			trace("Array 1: " + _collectionJar[1]);
			
			//View the first element in the second array
			//lark
			trace("First element of the second array: " + _collectionJar[1][0]);
			
			//View the third element in the third array
			//worm
			trace("Third element of the third array: " + _collectionJar[2][2]);
			
			//View the second element in the first array
			//bee
			trace("Second element of the first array: " + _collectionJar[0][1]);
			
			//View the contents of the entire 2 dimensional array
			//mosquito, bee, fly, lark, magpie, albatross, snail, slug, worm
			trace("Entire collection jar: " + _collectionJar);
		}
	}
}