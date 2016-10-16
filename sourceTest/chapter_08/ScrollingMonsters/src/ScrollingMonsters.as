package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="550", height="400", 
    backgroundColor="#FFFFFF", frameRate="60")]	
	
	public class ScrollingMonsters extends Sprite
	{	
		private var _scrollingLevel:ScrollingLevel;
		
		public function ScrollingMonsters()
		{
			_scrollingLevel = new ScrollingLevel(stage);
			stage.addChild(_scrollingLevel);	
		}
	}
}