package
{
	import flash.display.Sprite;
	
	public class ArrayLoop2D extends Sprite
	{
		//The array
		private var _collectionJar:Array = new Array();
		
		public function ArrayLoop2D()
		{	
			_collectionJar 
			= [
				["mosquito", "bee", "fly"],
				["lark", "magpie", "albatross"],
				["snail", "slug", "worm"]
			  ];
			
			//Find the number of rows and columns
			var maxRows:uint = _collectionJar.length;
			var maxColumns:uint = _collectionJar[0].length;
			
			for(var column:int = 0; column < maxColumns; column++) 
			{
				trace("---");
				
				for(var row:int = 0; row < maxRows; row++) 
				{
					//Organize into rows
					trace(_collectionJar[column][row]);
					
					//Organize into columns
					//trace(_collectionJar[row][column]);
				}
			}
		}
	}
}