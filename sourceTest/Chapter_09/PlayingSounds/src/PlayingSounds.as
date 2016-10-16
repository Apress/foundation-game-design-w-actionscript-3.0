package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	//Classes needed to play sounds
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class PlayingSounds extends Sprite
	{
		//Embed the sound
		[Embed(source="../sounds/bounce.mp3")] 
		private var Bounce:Class;
		
		//Create the Sound and Sound channel 
		//objects for the sound
		private var _bounce:Sound = new Bounce(); 
		private var _bounceChannel:SoundChannel = new SoundChannel();
		
		public function PlayingSounds()
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);	
		}
		public function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.SPACE)
			{
				//Tell the bounce sound channel
				//to play the bounce sound
				_bounceChannel = _bounce.play();
			}
		}
	}
}