package
{
        import as3isolib.display.primitive.IsoBox;
        import as3isolib.display.scene.IsoGrid;
        import as3isolib.display.scene.IsoScene;
      
        import flash.display.Sprite;
        import flash.events.Event;
		import flash.events.MouseEvent;
		
		import as3isolib.display.IsoView;
		import as3isolib.core.IIsoDisplayObject;
        import as3isolib.geom.IsoMath;
        import as3isolib.geom.Pt;

        
        import eDpLib.events.ProxyEvent;


	/**
	 * ...
	 * @author Vovik
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite
	{
		
		//private var my_timer:Timer;
		private var view:IsoView;
		private var scene:IsoScene;
        private var box:IIsoDisplayObject;

		private var lastX:Number;
		private var lastY:Number;
		private var pan:Boolean;
		
				public function Main() 
				{
					if (stage) init();
					else addEventListener(Event.ADDED_TO_STAGE, init);
				}

				private function init(e:Event = null):void 
				{
					removeEventListener(Event.ADDED_TO_STAGE, init);
					// entry point
					
					buildScene();
					
					var pov:Povedenie = new Povedenie();
					pov.init_dispatcher();
					pov.init_timer();
					var pov1:Povedenie1 = new Povedenie1(pov.dispatcher, scene, box);
					var pov2:Povedenie2 = new Povedenie2(pov.dispatcher, scene, box);
					var pov3:Povedenie3 = new Povedenie3(pov.dispatcher, scene, box);
					var pov4:Povedenie4 = new Povedenie4(pov.dispatcher, scene, box);
					var pov5:Povedenie5 = new Povedenie5(pov.dispatcher, scene, box);
					var pov6:Povedenie6 = new Povedenie6(pov.my_timer, pov.dispatcher, scene, box);
					addChild(pov6);

				}
                 
                private function buildScene ():void
                {
                        scene = new IsoScene();
                        scene.hostContainer = this; //it is recommended to use an IsoView
						
						var grid:IsoGrid = new IsoGrid();
                        grid.showOrigin = false;
					    grid.setGridSize(50, 50, 0);
						grid.cellSize = 10;
                        scene.addChild(grid);
						//scene.addEventListener(MouseEvent.CLICK, grid_mouseHandler);
            
						box = new IsoBox();
                        box.setSize(10, 10, 10);
						box.moveTo(20, 20, 0);
                        scene.addChild(box);
						
						scene.render();
					
						view = new IsoView();
						view.setSize(stage.stageWidth, stage.stageHeight);
						view.clipContent = true;
						addChild(view);
						view.addScene(scene);
						this.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent):void  { pan = true; lastX = event.stageX; lastY = event.stageY;} );
						this.addEventListener(MouseEvent.MOUSE_UP, function (event:MouseEvent):void  { pan = false; } );
                        stage.addEventListener(MouseEvent.MOUSE_MOVE, function (event:MouseEvent):void { if (pan) {
						view.pan(lastX - event.stageX,lastY - event.stageY); lastX = event.stageX; lastY = event.stageY;} });

                }
/*
				 private function grid_mouseHandler (evt:ProxyEvent):void
                {
                        var mEvt:MouseEvent = MouseEvent(evt.targetEvent);
                        var pt:Pt = new Pt(mEvt.localX, mEvt.localY);
                        IsoMath.screenToIso(pt);
                        box.moveTo(pt.x, pt.y,pt.z);
						scene.render();
				}
			
                
        */     


		
		
	}

}