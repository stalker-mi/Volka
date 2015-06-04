package 
{
	import flash.events.Event;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Vovik
	 */
	
	
	public class myEvent extends Event {
		public static var REMOVE:String = "remove";
		public static var POV1:String = "povedenie1";
		public static var POV1END:String = "povedenie1_end";
		public static var POV2:String = "povedenie2";
		public static var POV2END:String = "povedenie2_end";
		public static var POV3:String = "povedenie3";
		public static var POV3END:String = "povedenie3_end";
		public static var POV4:String = "povedenie4";
		public static var POV4END:String = "povedenie4_end";
		public static var POV5:String = "povedenie5";
		public static var POV5END:String = "povedenie5_end";
		
		public var my_timer:Timer;
		
		public function myEvent(type:String, my_timer1:Timer=null,bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
			my_timer=my_timer1;
		}
		
		
	}
	
}