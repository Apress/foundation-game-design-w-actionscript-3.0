package
{
	import flash.display.Sprite;
	
	public class ArrayPush extends Sprite
	{
		//Declare the array
		private var _collectionJar:Array;
		
		public function ArrayPush()
		{
			//Instantiate the array
			_collectionJar = new Array();
			
			//Add elements to the array
			_collectionJar.push("fly"); 
			_collectionJar.push("mosquito"); 
			_collectionJar.push("bee");
			
			//Trace the entire array contents 
			trace("Entire Array:   " + _collectionJar);
			
			//Trace individual elements 
			trace("Element 0: " + _collectionJar[0]); 
			trace("Element 1: " + _collectionJar[1]); 
			trace("Element 2: " + _collectionJar[2]);
			
		}
	}
}