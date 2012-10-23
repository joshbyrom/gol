package src 
{
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Neighborhood 
	{
		public var topLeft:Space, topCenter:Space, topRight:Space;
		public var middleLeft:Space, middleCenter:Space, middleRight:Space;
		public var bottomLeft:Space, bottomCenter:Space, bottomRight:Space;
		
		public var centerIsAlive:Boolean = false;
		public var numberDead:uint = 0;
		public var numberAlive:uint = 0;
		public function Neighborhood(world:World, values:Vector.<Space>) 
		{			
			var value:Space = null;
			for (var i:int = 0; i < values.length; ++i )
			{
				value = values[i];
				
				if (i == 4) 
				{
					centerIsAlive = value.isAlive();
					continue;
				}
				else if (value.isDead())
				{
					numberDead += 1;
				}
				else if (value.isAlive())
				{
					numberAlive += 1;
				}
				else 
				{
					// unknown values
					trace(value);
				}
			}
			
			topLeft = values[0];
			middleLeft = values[1];
			bottomLeft = values[2];
			
			topCenter = values[3];
			middleCenter = values[4];
			bottomCenter = values[5];
			
			topRight = values[6];
			middleRight = values[7];
			bottomRight = values[8];
		}
		
	}

}