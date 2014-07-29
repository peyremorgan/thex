package fr.manashield.flex.thex.events 
{
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	
	public class ThexEventDispatcher extends EventDispatcher
	{
		private static var _instance:ThexEventDispatcher;
	
		public function ThexEventDispatcher()
		{
			if(_instance)
			{
				throw new IllegalOperationError("Instantiation policy violation");
			}
		}
		
		public static function get instance():ThexEventDispatcher
		{
			return _instance?_instance:_instance=new ThexEventDispatcher();
		}
		
	}
}
