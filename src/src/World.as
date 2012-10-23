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
		
		protected var currentNeighbors:Neighborhood = new Neighborhood();
		protected var changeQue:Vector.<FutureSpaceChange> = new Vector.<FutureSpaceChange>();
		
		public function World(w:int, h:int)
		{
			this.width = w;
			this.height = h;
		}
		
		protected function tick(te:TimerEvent):void
		{
			if (rules.length == 0)
				return;
			shape.graphics.clear();
			
			for (var i:int = 0; i < width; ++i)
			{
				for (var k:int = 0; k < height; ++k)
				{
					loadNeighborsIntoCurrent(i, k);
					applyRules(currentNeighbors);
					
					drawValueAt(i, k);
				}
			}
		
			shuffleQue();
			shiftChangeQue(250);
		}
		
		protected function shiftChangeQue(num:int):void
		{
			if (num == 0) return;
			
			if (changeQue.length > 0)
			{
				var change:FutureSpaceChange = changeQue.shift();
				setValueAt(change.column, change.row, change.state);
			}
			
			shiftChangeQue(num - 1);
		}
		
		protected function applyRules(neighbors:Neighborhood):Boolean
		{
			for each (var rule:Rule in rules)
			{
				if (rule.matches(this, neighbors))
				{
					var newState:int = rule.apply(this, neighbors);
					changeQue.push(new FutureSpaceChange(neighbors.centerColumn, 
					                                     neighbors.centerRow, 
														 newState));
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
		
		protected function init():void
		{
			for (var i:int = 0; i < width; ++i)
			{
				space.push(new Vector.<Space>());
				for (var j:int = 0; j < height; ++j)
				{
					space[i].push(new Space(i, j, Space.DEAD));
				}
			}
		}
		
		public function start(generator:Generator):void
		{
			if (timer != null)
				timer.stop();
			
			space = new Vector.<Vector.<Space>>();
			shape.graphics.clear();
			init();
			
			generator.generate(this);
			for (var i:int = 0; i < width; ++i)
			{
				for (var j:int = 0; j < height; ++j)
				{
					drawValueAt(i, j);
				}
			}
			
			timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
		}
		
		public function stop():void
		{
			if (timer != null)
				timer.stop();
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
			if (this.rules.indexOf(rule) < 0)
			{
				this.rules.push(rule);
			}
		}
		
		public function removeRule(rule:Rule):void
		{
			var index:int = this.rules.indexOf(rule);
			
			if (index >= 0)
			{
				this.rules.splice(index, 1);
			}
		}
		
		public function getWidth():int
		{
			return this.width;
		}
		
		public function getHeight():int
		{
			return this.height;
		}
		
		public function getDeathColor():uint
		{
			return this.deathValue;
		}
		
		public function getLifeColor():uint
		{
			return this.lifeValue;
		}
		
		public function loadNeighborsIntoCurrent(x:int, y:int):void
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
			
			currentNeighbors.from(this, result);
		}
		
		public function getDisplayObject():Shape
		{
			return shape;
		}
		
		protected function shuffleQue():void
		{
			var count:int = shuffleQue.length;
			var index:int, temp:FutureSpaceChange;
			
			while (count > 0) 
			{
				index = Math.floor(Math.random() * count--);
				temp = changeQue[count];
				changeQue[count] = changeQue[index];
				changeQue[index] = temp;
			}
		}
	}
}

class FutureSpaceChange
{
	public var column:int;
	public var row:int;
	public var state:int;
	
	public function FutureSpaceChange(column:int, row:int, state:int)
	{
		this.column = column;
		this.row = row;
		this.state = state;
	}
}