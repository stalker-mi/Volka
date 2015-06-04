package 
{
	import flash.events.Event;
	
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.display.scene.IsoScene;
	/**
	 * ...
	 * @author Vovik
	 */
	public class Povedenie4 extends Povedenie 
	{
		private var box:IIsoDisplayObject;
		private var scene:IsoScene;
		var k:int;
		
		public function Povedenie4(dispatcher1:myDispatcher, my_scene:IsoScene, my_box:IIsoDisplayObject) {
			dispatcher = dispatcher1;
            dispatcher.addEventListener(myEvent.POV4, actionHandler);
			dispatcher.addEventListener(myEvent.REMOVE, remove);
			scene = my_scene;
			box = my_box;
		}
		private function actionHandler(event:Event):void {
			k = int(Math.random() * 7) + 1;
			switch(k) {
				case 1:trace("Движение по x+"); break;
				case 2:trace("Движение по y+"); break;
				case 3:trace("Движение по x-"); break;
				case 4:trace("Движение по y-"); break;
				case 5:trace("Движение по x+ y+"); break;
				case 6:trace("Движение по x+ y-"); break;
				case 7:trace("Движение по x- y+"); break;
				case 8:trace("Движение по x- y-"); break;
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
		}
		private function enterFrame(evt:Event):void {
			switch(k) {
				case 1: box.x++; break;
				case 2: box.y++; break;
				case 3: box.x--; break;
				case 4: box.y--; break;
				case 5: box.x++; box.y++; break;
				case 6: box.x++; box.y--; break;
				case 7: box.x--; box.y++; break;
				case 8: box.x--; box.y--; break;
			}
			scene.render();
			if (box.x < 0) {  removeEventListener(Event.ENTER_FRAME, enterFrame); box.x = 0;dispatcher.pov_end(4); dispatcher.pov_begin(5);}
			if (box.y < 0) { removeEventListener(Event.ENTER_FRAME, enterFrame); box.y = 0; dispatcher.pov_end(4); dispatcher.pov_begin(5);}
			if (box.x > 500) {  removeEventListener(Event.ENTER_FRAME, enterFrame);box.y = 500; dispatcher.pov_end(4); dispatcher.pov_begin(5);}
			if (box.y > 500) { removeEventListener(Event.ENTER_FRAME, enterFrame); box.y = 500; dispatcher.pov_end(4); dispatcher.pov_begin(5);}
			
		}
		private function remove(evt:Event):void {
			if (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
	}
	
}