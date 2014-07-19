package fr.manashield.flex.thex.utils {
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
    import flash.text.Font;
    
    public class EmbedFonts
    {
        [Embed(source='/../lib/fonts/Orgasmo.otf',fontName='Orgasmo',fontWeight="normal",embedAsCFF=false)]
        private static var ORGASMO:Class;
		
        public static function init():void
        {
			Font.registerFont(ORGASMO);
		}
    }
}