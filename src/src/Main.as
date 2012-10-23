package src
{
	import flash.display.Sprite;
	import flash.events.Event;
	import src.rules.Birth;
	import src.rules.Mortality;
	import src.rules.Survival;
	
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
			var generator:Generator = new Generator(0.06);
			addChild(world.getDisplayObject());
			
			world.addRule(new Birth());
			world.addRule(new Survival());
			world.addRule(new Mortality());
			world.start(generator);
		}
		
	}
	
}