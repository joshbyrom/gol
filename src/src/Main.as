package src
{
	import flash.display.Sprite;
	import flash.events.Event;
	
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
			
			var world:World = new World(stage.stageWidth, stage.stageHeight);
			var generator:Generator = new Generator(0.01);
			
			addChild(world.getDisplayObject());
			world.start(generator);
		}
		
	}
	
}