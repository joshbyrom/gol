package src.rules 
{
	import src.Rule;
	
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
				return world.getLiveValue();
			}
			else 
			{
				return super.apply(world, neighbors);
			}
		}
		
	}

}