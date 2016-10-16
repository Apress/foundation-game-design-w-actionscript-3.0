package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Frog extends Sprite
	{
		//Embed the body and eye images
		[Embed(source="../images/frogBody.png")]
		private var BodyImage:Class;
		[Embed(source="../images/eye.png")]
		private var EyeImage:Class;
		
		//Private properties
		//The frog's body
		private var _bodyImage:DisplayObject = new BodyImage();
		private var _body:Sprite = new Sprite();
		//The frog's eyes
		private var _leftEyeImage:DisplayObject = new EyeImage();
		private var _rightEyeImage:DisplayObject = new EyeImage();
		
		//Public properties
		public var leftEye:Sprite = new Sprite();
		public var rightEye:Sprite = new Sprite();
		
		public function Frog()
		{
			//Make the body
			_body.addChild(_bodyImage);
			this.addChild(_body);
			
			//Make the eyes
			leftEye.addChild(_leftEyeImage);
			rightEye.addChild(_rightEyeImage);
			
			//Center the eyes inside their containing Sprites
			//so that they will rotate around the center
			_leftEyeImage.x = -(_leftEyeImage.width / 2);
			_leftEyeImage.y = -(_leftEyeImage.height / 2);
			_rightEyeImage.x = -(_rightEyeImage.width / 2);
			_rightEyeImage.y = -(_rightEyeImage.height / 2);
			
			this.addChild(leftEye);
			this.addChild(rightEye);
			
			//Position the right eye
			rightEye.x = 38;
			rightEye.y = 13;
			
			//Position the left eye
			leftEye.x = 13;
			leftEye.y = 13;
		}
	}
}