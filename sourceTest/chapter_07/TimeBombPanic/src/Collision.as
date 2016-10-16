package
{
	import flash.display.Sprite;
	
	public class Collision
	{
		static public var collisionSide:String = ""; 
		
		public function Collision()
		{
		}
		static public function block(r1:Sprite, r2:Sprite):void
		{
			//Calculate the distance vector
			var vx:Number 
				= (r1.x + (r1.width / 2)) 
				- (r2.x + (r2.width / 2));
			
			var vy:Number 
				= (r1.y + (r1.height / 2)) 
				- (r2.y + (r2.height / 2));
			
			//Check whether vx 
			//is less than the combined half widths
			if(Math.abs(vx) < r1.width / 2 + r2.width / 2)
			{
				//A collision might be occurring! Check 
				//whether vy is less than the combined half heights
				if(Math.abs(vy) < r1.height / 2 + r2.height / 2)
				{
					//A collision has ocurred! This is good!
					
					//Find out the size of the overlap on both the X and Y axes
					var overlap_X:Number 
					= r1.width / 2 
						+ r2.width / 2 
						- Math.abs(vx);
					
					var overlap_Y:Number 
					= r1.height / 2 
						+ r2.height / 2 
						- Math.abs(vy);
					
					//The collision has occurred on the axis with the
					//*smallest* amount of overlap. Let's figure out which
					//axis that is
					
					if(overlap_X >=  overlap_Y)
					{
						//The collision is happening on the X axis
						//But on which side? _v0's vy can tell us 
						if(vy > 0)
						{
							collisionSide = "Top";
							
							//Move the rectangle out of the collision
							r1.y = r1.y + overlap_Y;
						}
						else
						{
							collisionSide = "Bottom";
							
							//Move the rectangle out of the collision
							r1.y = r1.y - overlap_Y;
						}
					}
					else
					{
						//The collision is happening on the Y axis
						//But on which side? _v0's vx can tell us 
						if(vx > 0)
						{
							collisionSide = "Left";
							
							//Move the rectangle out of the collision
							r1.x = r1.x + overlap_X;
						}
						else
						{
							collisionSide = "Right"; 
							
							//Move the rectangle out of the collision
							r1.x = r1.x - overlap_X;
						}
					}
				}
				else
				{
					//No collision
					collisionSide = "No collision";
				}
			}
			else
			{
				//No collision
				collisionSide = "No collision";
			}
		}
	}
}