package src
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
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
			
			createRestartButton(world, generator);
		}
		
		private function createRestartButton(world:World, generator:Generator):void
		{
			var restartFieldUp:TextField = new TextField();
			restartFieldUp.text = "restart";
			restartFieldUp.autoSize = TextFieldAutoSize.LEFT;
			restartFieldUp.setTextFormat(new TextFormat("Arial", 18, 0xffffff));
			restartFieldUp.mouseEnabled = false;
			restartFieldUp.x = 5;
			restartFieldUp.y = 5;
			
			var restartFieldDown:TextField = new TextField();
			restartFieldDown.text = "restart";
			restartFieldDown.autoSize = TextFieldAutoSize.LEFT;
			restartFieldDown.setTextFormat(new TextFormat("Arial", 18, 0x0));
			restartFieldDown.mouseEnabled = false;
			restartFieldDown.x = 5;
			restartFieldDown.y = 5;
			
			var upShape:Sprite = new Sprite();
			upShape.graphics.beginFill(0x0);
			upShape.graphics.lineStyle(1, 0xffffff);
			upShape.graphics.drawRect(0, 0, restartFieldUp.width + 10, restartFieldUp.height + 10);
			upShape.graphics.endFill();
			
			upShape.addChild(restartFieldUp);
			
			var downShape:Sprite = new Sprite();
			downShape.graphics.beginFill(0xffffff);
			downShape.graphics.lineStyle(1, 0x0);
			downShape.graphics.drawRect(0, 0, restartFieldDown.width + 10, restartFieldDown.height + 10);
			downShape.graphics.endFill();
			
			downShape.addChild(restartFieldDown);
			
			var centerUnder:DisplayObject = world.getDisplayObject();
			
			var restart:SimpleButton = new SimpleButton(upShape, upShape, downShape);
			restart.addEventListener(MouseEvent.CLICK, function(me:MouseEvent):void {
				world.stop();
				world.start(generator);
			});
			restart.useHandCursor = true;
			restart.hitTestState = upShape;
			
			restart.x = centerUnder.x + centerUnder.width * 0.5 - restart.width * 0.5;
			restart.y = centerUnder.y + centerUnder.height;
			
			addChild(restart);
		}
	}
	
}