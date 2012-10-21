package src
{
	import flash.display.Sprite;
	import flash.events.Event;
	import src.rules.Death;
	
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var world:World = new World(100, 100);
			var generator:Generator = new Generator(0.03);
			addChild(world.getDisplayObject());
			
			world.addRule(new Death());
			world.start(generator);
		}
		
	}
	
}