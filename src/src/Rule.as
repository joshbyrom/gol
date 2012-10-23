package src 
{
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Rule 
	{
		
		public function apply(world:World, neighborhood:Neighborhood):int
		{
			return neighborhood.middleCenter.getState();	// default is no changes
		}
		
		public function matches(world:World, neighborhood:Neighborhood):Boolean
		{
			return false;
		}
		
	}

}