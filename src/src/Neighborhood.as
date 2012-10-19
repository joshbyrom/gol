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
		
		public var numberDead:uint = 0;
		public var numberAlive:uint = 0;
		public function Neighborhood(world:World, values:Vector.<uint>) 
		{
			for (var value:uint in values)
			{
				if (value == world.getDeathValue())
					numberDead += 1;
				else if (value == world.getLifeValue())
					numberAlive += 1;
				else 
				{
					// unknown values
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
			bottomrRight = values[8];
		}
		
	}

}