package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]	
	
	public class IntelligentMonsters extends Sprite
	{	
		private var _intelligentLevel:IntelligentLevel;
		
		public function IntelligentMonsters()
		{
			_intelligentLevel = new IntelligentLevel(stage);
			stage.addChild(_intelligentLevel);	
		}
	}
}