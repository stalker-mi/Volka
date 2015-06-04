package
{
	import flash.display.Sprite;
	import flash.system.Capabilities;
	import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
	import flash.display.Bitmap;
	import flash.utils.setTimeout;
	import flash.utils.ByteArray;
	import flash.display.Loader;
	import flash.events.Event;
	
	import starling.core.Starling;
    import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.textures.RenderTexture;
	
	import utils.ProgressBar;
	/**
	 * ...
	 * @author Vovik
	 */
	[SWF(width="320", height="480", frameRate="60", backgroundColor="#222222")]
	public class Main extends Sprite 
	{
		private var mStarling:Starling;
		private var mBackground:Loader;
        private var mProgressBar:ProgressBar;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Object = null):void 
		{
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, init);
			// entry point
			Starling.multitouchEnabled = true; // for Multitouch Scene
            Starling.handleLostContext = true; // recommended everywhere when using AssetManager
            RenderTexture.optimizePersistentBuffers = true; // should be safe on Desktop

            mStarling = new Starling(Game, stage, null, null, "auto", "auto");
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
            {
                loadAssets(startGame);
            });
		}
		
		private function loadAssets(onComplete:Function):void
        {
			var appDir:File = File.applicationDirectory;
            var assets:AssetManager = new AssetManager();

            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(appDir.resolvePath("assets"));

            // Now, while the AssetManager now contains pointers to all the assets, it actually
            // has not loaded them yet. This happens in the "loadQueue" method; and since this
            // will take a while, we'll update the progress bar accordingly.

            assets.loadQueue(function(ratio:Number):void
            {
                mProgressBar.ratio = ratio;
                if (ratio == 1) onComplete(assets);
            });
        }
		
		private function startGame(assets:AssetManager):void
        {
            var game:Game = mStarling.root as Game;
            game.start(assets);
            setTimeout(removeElements, 150); // delay to make 100% sure there's no flickering.
        }
		private function initElements():void
        {
            // Add background image.
            var bgFile:File = File.applicationDirectory.resolvePath("background.jpg");
            var bytes:ByteArray = new ByteArray();
            var stream:FileStream = new FileStream();
            stream.open(bgFile, FileMode.READ);
            stream.readBytes(bytes, 0, stream.bytesAvailable);
            stream.close();

            mBackground = new Loader();
            mBackground.loadBytes(bytes);
            mStarling.nativeOverlay.addChild(mBackground);

            mBackground.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,
                function(e:Object):void
                {
                    (mBackground.content as Bitmap).smoothing = true;
                });

            // While the assets are loaded, we will display a progress bar.

            mProgressBar = new ProgressBar(175, 20);
            mProgressBar.x = (mBackground.width - mProgressBar.width) / 2;
            mProgressBar.y =  mBackground.height * 0.7;
            addChild(mProgressBar);
        }
		
		private function removeElements():void
        {
            if (mBackground)
            {
                removeChild(mBackground);
                mBackground = null;
            }

            if (mProgressBar)
            {
                removeChild(mProgressBar);
                mProgressBar = null;
            }
        }
		
	}
	
}