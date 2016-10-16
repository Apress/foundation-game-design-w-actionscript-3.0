package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	[SWF(width="550", height="400", 
  backgroundColor="#FFFFFF", frameRate="60")]
	
	public class AnimationControl extends Sprite
	{	
		//Create the objects needed to load and display the SWF
		private var _swfURL:URLRequest 
		  = new URLRequest("../swfs/mainStageAnimation.swf");
		private var _swfLoader:Loader = new Loader();
		private var _animation:MovieClip;
		
		public function AnimationControl()
		{
			//Load the SWF and add a listener that runs when
			//the file is loaded
			_swfLoader.load(_swfURL);
			_swfLoader.contentLoaderInfo.addEventListener
				(Event.COMPLETE, swfLoadHandler);
			
			//An mouse event listener starts the animation
			//when the stage is clicked
			stage.addEventListener
				(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		private function swfLoadHandler(event:Event):void
		{
			//Copy the event handler's currentTarget.content property
			//into the _animation MovieClip object
			_animation = event.currentTarget.content;
			
			//Add the _animation to the stage
			stage.addChild(_animation);
			
			//Stop the animation at the first frame
			_animation.stop();
			
			//Display the animation's total frames and current frame
			trace(_animation.currentFrame);  //Displays 1
			trace(_animation.totalFrames);  //Displays 120
		}
		private function mouseDownHandler(event:MouseEvent):void
		{
			//Play the animation when the stage is clicked
			_animation.play();
		}
	}
}
