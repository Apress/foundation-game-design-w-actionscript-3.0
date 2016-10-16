package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class ButtonFairy extends Sprite
	{
		//Embed the images
		[Embed(source="../images/fairy.png")]
		private var FairyImage:Class;
		[Embed(source="../images/wand.png")]
		private var WandImage:Class;
		[Embed(source="../images/star.png")]
		private var StarImage:Class;
		
		//Private properties
		private const EASING:Number = 0.1;
		private var _fairyImage:DisplayObject = new FairyImage();
		private var _wandImage:DisplayObject = new WandImage();
		
		//Create the fairy and wand game objects
		//(The images will be centered by the GameObject class)
		private var _fairy:GameObject = new GameObject(_fairyImage);
		private var _wand:GameObject = new GameObject(_wandImage);
		
		//A variable to store the angle between
		//the mouse and the center of the fairy
		private var _angle:Number;
		
		//An array to store the stars
		private var _stars:Array = new Array();
		
		public function ButtonFairy()
		{
			//Add the fairy and the wand to the stage
			stage.addChild(_fairy);
			stage.addChild(_wand);
			
			//Hide the mouse
			Mouse.hide();
			
			//Add the event listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		private function enterFrameHandler(event:Event):void
		{			
			//Find the angle between the center of the
			//fairy and the mouse
			_angle
			  = Math.atan2
			  (
				_fairy.y - stage.mouseY, 
				_fairy.x - stage.mouseX
			  );
			
			//Move the wand around the fairy
			var radius:int = -50;
			_wand.x = _fairy.x + (radius * Math.cos(_angle));
			_wand.y = _fairy.y + (radius * Math.sin(_angle));

			//Figure out the distance between the
			//mouse and the center of the fairy
			var vx:Number = stage.mouseX - _fairy.x; 
			var vy:Number = stage.mouseY - _fairy.y;  
			var distance:Number = Math.sqrt(vx * vx + vy * vy);
			
			//Move the fairy if it's more than 1 pixel away from the mouse 
			if (distance >= 1)
			{
				_fairy.x += vx * EASING; 
				_fairy.y += vy * EASING;
			}
			
			//Move the stars
			for(var i:int = 0; i < _stars.length; i++)
			{
				var star:GameObject = _stars[i];
				star.x += star.vx;
				star.y += star.vy;
				
				//check the star's stage boundaries
				if (star.y < 0
				|| star.x < 0
				|| star.x > stage.stageWidth
				|| star.y > stage.stageHeight)
				{
					//Remove the star from the stage
					stage.removeChild(star);
					
					//Remove the star from the _stars
					//array
					_stars.splice(i,1);
					
					//Reduce the loop counter 
					//by one to compensate
					//for the removed star
					i--;
				}
			}
		}
		private function mouseDownHandler(event:MouseEvent):void
		{
			//Create a star and add it to the stage
			var starImage:DisplayObject = new StarImage();
			var star:GameObject = new GameObject(starImage);
			stage.addChild(star);
			
			//Set the star's starting position
			//to the wand's position
			star.x = _wand.x;
			star.y = _wand.y;
			
			//Set the star's velocity based
			//on the angle between the center of
			//the fairy and the mouse
			star.vx = Math.cos(_angle) * -7;
			star.vy = Math.sin(_angle) * -7;
			
			//Push the star into the _stars array
			_stars.push(star);
		}	
	}
}