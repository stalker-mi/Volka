package 
{
		import flash.events.Event;
		import flash.display.Sprite;
		import flash.events.MouseEvent; 
		import flash.text.TextField;
		import flash.text.TextFieldAutoSize;
		import flash.events.TimerEvent; 
		import flash.display.Stage;
		import flash.utils.Timer;
		
		import as3isolib.core.IIsoDisplayObject;
		import as3isolib.display.scene.IsoScene;
	/**
	 * ...
	 * @author Vovik
	 */
	public class Povedenie6 extends Povedenie
	{
		private var box:IIsoDisplayObject;
		private var scene:IsoScene;
		
		public function Povedenie6(timer1:Timer, dispatcher1:myDispatcher, my_scene:IsoScene, my_box:IIsoDisplayObject){
			my_timer = timer1;
			dispatcher = dispatcher1;
			scene = my_scene;
			box = my_box;

			init_button ();
			

		}
		
		 private function init_button ():void {
			 var but:Sprite = new Sprite();
			 but.buttonMode = true;
			 but.graphics.beginFill(0xFF0000);
			 but.graphics.drawRect(0, 0, 150, 50);
			 but.graphics.endFill();
			 var txt:TextField=new TextField();
			 txt.mouseEnabled=false;
			 txt.x=25;
			 txt.y=15;
			 txt.text = "Движение в центр поля";
			 txt.autoSize=TextFieldAutoSize.CENTER;
			 but.addChild(txt);
			 //but.x = stage.stageWidth / 2-but.width/2;
			 but.x = 800 / 2-but.width/2;
			 addChild(but);
			 but.addEventListener(MouseEvent.CLICK, but_click);
		}
		
		 private function but_click (e:MouseEvent):void {
			 if (my_timer.hasEventListener(TimerEvent.TIMER_COMPLETE))
				my_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete); 
				dispatcher.remove_enterFrame();
				my_timer.stop();
				addEventListener(Event.ENTER_FRAME, enterFrameButton);
				
		 }
		 
		  private function enterFrameButton(evt:Event):void {
			  if (box.x < 250) box.x++;
			  if (box.x > 250) box.x--;
			  if (box.y < 250) box.y++;
			  if (box.y > 250) box.y--;
			  scene.render();
			  if (box.x == 250 && box.y == 250) {
					removeEventListener(Event.ENTER_FRAME, enterFrameButton);
					//my_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
					my_timer.start();
				}
			}
	
			
	}
	
	
	
	
}