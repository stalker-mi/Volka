package 
{
	import fr.kouma.starling.utils.Stats;
	import isohill.GridDisplay;
	import isohill.IsoHill;
	import isohill.plugins.IsoCamera;
	import isohill.utils.Point3Input;
	import isohill.tmx.TMX;
	import isohill.tmx.TMXPlugin;
	import isohill.tmx.TMXLayer;
	
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.utils.AssetManager;

    public class Root extends Sprite
    {
        private static var sAssets:AssetManager;
        public var isoHill:IsoHill;
        private var tmx:TMX;
		
        public function Root()
        {
            //
        }
		
		 public function start(assets:AssetManager):void
        {
            sAssets = assets;
            
			TMX.loadTMX("../assets/", "my.tmx", onTMXLoad);
			//TMX.loadTMX("../assets/", "nature_big.tmx", onTMXLoad);
			//addChild(new Image(assets.getTexture("background")));
            //showScene(Menu);
        }
        
		private function onTMXLoad(tmx:TMX):void {
			this.tmx = tmx;
			setup();
		}
		
		private function setup():void {
			isoHill = new IsoHill(); // instance that engine
			addChild(isoHill); // add the engine to starling
			addPlugins(isoHill);
			isoHill.start(); // start all the runtime logic
			addChild(new Stats()); // Mrdoob's performance monitor
		}
       
		
		private function addPlugins(isoHill:IsoHill):void {
			var tmxPlugin:TMXPlugin = new TMXPlugin(tmx);
			for (var i:int = 0; i < tmx.layersArray.length; i++) {
				var layer:TMXLayer = tmx.layersArray[i];
				var layerName:String = layer.name;
				var grid:GridDisplay = tmxPlugin.makeEmptyGridOfSize(i, layerName);
				if (layerName.indexOf("earth") != -1) grid.flatten(); // disable sorting and flatten the ground as it is not dynamic (speed improvement)
				isoHill.addLayer(i, grid); // add the layer to the engine
			}
			isoHill.addPlugin(tmxPlugin);
			isoHill.addPlugin(new IsoCamera(new Point3Input(stage, 0, 450)));
		}
        
		/*
		private function onStartGame(event:Event, gameMode:String):void
        {
            trace("Game starts! Mode: " + gameMode);
           // showScene(Game);
        }
		
       private function showScene(screen:Class):void
        {
            if (mActiveScene) mActiveScene.removeFromParent(true);
            mActiveScene = new screen();
            addChild(mActiveScene);
        }
        public static function get assets():AssetManager { return sAssets; }
		*/
    }
}