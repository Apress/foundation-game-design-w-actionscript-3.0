package
{
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class Sounds
	{
		//Embed the sounds
		[Embed(source="../sounds/bounce.mp3")] 
		private var Bounce:Class;
		[Embed(source="../sounds/chirp.mp3")] 
		private var Chirp:Class;
		[Embed(source="../sounds/meow.mp3")] 
		private var Meow:Class;
		
		
		//Create the Sound and Sound channel objects
		//Bounce sound
		public var bounce:Sound = new Bounce(); 
		public var bounceChannel:SoundChannel = new SoundChannel();
		
		//Chirp sound
		public var chirp:Sound = new Chirp(); 
		public var chirpChannel:SoundChannel = new SoundChannel();
		
		//Meow sound
		public var meow:Sound = new Meow(); 
		public var meowChannel:SoundChannel = new SoundChannel();
		
		public function Sounds()
		{
		}
	}
}