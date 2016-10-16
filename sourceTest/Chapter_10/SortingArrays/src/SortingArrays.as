package
{
	import flash.display.Sprite;
	
	public class SortingArrays extends Sprite
	{
		private var _cardNames:Array = new Array();
		
		public function SortingArrays()
		{
			_cardNames =
				[
					"cat", 
					"frog", 
					"phobian", 
					"bee", 
					"bug", 
					"monster", 
					"hedgehog", 
					"tiger",
					"fairy"
				];
			
			//Sort the array alphabetically
			_cardNames.sort();
			trace(_cardNames);
			
			//Sort the array in reverse alphabetical order
			_cardNames.sort(Array.DESCENDING);
			trace(_cardNames);
			
			//Randomize the array order
			_cardNames.sort(shuffleArray);
			trace(_cardNames);
		}
		private function shuffleArray
			(valueOne:String, valueTwo:String):int
		{
			if (Math.random() < 0.5)
			{
				return -1;
			}
			else 
			{
				return 1;
			}
		}
	}
}