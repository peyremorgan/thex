package fr.manashield.flex.thex 
{
	import flash.errors.IllegalOperationError;

	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class UnsupportedOperationError extends IllegalOperationError 
	{
		public function UnsupportedOperationError() : void 
		{
			super("Unsupported operation");
		}
	}
}
