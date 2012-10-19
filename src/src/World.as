package src 
{
	import flash.display.BitmapData;
	import flash.display.GraphicsSolidFill;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class World extends EventDispatcher
	{
		protected var space:BitmapData
		protected var rules:Vector.<Rule> = new Vector.<Rule>();
		protected var timer:Timer;
		
		protected var height:int;
		protected var width:int;
		
		public function World(w:int, h:int) 
		{
			this.width = w;
			this.height = h;
		}
		
		protected function tick(te:TimerEvent):void
		{
			var next:BitmapData = new BitmapData(space.width, space.height);
			for (var i:int = 0; i < space.width; ++i) 
			{
				for (var k:int = 0; k < space.height; ++i)
				{
					var result:uint = 0;
					for (var rule:Rule in rules)
					{
						result = rule.apply(this, i, k);
						next.setPixel(result);
					}
				}
			}
		}
		
		public function start():void 
		{
			if (timer != null) timer.stop();
			
			if(space != null) space.dispose();
			space = new BitmapData(this.width, this.height, true, getDeathValue());
			
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
		}
		
		public function stop():void
		{
			if (timer != null) timer.stop();
		}
		
		public function getValueAt(x:int, y:int):uint
		{
			return space.getPixel(x, y);
		}
		
		public function setValueAt(x:int, y:int, value:uint):void
		{
			space.setPixel(x, y, value);
		}
		
		public function addRule(rule:Rule):void
		{
			if(this.rules.indexOf(rule) < 0)
			{
				this.rules.push(rule);
			}
		}
		
		public function removeRule(rule:Rule):void
		{
			var index:int = this.rules.indexOf(rule);
			
			if(index >= 0)
			{
				this.rules.splice(index, 1);
			}
		}
		
		protected function getWidth():int { return this.width; }
		protected function getHeight():int { return this.height; }
		
		public function getDeathValue():uint 
		{
			return 0xffffff;
		}
		
		public function getLifeValue():uint {
			return 0x0;
		}
		
		public function getNeighbors(
	}

}