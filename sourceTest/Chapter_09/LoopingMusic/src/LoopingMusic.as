package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	//Classes needed to play sounds
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]
	
	public class LoopingMusic extends Sprite
	{
		//Embed the sound
		[Embed(source="../sounds/music.mp3")] 
		private var Music:Class;
		
		//Create the Sound and Sound channel 
		//objects for the sound
		private var _music:Sound = new Music(); 
		private var _musicChannel:SoundChannel = new SoundChannel();
		
		//Variables needed to set volume and panning
		private var _volume:Number = 1; 
		private var _pan:Number = 0;
		
		public function LoopingMusic()
		{
			_musicChannel = _music.play(30, int.MAX_VALUE);
			
			//Change the volume and pan settings
			_volume = 0.5;
			_pan = 0;
			
			//Create the SoundTransform object
			var transform:SoundTransform
			  = new SoundTransform(_volume, _pan);
			  
			//Add the SoundTransform object to the 
			//musicChannel's soundTransform property 
			_musicChannel.soundTransform = transform; 
			
		}
	}
}