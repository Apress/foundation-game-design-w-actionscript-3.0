package
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.*;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	[SWF(width="800", height="600", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class ClickToPlay extends Sprite
	{
		//The images
		[Embed(source="../images/fairy.png")]
		private var FairyImage:Class;
		[Embed(source="../images/wand.png")]
		private var WandImage:Class;
		[Embed(source="../images/star.png")]
		private var StarImage:Class;
		[Embed(source="../images/background.png")]
		private var BackgroundImage:Class;
		[Embed(source="../images/bee.png")]
		private var BeeImage:Class;
		[Embed(source="../images/bullet.png")]
		private var BulletImage:Class;
		
		//Properties
		private const SPEED:Number = 3;
		private const TURN_SPEED:Number = 0.3;
		private const RANGE:Number = 500;
		private const FRICTION:Number = 0.96;
		private const EASING:Number = 0.1;
		private var _fairyImage:DisplayObject = new FairyImage();
		private var _wandImage:DisplayObject = new WandImage();
		private var _backgroundImage:DisplayObject = new BackgroundImage();
		private var _beeImage:DisplayObject = new BeeImage();
		private var _fairy:GameObject = new GameObject(_fairyImage);
		private var _wand:GameObject = new GameObject(_wandImage);
		private var _bee:GameObject = new GameObject(_beeImage);
		private var _background:GameObject = new GameObject(_backgroundImage, false);
		private var _angle:Number;
		private var _beeAngle:Number;
		private var _stars:Array = new Array();
		private var _bullets:Array = new Array();
		private var _bulletTimer:Timer;
		private var _format:TextFormat = new TextFormat();
		private var _fairyScoreDisplay:TextField = new TextField();
		private var _beeScoreDisplay:TextField = new TextField();
		private var _fairyScore:int;
		private var _beeScore:int;
		
		private var _swfURL:URLRequest 
		  = new URLRequest("../swfs/gameTitle.swf");
		private var _swfLoader:Loader = new Loader();
		private var _title:MovieClip;
		
		public function ClickToPlay()
		{
			_swfLoader.load(_swfURL);
			_swfLoader.contentLoaderInfo.addEventListener
				(Event.COMPLETE, swfLoadHandler);
		}
		private function swfLoadHandler(event:Event):void
		{
			//Add the game objects
			stage.addChild(_background);
			setupTextFields();
			stage.addChild(_fairy);
			_fairy.x = 375;
			_fairy.y = 275;
			_fairy.visible = false;
			
			stage.addChild(_wand);
			
			stage.addChild(_bee);
			_bee.x = 275;
			_bee.y = 175;
			_bee.visible = false;
			
			//Initialize the timer
			_bulletTimer = new Timer(500);
			_bulletTimer.addEventListener(TimerEvent.TIMER, bulletTimerHandler);
			
			//Add the event listeners
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			//Copy the event handler's currentTarget.content property
			//into the _title MovieClip object
			_title = event.currentTarget.content;
			
			//Add the _title to the stage
			stage.addChild(_title);
			
			//Add a MOUSE_DOWN listener to the loaded SWF's button
			_title.playButton.addEventListener
				(MouseEvent.MOUSE_DOWN, playButtonHandler);

		}
		private function playButtonHandler(event:MouseEvent):void
		{
			_title.visible = false;
			_bee.visible = true;
			_fairy.visible = true;
			stage.addEventListener
				(Event.ENTER_FRAME, enterFrameHandler);
			_title.playButton.addEventListener
				(MouseEvent.MOUSE_DOWN, playButtonHandler)
		}
		private function setupTextFields():void
		{
			//Set the text format object
			_format.font = "Helvetica";
			_format.size = 44;
			_format.color = 0x000000;
			_format.align = TextFormatAlign.CENTER;
			
			//Configure the fairy's score  text field	
			_fairyScoreDisplay.defaultTextFormat = _format;
			_fairyScoreDisplay.autoSize = TextFieldAutoSize.CENTER;
			_fairyScoreDisplay.border = false;
			_fairyScoreDisplay.text = "0";
			
			//Display and position the fairy's score text field
			stage.addChild(_fairyScoreDisplay);
			_fairyScoreDisplay.x = 180;
			_fairyScoreDisplay.y = 21;
			
			//Configure the bee's score  text field	
			_beeScoreDisplay.defaultTextFormat = _format;
			_beeScoreDisplay.autoSize = TextFieldAutoSize.CENTER;
			_beeScoreDisplay.border = false;
			_beeScoreDisplay.text = "0";
			
			//Display and position the bee's score text field
			stage.addChild(_beeScoreDisplay);
			_beeScoreDisplay.x = 550;
			_beeScoreDisplay.y = 21;
		}
		private function enterFrameHandler(event:Event):void
		{			
			moveFairy();
			moveBee();
			moveStars();
			moveBullets();
		}
		private function moveBullets():void
		{
			//Move the bullets
			for(var i:int = 0; i < _bullets.length; i++)
			{
				var bullet:GameObject = _bullets[i];
				bullet.x += bullet.vx;
				bullet.y += bullet.vy;
				
				//check the bullet's stage boundaries
				if (bullet.y < 0
					|| bullet.x < 0
					|| bullet.x > stage.stageWidth
					|| bullet.y > stage.stageHeight)
				{
					//Remove the bullet from the stage
					stage.removeChild(bullet);
					bullet = null;
					_bullets.splice(i,1);
					i--;
				}
				//Check for a collision with the fairy
				if(bullet != null
					&& bullet.hitTestObject(_fairy))
				{
					//Update the score, the score display 
					//and remove the bullet 
					_beeScore++;
					_beeScoreDisplay.text = String(_beeScore);
					stage.removeChild(bullet);
					bullet = null;
					_bullets.splice(i,1);
					i--;
				}
			}
		}
		private function moveStars():void
		{
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
					star = null;
					_stars.splice(i,1);
					i--;
				}
				//Check for a collision with the bee
				if(star != null
					&& star.hitTestObject(_bee))
				{
					//Update the score, the score display 
					//and remove the bullet 
					_fairyScore++;
					_fairyScoreDisplay.text = String(_fairyScore);
					stage.removeChild(star);
					star = null;
					_stars.splice(i,1);
					i--;
				}
			}		
		}
		private function moveBee():void
		{
			//Get the target object
			var target_X:Number = _fairy.x;
			var target_Y:Number = _fairy.y;
			
			//Calculate the distance between the target and the bee
			var vx:Number = target_X - _bee.x;
			var vy:Number = target_Y - _bee.y;
			
			var distance:Number = Math.sqrt(vx * vx + vy * vy);
			if (distance <= RANGE)
			{
				//Find out how much to move
				var move_X:Number = TURN_SPEED * vx / distance;
				var move_Y:Number = TURN_SPEED * vy / distance;
				
				//Increase the bee's velocity 
				_bee.vx += move_X; 
				_bee.vy += move_Y;
				
				//Find the total distance to move
				var moveDistance:Number = Math.sqrt(_bee.vx * _bee.vx + _bee.vy * _bee.vy);
				
				//Apply easing
				_bee.vx = SPEED * _bee.vx / moveDistance;
				_bee.vy = SPEED * _bee.vy / moveDistance;
				
				//Rotate towards the bee towards the target
				//Find the angle in radians
				_beeAngle = Math.atan2(_bee.vy, _bee.vx);
				
				//Convert the radians to degrees to rotate
				//the bee corectly
				_bee.rotation = _beeAngle * 180 / Math.PI + 90;
				
				//Start the bullet timer
				_bulletTimer.start();
				
			}
			else
			{
				_bulletTimer.stop();
			}
			
			//Apply friction 
			_bee.vx *= FRICTION;
			_bee.vy *= FRICTION;
			
			//Move the bee
			_bee.x += _bee.vx;
			_bee.y += _bee.vy;
		}
		private function moveFairy():void
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
		}
		
		//Let the bee fire bullets using a timer
		private function bulletTimerHandler(event:TimerEvent):void
		{
			//Create a bullet and add it to the stage
			var bulletImage:DisplayObject = new BulletImage();
			var bullet:GameObject = new GameObject(bulletImage);
			stage.addChild(bullet);
			
			//Set the bullet's starting position
			var radius:int = 30; 
			bullet.x = _bee.x + (radius * Math.cos(_beeAngle));
			bullet.y = _bee.y + (radius * Math.sin(_beeAngle));
			
			//Set the bullet's velocity based
			//on the angle 
			bullet.vx = Math.cos(_beeAngle) * 5 + _bee.vx;
			bullet.vy = Math.sin(_beeAngle) * 5 + _bee.vy;
			
			//Push the bullet into the _bullets array
			_bullets.push(bullet);
			
			//Find a random start time for the next bullet
			var randomFireTime:Number = Math.round(Math.random() * 1000) + 200;
			_bulletTimer.delay = randomFireTime;
		}
		
		//Let Button Fairy fire stars when the mouse is clicked
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