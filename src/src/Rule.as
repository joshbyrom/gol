package src 
{
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Rule 
	{
		
		public function apply(world:World, x:int, y:int):uint
		{
			return world.getValueAt(x, y);	// default is no changes
		}
		
	}

}