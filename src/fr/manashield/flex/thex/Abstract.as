package fr.manashield.flex.thex 
{
	import flash.errors.IllegalOperationError;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Abstract 
	{
		protected var isAbstract:Boolean = true;
		
		public function Abstract():void
		{
			if(this.isAbstract) throw new IllegalOperationError("Can't instantiate abstract class ");
		}
	}
}
