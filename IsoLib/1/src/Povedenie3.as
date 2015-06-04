package 
{
	import flash.events.Event;
	
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.display.scene.IsoScene;
	/**
	 * ...
	 * @author Vovik
	 */
	public class Povedenie3 extends Povedenie 
	{
		private var box:IIsoDisplayObject;
		private var scene:IsoScene;
		private var my_x:int;
		private var my_y:int;
		private var src_x:int;
		private var src_y:int;
		
		public function Povedenie3(dispatcher1:myDispatcher, my_scene:IsoScene, my_box:IIsoDisplayObject) {
			dispatcher = dispatcher1;
            dispatcher.addEventListener(myEvent.POV3, actionHandler);
			dispatcher.addEventListener(myEvent.REMOVE, remove);
			scene = my_scene;
			box = my_box;
		}
		private function actionHandler(event:Event):void {
			src_x = box.x;
			src_y = box.y;
			my_x = int(Math.random() * 500);
			my_y = int(Math.random() * 500);
			trace("Переход в точку x="+my_x+" y="+my_y);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(evt:Event):void {
			  if (box.x < my_x) box.x++;
			  if (box.x > my_x) box.x--;
			  if (box.y < my_y) box.y++;
			  if (box.y > my_y) box.y--;
			  scene.render();
			  if (box.x == my_x && box.y == my_y) {
					removeEventListener(Event.ENTER_FRAME, enterFrame);
					addEventListener(Event.ENTER_FRAME, enterFrame2);
					trace("Переход в обратную точку x="+src_x+" y="+src_y);
				}
		}
		
		private function enterFrame2(evt:Event):void {
			  if (box.x < src_x) box.x++;
			  if (box.x > src_x) box.x--;
			  if (box.y < src_y) box.y++;
			  if (box.y > src_y) box.y--;
			  scene.render();
			  if (box.x == src_x && box.y == src_y) {
					removeEventListener(Event.ENTER_FRAME, enterFrame2);
					dispatcher.pov_end(3);
				}
		}
		
		
		private function remove(evt:Event):void {
			if (hasEventListener(Event.ENTER_FRAME)){
				removeEventListener(Event.ENTER_FRAME, enterFrame);
				removeEventListener(Event.ENTER_FRAME, enterFrame2);
			}
				
		}
	}
	
}