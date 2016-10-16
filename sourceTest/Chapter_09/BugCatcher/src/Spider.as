package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Spider extends Sprite
	{
		//Embed the spider image
		[Embed(source="../images/spider.png")]
		private var SpiderImage:Class;
		private var _spiderImage:DisplayObject = new SpiderImage();
		private var _spider:Sprite = new Sprite();
		
		public function Spider()
		{
			_spider.addChild(_spiderImage);
			this.addChild(_spider);
		}
	}
}