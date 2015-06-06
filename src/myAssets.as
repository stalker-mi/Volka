package
{
    import flash.geom.Rectangle;
    
	import isohill.loaders.SpriteSheetLoader;
	import isohill.AssetManager;
	
    /** The Menu shows the logo of the game and a start button that will, once triggered, 
     *  start the actual game. In a real game, it will probably contain several buttons and
     *  link to several screens (e.g. a settings screen or the credits). If your menu contains
     *  a lot of logic, you could use the "Feathers" library to make your life easier. */
    public class myAssets
    {
        public static const ASSETS_64:String = "../assets/64x64.png";
		public static const ASSETS_128:String = "../assets/64x128.png";
		public static const ASSETS_192:String = "../assets/192x192.png";
		public static const ASSETS_GRASS:String = "../assets/grass.png";
		
        private var areas:Vector.<Rectangle>;
		private var loader:SpriteSheetLoader;
		private var y:int;
		private var x:int;
		private var rect:Rectangle;
		
        public function myAssets()
        {
            init();
        }
        
        private function init():void
        {
			init64();
			init128();
			init192();
			initGrass();
        }
        
		private function init64():void
        {
			areas= new <Rectangle>[];
			for (y = 0; y < 128; y += 64) {
				for (x = 0; x < 256; x += 64) {
					rect = new Rectangle(x, y, 64, 64);
					areas.push(rect);
				}
			}
            var loader:SpriteSheetLoader = new SpriteSheetLoader(ASSETS_64, areas);
			AssetManager.instance.addLoader(loader);
		}
		
		private function init128():void
        {
			areas= new <Rectangle>[];
			for (y = 0; y < 128; y += 128) {
				for (x = 0; x < 128; x += 64) {
					rect = new Rectangle(x, y, 64, 128);
					areas.push(rect);
				}
			}
            loader = new SpriteSheetLoader(ASSETS_128, areas);
			AssetManager.instance.addLoader(loader);
		}
		
		private function init192():void
        {
			areas= new <Rectangle>[];
			for (y = 0; y < 192; y += 192) {
				for (x = 0; x < 384; x += 192) {
					rect = new Rectangle(x, y, 192, 192);
					areas.push(rect);
				}
			}
            loader = new SpriteSheetLoader(ASSETS_192, areas);
			AssetManager.instance.addLoader(loader);
		}
		
		private function initGrass():void
        {
			areas= new <Rectangle>[];
			for (y = 0; y < 32; y += 32) {
				for (x = 0; x < 64; x += 64) {
					rect = new Rectangle(x, y, 64, 32);
					areas.push(rect);
				}
			}
            loader = new SpriteSheetLoader(ASSETS_GRASS, areas);
			AssetManager.instance.addLoader(loader);
		}
       
    }
}