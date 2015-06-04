package 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent; 
	import flash.utils.Timer;
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Vovik
	 */
	public class Povedenie extends Sprite
	{
		public var my_timer:Timer;
		public var dispatcher:myDispatcher;
		
		public function Povedenie() {
			;
		}
		
		public function init_dispatcher():void {
			dispatcher = new myDispatcher();
			dispatcher.addEventListener(myEvent.POV1END, pov_end);
			dispatcher.addEventListener(myEvent.POV2END, pov_end);
			dispatcher.addEventListener(myEvent.POV3END, pov_end);
			//dispatcher.addEventListener(myEvent.POV4END, pov_end);
			//dispatcher.addEventListener(myEvent.POV5END, pov_end);
		}
		public function init_timer():void {
			my_timer = new Timer((Math.random() * 8 + 2) * 1000, 1); 
			my_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
			my_timer.start();  
		}
		
		 public function onTimerComplete(event:TimerEvent):void { 
			switch (int(Math.random()*3)+1) {
			case 1:
				trace("1. переход персонажа в случайную точку локации");
				dispatcher.pov_begin(1);
				break;
			case 2:
				trace("2. зацикленное движение персонажа по кругу");
				dispatcher.pov_begin(2);
				break;
			case 3:
				trace("3. движение к точке и возвращение в исходную точку, откуда началось это поведение");
				dispatcher.pov_begin(3);
				break;
			case 4:
				trace("4. движение по прямой");
				dispatcher.pov_begin(4);
				break;	
			}

        }
		public function pov_end(event:myEvent):void {
			my_timer.delay = (Math.random() * 8 + 2)*1000;
			my_timer.start();
		}
		
	}
	
}