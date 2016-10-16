package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class GridWithOffset extends Sprite
	{
		//The number of columns and rows in the grid
		private const COLUMNS:uint = 3;
		private const ROWS:uint = 3;
		private const SPACE:uint = 10;
		
		public function GridWithOffset()
		{	
			var offset_X:uint = 100;
			var offset_Y:uint = 100;
			
			for(var column:int = 0; column < COLUMNS; column++) 
			{
				for(var row:int = 0; row < ROWS; row++) 
				{
					//Make a square
					var square:Shape = new Shape();
					square.graphics.beginFill(0x000); 
					square.graphics.drawRect(0, 0, 50, 50);
					square.graphics.endFill();
					addChild(square);
					
					//Position the square on the grid
					square.x = offset_X + (column * (square.width + SPACE));
					square.y = offset_Y + (row * (square.height + SPACE));
				}
			}
		}
	}
}