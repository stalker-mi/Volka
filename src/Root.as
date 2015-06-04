package 
{

    
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.utils.AssetManager;

    public class Root extends Sprite
    {
        private static var sAssets:AssetManager;
        private var mActiveScene:Sprite;
        
        public function Root()
        {
            // nothing to do here -- Startup will call "start" immediately.
        }
        
        public function start(assets:AssetManager):void
        {
            sAssets = assets;
            //addChild(new Image(assets.getTexture("background")));
            //showScene(Menu);
        }
        
       private function showScene(screen:Class):void
        {
            if (mActiveScene) mActiveScene.removeFromParent(true);
            mActiveScene = new screen();
            addChild(mActiveScene);
        }
        public static function get assets():AssetManager { return sAssets; }
    }
}