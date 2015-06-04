package
{
	import flash.display.Sprite;
	import flash.system.Capabilities;
	import flash.display.Bitmap;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
    import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.textures.RenderTexture;
	
	import utils.ProgressBar;
	/**
	 * ...
	 * @author Vovik
	 */
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#111111")]
	public class Main extends Sprite 
	{
		private var mStarling:Starling;
		private var mBackground:Bitmap;
        private var mProgressBar:ProgressBar;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Object = null):void 
		{
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, init);
			// entry point
			Starling.multitouchEnabled = true; // for Multitouch Scene
            Starling.handleLostContext = true; // recommended everywhere when using AssetManager

			mStarling = new Starling(Root, stage);
			mStarling.antiAliasing = 2; 
			mStarling.start();
			 mStarling.addEventListener(Event.ROOT_CREATED, function():void
            {
                var root:Root = mStarling.root as Root;
				root.start(null);
            });
			/*
			Starling.multitouchEnabled = true; // for Multitouch Scene
            Starling.handleLostContext = true; // recommended everywhere when using AssetManager
            RenderTexture.optimizePersistentBuffers = true; // should be safe on Desktop

            mStarling = new Starling(Root, stage, null, null, "auto", "auto");
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            mStarling.addEventListener(Event.ROOT_CREATED, function():void
            {
                loadAssets(startGame);
            });
			mStarling.antiAliasing = 2; 
			mStarling.start();
            initElements();
			*/
		}
		
		private function loadAssets(onComplete:Function):void
        {
			var assets:AssetManager = new AssetManager();

            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(EmbeddedAssets);

            assets.loadQueue(function(ratio:Number):void
            {
                mProgressBar.ratio = ratio;
                if (ratio == 1) onComplete(assets);
            });
        }
		
		private function startGame(assets:AssetManager):void
        {
            var root:Root = mStarling.root as Root;
            root.start(assets);
            setTimeout(removeElements, 150); // delay to make 100% sure there's no flickering.
        }
		private function initElements():void
        {
            // Add background image.
			mBackground = new EmbeddedAssets.background();
            mBackground.smoothing = true;
            addChild(mBackground);

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