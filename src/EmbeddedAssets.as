package
{
    public class EmbeddedAssets
    {
        /** ATTENTION: Naming conventions!
         *  
         *  - Classes for embedded IMAGES should have the exact same name as the file,
         *    without extension. This is required so that references from XMLs (atlas, bitmap font)
         *    won't break.
         *    
         *  - Atlas and Font XML files can have an arbitrary name, since they are never
         *    referenced by file name.
         * 
         */
        
        // Texture Atlas
        [Embed(source="../assets/atlas.xml", mimeType="application/octet-stream")]
        public static const atlas_xml:Class;
        
        [Embed(source="../assets/atlas.png")]
        public static const atlas:Class;
        // Bitmap textures
		
        [Embed(source="../assets/background.jpg")]
        public static const background:Class;
            
        // Sounds
        
        [Embed(source="../assets/click.mp3")]
        public static const click:Class;

    }
}