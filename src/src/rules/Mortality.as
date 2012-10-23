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
	public class Mortality extends Rule 
	{
		
		override public function matches(world:World, neighborhood:Neighborhood):Boolean 
		{
			return neighborhood.centerIsAlive && (neighborhood.numberAlive < 2 || neighborhood.numberAlive > 3);
		}
		
		override public function apply(world:World, neighborhood:Neighborhood):int 
		{
			return Space.DEAD;
		}
	}

}