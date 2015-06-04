package 
{
	import flash.events.Event;
	
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.display.scene.IsoScene;
	/**
	 * ...
	 * @author Vovik
	 */
	public class Povedenie2 extends Povedenie 
	{
		private var box:IIsoDisplayObject;
		private var scene:IsoScene;
		
		public function Povedenie2(dispatcher1:myDispatcher, my_scene:IsoScene, my_box:IIsoDisplayObject) {
			dispatcher = dispatcher1;
            dispatcher.addEventListener(myEvent.POV2, actionHandler);
			scene = my_scene;
			box = my_box;
		}
		private function actionHandler(event:Event):void {
			//box.gotoAndStop(2);.............
			scene.render();
			dispatcher.pov_end(2);
		}
	}
	
}