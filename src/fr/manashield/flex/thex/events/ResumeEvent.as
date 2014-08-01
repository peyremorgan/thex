package fr.manashield.flex.thex.events {
	import flash.events.Event;
	/**
	 * @author Paul
	 */
	public class ResumeEvent extends Event
	{
		public static const RESUME:String = "resume";
			
		public function ResumeEvent(type:String = RESUME, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
