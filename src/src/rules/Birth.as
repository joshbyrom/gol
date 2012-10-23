package src.rules 
{
	import src.Neighborhood;
	import src.Rule;
	import src.Space;
	import src.World;
	
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Birth extends Rule 
	{
		override public function matches(world:World, neighbors:Neighborhood):Boolean 
		{
			return (neighbors.centerIsAlive == false && neighbors.numberAlive == 3);
		}
		
		override public function apply(world:World, neighbors:Neighborhood):int 
		{
			return Space.ALIVE;
		}
		
	}

}