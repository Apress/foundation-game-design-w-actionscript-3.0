package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class PlottingGrids extends Sprite
	{
		//The number of column and row in the grid
		private const COLUMNS:uint = 3;
		private const ROWS:uint = 3;
		private const SPACE:uint = 10;
		
		public function PlottingGrids()
		{	
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
					square.x = column * (square.width + SPACE);
					square.y = row * (square.height + SPACE);
				}
			}
		}
	}
}