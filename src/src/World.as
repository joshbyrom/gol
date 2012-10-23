package src 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GraphicsSolidFill;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class World extends EventDispatcher
	{
		protected var shape:Shape = new Shape();
		protected var space:Vector.<Vector.<Space>>;
		protected var rules:Vector.<Rule> = new Vector.<Rule>();
		protected var timer:Timer;
		
		protected var height:int;
		protected var width:int;
		
		protected var deathValue:uint = 0x0;
		protected var lifeValue:uint = 0xffffff;
		
		public function World(w:int, h:int) 
		{
			this.width = w;
			this.height = h;
		}
		
		protected function tick(te:TimerEvent):void
		{
			if (rules.length == 0) return;
			shape.graphics.clear();
			
			var currentNeighbors:Neighborhood;
			for (var i:int = 0; i < width; ++i) 
			{
				for (var k:int = 0; k < height; ++k)
				{
					currentNeighbors = this.getNeighbors(i, k);
					applyRules(currentNeighbors);
					
					drawValueAt(i, k);
					
				}
			}
			
		}
		
		protected function applyRules(neighbors:Neighborhood):Boolean
		{
			for each(var rule:Rule in rules)
			{
				if (rule.matches(this, neighbors))
				{
					neighbors.middleCenter.setState(rule.apply(this, neighbors));
					return true;
				}
			}
			
			return false;
		}
		
		
		protected function drawValueAt(x:int, y:int):void
		{
			var space:Space = getValueAt(x, y);
			
			shape.graphics.beginFill(space.isAlive() ? getLifeColor() : getDeathColor());
			shape.graphics.drawRect(x * 4, y * 4, 4, 4);
			shape.graphics.endFill();
		}
		
		protected function init():void {
			for (var i:int = 0; i < width; ++i) {
				space.push(new Vector.<Space>());
				for (var j:int = 0; j < height; ++j) {
					space[i].push(new Space(i, j, Space.DEAD));
				}
			}
		}
		
		public function start(generator:Generator):void 
		{
			if (timer != null) timer.stop();
			
			space = new Vector.<Vector.<Space>>();
			shape.graphics.clear();
			init();
			
			generator.generate(this);
			for (var i:int = 0; i < width; ++i) {
				for (var j:int = 0; j < height; ++j) {
					drawValueAt(i, j);
				}
			}
			
			timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
		}
		
		public function stop():void
		{
			if (timer != null) timer.stop();
		}
		
		public function getValueAt(x:int, y:int):Space
		{
			return space[x][y];
		}
		
		public function setValueAt(x:int, y:int, value:int):void
		{
			space[x][y].setState(value);
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
		
		public function getWidth():int { return this.width; }
		public function getHeight():int { return this.height; }
		
		public function getDeathColor():uint 
		{
			return this.deathValue;
		}
		
		public function getLifeColor():uint {
			return this.lifeValue;
		}
		
		public function getNeighbors(x:int, y:int):Neighborhood
		{
			var result:Vector.<Space> = new Vector.<Space>();
			
			var startX:int = x - 1;
			var startY:int = y - 1;
			
			var endX:int = x + 1;
			var endY:int = y + 1;
			
			for (var i:int = startX; i <= endX; ++i) 
			{
				for (var k:int = startY; k <= endY; ++k)
				{
					result.push(getValueAt((i + width) % width, (k + height) % height));
				}
			}
			
			return new Neighborhood(this, result);
		}
		
		public function getDisplayObject():Shape
		{
			return shape;
		}
	}

}