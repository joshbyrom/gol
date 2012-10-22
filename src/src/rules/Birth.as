package src.rules 
{
	import src.Neighborhood;
	import src.Rule;
	import src.World;
	
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Birth extends Rule 
	{
		
		override public function apply(world:World, neighbors:Neighborhood):uint 
		{
			if (neighbors.centerIsAlive == false && neighbors.numberAlive == 3)
			{
				return world.getLifeValue();
			}
			else 
			{
				return super.apply(world, neighbors);
			}
		}
		
	}

}