package fr.manashield.flex.thex.utils {
	/**
	 * @author Morgan Peyre (morgan@peyre.info)
	 * @author Paul Bonnet
	 */
    import flash.text.Font;
    
    public class EmbedFonts
    {
        [Embed(source='/../lib/fonts/score.ttf',fontName='score',fontWeight="normal",embedAsCFF=false)]
        private static var SCORE:Class;
		
		[Embed(source='/../lib/fonts/gameOver.ttf',fontName='gameOver',fontWeight="normal",embedAsCFF=false)]
        private static var GAME_OVER:Class;
		
        public static function init():void
        {
			Font.registerFont(SCORE);
			Font.registerFont(GAME_OVER);
		}
    }
}