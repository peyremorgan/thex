package fr.manashield.flex.thex.utils {
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
	public class Color 
	{
		public static const RED:Color = new Color(0xEF3038);
		public static const GREEN:Color = new Color(0x32CD32);
		public static const BLUE:Color = new Color(0x318CE7);
		public static const YELLOW:Color = new Color(0xFFE031);
		public static const MAGENTA:Color = new Color(0xDF00FF);
		public static const ORANGE:Color = new Color(0xFF9030);
		
		protected static const COLORS:Vector.<Color> = new <Color>[RED, GREEN, BLUE, YELLOW, MAGENTA, ORANGE];
		
		protected var _hexValue:uint;
		
		public function get hexValue():uint
		{
			return _hexValue;
		}
		
		public function Color(newHexValue:uint)
		{
			this._hexValue = newHexValue;
		}
		
		public static function get RANDOM():Color
		{	
			return COLORS[uint(Math.random()*COLORS.length)];
		}
	}
}
