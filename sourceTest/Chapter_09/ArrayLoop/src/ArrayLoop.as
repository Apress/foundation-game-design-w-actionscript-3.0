package
{
	import flash.display.Sprite;
	
	public class ArrayLoop extends Sprite
	{
		//Declare the array
		private var _collectionJar:Array;
		
		public function ArrayLoop()
		{
			//Instantiate the array
			_collectionJar = new Array();
			
			//Add elements to the array
			_collectionJar.push("fly"); 
			_collectionJar.push("mosquito"); 
			_collectionJar.push("bee");
			
			for (var i:int = 0; i < _collectionJar.length; i++)
			{
				trace("Element " + i + ": " + _collectionJar[i]);
			}
		}
	}
}