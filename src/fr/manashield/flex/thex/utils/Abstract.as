package fr.manashield.flex.thex.utils
{
	import flash.errors.IllegalOperationError;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Abstract 
	{
		public function Abstract():void
		{
			if(this.isAbstract()) throw new IllegalOperationError("Can't instantiate abstract class ");
		}
		
		public function isAbstract():Boolean
		{
			return true;
		}
	}
}
