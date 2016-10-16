package
{
	import flash.display.Sprite;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class MakingBoxes extends Sprite
	{
		//An array to store the boxes
		private var _boxes:Array = new Array();
		
		//A 2D array to store the box x and y positions
		private var _boxPositions:Array = new Array();
		
		public function MakingBoxes()
		{
			//Set the box x and y positions
			_boxPositions 
			= [
				[0, 200],
				[100, 100],
				[100, 250],
				[150, 50],
				[150, 250],
				[200, 50],
				[300, 200],
				[350, 150],
				[400, 150],
				[400, 300],
				[450, 150],
				[450, 300],
				[500, 250]
			  ]; 
						
			//Make the boxes
			for(var i:int = 0; i < _boxPositions.length; i++)
			{
				//Create a box object
				var box:Box = new Box();
				
				//Add the box to the stage
				addChild(box);
				box.x = _boxPositions[i][0];
				box.y = _boxPositions[i][1];
				
				//Add it to the boxes array
				//for future use
				_boxes.push(box);
			}
		}
	}
}