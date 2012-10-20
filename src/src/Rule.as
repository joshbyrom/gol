package src 
{
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Rule 
	{
		
		public function apply(world:World, neighborhood:Neighborhood):uint
		{
			return neighborhood.middleCenter;	// default is no changes
		}
		
	}

}