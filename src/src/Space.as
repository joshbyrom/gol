package src 
{
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Space 
	{
		public static var DEAD:int = 0;
		public static var ALIVE:int = 1;
		public static var SURVIVING:int = 2;
		
		protected var state:int = DEAD;
		protected var column:int = 0;
		protected var row:int = 0;
		public function Space(column:int, row:int, state:int) 
		{
			this.column = column;
			this.row = row;
			this.state = state;
		}
		
		protected function onDeath():void
		{
			
		}
		
		protected function onBirth():void
		{
			
		}
		
		protected function onSurvive():void
		{
			
		}
		
		protected function onUnknown():void
		{
			trace("entering unknown state");
		}
		
		public function setState(state:int):void
		{
			if (state != this.state)
			{
				this.state = state;
				if (state == DEAD)
				{
					onDeath();
				} 
				else if (state == ALIVE)
				{
					onBirth();
				}
				else if (state == SURVIVING)
				{
					onSurvive();
				}
				else
				{
					onUnknown();
				}
			}
		}
		
		public function getState():int
		{
			return this.state;
		}
		
		public function isAlive():Boolean
		{
			return this.state == ALIVE || this.state == SURVIVING;
		}
		
		public function isDead():Boolean
		{
			return this.state == DEAD;
		}
		
		public function isSurviving():Boolean
		{
			return this.state == SURVIVING;
		}
		
		public function getColumn():int
		{
			return this.column;
		}
		
		public function getRow():int
		{
			return this.row;
		}
	}

}