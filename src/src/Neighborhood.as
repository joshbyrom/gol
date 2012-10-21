package src 
{
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Neighborhood 
	{
		public var topLeft:uint, topCenter:uint, topRight:uint;
		public var middleLeft:uint, middleCenter:uint, middleRight:uint;
		public var bottomLeft:uint, bottomCenter:uint, bottomRight:uint;
		
		public var centerIsAlive:Boolean = false;
		public var numberDead:uint = 0;
		public var numberAlive:uint = 0;
		public function Neighborhood(world:World, values:Vector.<uint>) 
		{			
			var value:uint = 0;
			for (var i:int = 0; i < values.length; ++i )
			{
				value = values[i];
				
				if (i == 4) 
				{
					centerIsAlive = (value == world.getLifeValue());
					continue;
				}
				else if (value == world.getDeathValue())
				{
					numberDead += 1;
				}
				else if (value == world.getLifeValue())
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