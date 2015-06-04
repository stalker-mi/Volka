package 
{
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class myDispatcher extends EventDispatcher {
		public var my_timer:Timer;
		
		public function remove_enterFrame():void {
			dispatchEvent(new Event(myEvent.REMOVE));
		}
		public function pov_begin(i:int):void {
			switch(i){
			case 1:dispatchEvent(new Event(myEvent.POV1)); break;
			case 2:dispatchEvent(new Event(myEvent.POV2)); break;
			case 3:dispatchEvent(new Event(myEvent.POV3)); break;
			case 4:dispatchEvent(new Event(myEvent.POV4)); break;
			case 5:dispatchEvent(new Event(myEvent.POV5)); break;
			}
		}
		public function pov_end(i:int):void {
			switch(i){
			case 1:dispatchEvent(new myEvent(myEvent.POV2END, my_timer)); break;
			case 2:dispatchEvent(new myEvent(myEvent.POV2END, my_timer)); break;
			case 3:dispatchEvent(new myEvent(myEvent.POV3END, my_timer)); break;
			case 4:dispatchEvent(new myEvent(myEvent.POV4END, my_timer)); break;
			case 5:dispatchEvent(new myEvent(myEvent.POV5END, my_timer)); break;
			}
		}
	}
	
}