package 
{
	import fr.kouma.starling.utils.Stats;
	import isohill.GridDisplay;
	import isohill.IsoHill;
	import isohill.plugins.IsoCamera;
	import isohill.utils.Point3Input;
	import isohill.IsoSprite;
	import isohill.IsoMovieClip;
	import isohill.Point3;
	import isohill.loaders.SpriteSheetLoader;
	import isohill.AssetManager;
	
    import starling.display.Sprite;
    import starling.utils.AssetManager;
	import starling.display.Button;
	import starling.events.Event;
	
	import flash.geom.Rectangle;
	
    public class Root extends Sprite
    {
        private static var sAssets:starling.utils.AssetManager;
        public var isoHill:IsoHill;
		
        public function Root()
        {
            //
        }
		
		 public function start(assets:starling.utils.AssetManager):void
        {
            sAssets = assets;
			init_myassets();	
			setup();
			
        }
        
		private function init_myassets():void {
			var areas:Vector.<Rectangle>= new <Rectangle>[];
			for (var y:int = 0; y < 128; y += 64) {
				for (var x:int = 0; x < 256; x += 64) {
					var rect:Rectangle = new Rectangle(x, y, 64, 64);
					areas.push(rect);
				}
			}
            var loader:SpriteSheetLoader = new SpriteSheetLoader("../assets/64x64.png", areas);
			isohill.AssetManager.instance.addLoader(loader);
			
			areas= new <Rectangle>[];
			for (y = 0; y < 32; y += 32) {
				for (x = 0; x < 64; x += 64) {
					rect = new Rectangle(x, y, 64, 32);
					areas.push(rect);
				}
			}
            loader = new SpriteSheetLoader("../assets/grass.png", areas);
			isohill.AssetManager.instance.addLoader(loader);
			
			areas= new <Rectangle>[];
			for (y = 0; y < 128; y += 128) {
				for (x = 0; x < 128; x += 64) {
					rect = new Rectangle(x, y, 64, 128);
					areas.push(rect);
				}
			}
            loader = new SpriteSheetLoader("../assets/64x128.png", areas);
			isohill.AssetManager.instance.addLoader(loader);
			
			areas= new <Rectangle>[];
			for (y = 0; y < 192; y += 192) {
				for (x = 0; x < 384; x += 192) {
					rect = new Rectangle(x, y, 192, 192);
					areas.push(rect);
				}
			}
            loader = new SpriteSheetLoader("../assets/192x192.png", areas);
			isohill.AssetManager.instance.addLoader(loader);
		}
		
		private function setup():void {

			isoHill = new IsoHill(); // instance that engine
			addChild(isoHill); // add the engine to starling
			
			var gridArr:Array = new Array();
			var grid:GridDisplay = new GridDisplay("layer1", 10, 10, 64, 32, "isometric");
			for (var x:int = 0; x < 10; x++) {
				gridArr[x] = new Array();
				for (var y:int = 0; y < 10; y++) {
					var pt3:Point3 = grid.toLayerPt(x, y);
					var sprite:IsoMovieClip = new IsoMovieClip("../assets/grass.png", "sprite1", pt3);
					grid.add(sprite);
					gridArr[x][y] = 0;
				}
			}
			
			for (var i:int = 0; i < 20; i++) {
				addHouse(grid,gridArr);
			}
			
			isoHill.addLayer(0, grid);
			isoHill.addPlugin(new IsoCamera(new Point3Input(stage, 0, 70)));
			isoHill.start(); // start all the runtime logic
			addChild(new Stats()); // Mrdoob's performance monitor
			
			var button:Button = new Button(sAssets.getTexture("button_square"), "+");
			button.x = 100;
            button.y = 10;
			addChild(button);
			button.addEventListener(Event.TRIGGERED, function():void {
				sAssets.playSound("click");
				addHouse(grid,gridArr);
			});
			
		}
		
		
		private function addHouse(grid:GridDisplay,gridArr:Array):void
        {
			var x:int;
			var y:int;
			if (len(gridArr) == 100)
			{
				trace("sd");
			}
			else
			{
				while(len(gridArr)<=100){
						x = int(Math.random() * 10);
						y = int(Math.random() * 10);
						if (gridArr[x][y] == 0) {
							gridArr[x][y] = 1;
							break;
							}
						else {
							x = int(Math.random() * 10);
							y = int(Math.random() * 10);
						}
					}
					var pt3:Point3 = grid.toLayerPt(x, y);
					grid.add(rand_house(pt3));
					
			}
		}
       
		private function len(arr:Array):int {
			var k:int = 0;
			for (var i:int = 0; i < arr.length; i++)
				for (var j:int = 0; j < arr[i].length; j++)
					if (arr[i][j] == 1) k++;
			return k;
			
		}
		
		private function rand_house(pt3:Point3):IsoMovieClip {
			var k:int = Math.random() * 2 + 1;
			var skin:int;
			var sprite:IsoMovieClip;
			switch(k) {
				case 1: 
					skin = int(Math.random() * 7);
					sprite = new IsoMovieClip("../assets/64x64.png", "sprite1", pt3);
					sprite.currentFrame = skin;
					break;
				case 2:
					skin = Math.round(Math.random());
					sprite = new IsoMovieClip("../assets/64x128.png", "sprite1", pt3);
					sprite.currentFrame = skin;
					break;
				case 3:
					skin = Math.round(Math.random());
					sprite = new IsoMovieClip("../assets/192x192.png", "sprite1", pt3);
					sprite.currentFrame = skin;
					break;
			}
			return sprite;
		}
		
    }
}