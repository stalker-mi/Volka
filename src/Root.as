package 
{
	import flash.geom.Point;
	
	import fr.kouma.starling.utils.Stats;
	import isohill.GridDisplay;
	import isohill.IsoHill;
	import isohill.plugins.IsoCamera;
	import isohill.utils.Point3Input;
	import isohill.IsoSprite;
	import isohill.IsoMovieClip;
	import isohill.Point3;
	
    import starling.display.Sprite;
    import starling.utils.AssetManager;
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.display.MovieClip;
	
    public class Root extends Sprite
    {
		private var isoHill:IsoHill;
        private static var sAssets:AssetManager;
        private var gridArr:Array;
		private var grid:GridDisplay;
		private var txt:TextField;
		
        public function Root()
        {
            //
        }
		
		 public function start(assets:AssetManager):void
        {
            sAssets = assets;
			var myAsset:myAssets = new myAssets();	
			isoHill = new IsoHill(); // instance that engine
			addChild(isoHill); // add the engine to starling
			init_buttons();
			init_grid();
			init_houses();
			isoHill.addLayer(0, grid);
			isoHill.addPlugin(new IsoCamera(new Point3Input(stage, 0, 70)));
			isoHill.start(); // start all the runtime logic
			addChild(new Stats()); // Mrdoob's performance monitor
        }
		
		private function init_grid():void {
			gridArr = new Array();
			grid = new GridDisplay("layer1", 10, 10, 64, 32, "isometric");
			for (var x:int = 0; x < 10; x++) {
				gridArr[x] = new Array();
				for (var y:int = 0; y < 10; y++) {
					var pt3:Point3 = grid.toLayerPt(x, y);
					var sprite:IsoMovieClip = new IsoMovieClip(myAssets.ASSETS_GRASS, "sprite_grass", pt3);
					grid.add(sprite);
					gridArr[x][y] = 0;
				}
			}
		}
		
		private function init_houses():void {
			for (var i:int = 0; i < 20; i++) {
				addHouse();
			}
		}
			
		private function init_buttons()	:void {
			
			txt = new TextField(60, 90, "Количество домов:\n", "Verdana", 8,0xffffff);
			txt.y=10;
			txt.x = 80;
			txt.vAlign = "top";
			addChild(txt);
			
			var button:Button = new Button(sAssets.getTexture("button_square"), "+");
			button.x = 150;
            button.y = 10;
			addChild(button);
			button.addEventListener(Event.TRIGGERED, function():void {
				sAssets.playSound("click");
				addHouse();
			});
			
			button = new Button(sAssets.getTexture("button_square"), "-");
			button.x = 230;
            button.y = 10;
			addChild(button);
			button.addEventListener(Event.TRIGGERED, function():void {
				sAssets.playSound("click");
				removeHouse();
			});
		}
		
		
		private function addHouse():void
        {
			var x:int;
			var y:int;
			if (len(gridArr) == 100)
			{
				txt.text = "Количество домов:\n" + len(gridArr).toString()+"\nПоле заполненно";
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
					var house:myHouse = new myHouse(isoHill,grid);
					house.addSprite(x, y);
					addChild(house);
					house.addEventListener(myHouse.GRID_ARR, onGridArr);
			}
		}
		
		private function removeHouse():void
        {
			var x:int;
			var y:int;
			if (len(gridArr) == 0)
			{
				txt.text = "Количество домов:\n" + len(gridArr).toString()+"\nПоле пустое";
			}
			else
			{
				while (len(gridArr) >= 0) {
					x = int(Math.random() * 10);
					y = int(Math.random() * 10);
					if (gridArr[x][y] == 1) {
							gridArr[x][y] = 0;
							break;
							}
						else {
							x = int(Math.random() * 10);
							y = int(Math.random() * 10);
						}
				}
				
				
			}
		}
		
		private function dust(x:int, y:int):void {
			var frames:Vector.<Texture> = sAssets.getTextures("dust1x1_2");
			var mMovie:MovieClip = new MovieClip(frames, 23);
			mMovie.x = x-20;
			mMovie.y = y+20;
			addChild(mMovie);
			isoHill.juggler.add(mMovie);
			mMovie.addEventListener(Event.COMPLETE, function():void {
				isoHill.juggler.remove(mMovie);
				removeChild(mMovie);
			});
		}
       
		private function len(arr:Array):int {
			var k:int = 0;
			for (var i:int = 0; i < arr.length; i++)
				for (var j:int = 0; j < arr[i].length; j++)
					if (arr[i][j] == 1) k++;
			return k;
			
		}
		
		private function onGridArr(event:Event,data:Point):void {
			gridArr[data.x][data.y]= 0;
		}
		
		public static function get assets():AssetManager { return sAssets; }
		
    }
}