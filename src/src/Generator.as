package src 
{
	/**
	 * ...
	 * @author Josh Byrom
	 */
	public class Generator 
	{
		protected var changeForLife:Number;
		public function Generator(chanceForLife:Number)		// expects number between 0 and 1
		{
			this.changeForLife = chanceForLife; // by default life is random
		}
		
		public function generate(world:World):void 
		{
			for (var x:int = 0; x < world.getWidth(); ++x)
			{
				for (var y:int = 0; y < world.getHeight(); ++y)
				{
					if (Math.random() < this.changeForLife)
					{
						world.setValueAt(x, y, Space.ALIVE);
					}
				}
			}
		}
		
	}

}