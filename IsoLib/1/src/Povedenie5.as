package 
{
	import flash.events.Event;
	
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.display.scene.IsoScene;
	/**
	 * ...
	 * @author Vovik
	 */
	public class Povedenie5 extends Povedenie 
	{
		private var box:IIsoDisplayObject;
		private var scene:IsoScene;
		var k:Number;
		
		public function Povedenie5(dispatcher1:myDispatcher, my_scene:IsoScene, my_box:IIsoDisplayObject) {
			dispatcher = dispatcher1;
            dispatcher.addEventListener(myEvent.POV5, actionHandler);
			dispatcher.addEventListener(myEvent.REMOVE, remove);
			scene = my_scene;
			box = my_box;
		}
		private function actionHandler(event:Event):void {
			k = Math.random();
			if (k > 0.5) trace("Движение против часовой");
			else trace("Движение по часовой");
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		private function enterFrame(evt:Event):void {
			if (k > 0.5) {
				if (box.x == 0) box.y++;
				if (box.y == 500) box.x++;
				if (box.x == 500) box.y--;
				if (box.y == 0) box.x--;
			}
			else {
				if (box.x == 0) box.y--;
				if (box.y == 0) box.x++;
				if (box.x == 500) box.y++;
				if (box.y == 500) box.x--;
			}
			
			scene.render();
		}
		private function remove(evt:Event):void {
			if (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
	}
	
}