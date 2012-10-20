package src.rules 
{
	import src.Neighborhood;
	import src.Rule;
	import src.World;
	
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Death extends Rule 
	{
		
		override public function apply(world:World, neighbors:Neighborhood):uint 
		{
			// dies by under-population and over-crowding
			if (neighbors.centerIsAlive && neighbors.numberAlive != 2 && neighbors.numberAlive != 3)
			{
				trace(neighbors.numberAlive);
				return world.getDeathValue();
			}
			else 
			{
				return super.apply(world, neighbors);
			}
		}
		
	}

}