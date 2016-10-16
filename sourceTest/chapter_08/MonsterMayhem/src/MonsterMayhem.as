package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]	
	
	public class MonsterMayhem extends Sprite
	{	
		private var _levelOne:LevelOne;
		private var _levelTwo:LevelTwo;
		
		public function MonsterMayhem()
		{
			_levelOne = new LevelOne(stage);
			_levelTwo = new LevelTwo(stage);
			stage.addChild(_levelOne);
			
			stage.addEventListener("levelOneComplete", switchLevelHandler);
		}
		private function switchLevelHandler(event:Event):void	
		{
			trace("Hello from the application class! Switch levels!");
			stage.removeChild(_levelOne);
			_levelOne = null;
			stage.addChild(_levelTwo);
			
			if(_levelOne == null)
			{
			  trace("Level One is null");
			}
		}
	}
}