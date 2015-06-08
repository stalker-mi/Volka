package 
{
	import as3isolib.core.IsoDisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
    import starling.display.Sprite;
    import starling.utils.AssetManager;
    import flash.events.Event;
	import flash.events.MouseEvent;
		
		import as3isolib.display.IsoView;
		import as3isolib.core.IIsoDisplayObject;
        import as3isolib.geom.IsoMath;
        import as3isolib.geom.Pt;
import starling.display.Image;
import flash.display.Bitmap;
	import starling.textures.Texture;
	
	import as3isolib.display.primitive.IsoBox;
    import as3isolib.display.scene.IsoGrid;
    import as3isolib.display.scene.IsoScene;
	import as3isolib.display.IsoSprite;
	
	import fr.kouma.starling.utils.Stats;
	
    public class Root1 extends Sprite
    {
		[Embed(source="../assets/bigGrass.png")]
		public static const TILE : Class;
		
		
        private static var sAssets:AssetManager;
		private var view:IsoView;
		private var scene:IsoScene;
        private var box:IIsoDisplayObject;

		private var panPt : Point;
		private var zoom : Number = 1;
		
        public function Root1()
        {
            //
        }
		
		 public function start(assets:AssetManager):void
        {
            sAssets = assets;
			scene = new IsoScene();
                        scene.hostContainer = this; //it is recommended to use an IsoView
						
						var grid:IsoGrid = new IsoGrid();
                        grid.showOrigin = false;
					    grid.setGridSize(125, 125, 0);
						grid.cellSize = 32;
                        scene.addChild(grid);
						
						var grid2:IsoGrid = new IsoGrid();
                        grid2.showOrigin = false;
					    grid2.setGridSize(125, 125, 0);
						grid2.cellSize = 32;
						grid2.x = 4000;
                        scene.addChild(grid2);
					
						var grid3:IsoGrid = new IsoGrid();
                        grid3.showOrigin = false;
					    grid3.setGridSize(125, 125, 0);
						grid3.cellSize = 32;
						grid3.y = 4000;
                        scene.addChild(grid3);
						
						var grid4:IsoGrid = new IsoGrid();
                        grid4.showOrigin = false;
					    grid4.setGridSize(125, 125, 0);
						grid4.cellSize = 32;
						grid4.x = 4000;
						grid4.y = 4000;
                        scene.addChild(grid4);
						
						box = new IsoBox();
                        box.setSize(40, 40, 40);
						box.moveTo(40, 40, 0);
                       // scene.addChild(box);
						
						//var tile : Texture = Texture.fromTexture(Texture.fromBitmap(new TILE()), new Rectangle(0, 0, 64, 32));
						
						
						
								var img : Image = new Image(Texture.fromBitmap(new TILE()));
								img.pivotX = img.width / 2;
								var s0 : IsoSprite = new IsoSprite();
								s0.moveTo(0, 0, 0);
								s0.sprites = [img];
								scene.addChild(s0);
								
								
							
						
						/*
						for (var x:int = 0; x < 10; x++) {
							for (var y:int = 0; y < 10; y++) {
								var img : Image = new Image(tile);
								img.pivotX = img.width / 2;
								var s0 : IsoSprite= new IsoSprite();
								s0.moveTo(x*32, y*32, 0);
								s0.sprites = [img];
								grid.addChild(s0);
							}
						}
						*/
						
						//var s0 : IsoSprite = new IsoSprite();
						//s0.moveTo(0, 32, 0);
						//s0.sprites = [img];
						//scene.addChild(s0);
						
						scene.render();
					
						view = new IsoView();
						view.setSize(stage.stageWidth, stage.stageHeight);
						view.clipContent = true;
						addChild(view);
						view.addScene(scene);
						Main.STAGE.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
						Main.STAGE.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
						
						addChild(new Stats()); // Mrdoob's performance monitor
			
        }
		
		private function viewMouseDown(e : MouseEvent) : void {
			panPt = new Point(Main.STAGE.mouseX, Main.STAGE.mouseY);
			Main.STAGE.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			Main.STAGE.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
		
		private function viewMouseUp(e : MouseEvent) : void {
			Main.STAGE.removeEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			Main.STAGE.removeEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}

		private function viewPan(e : MouseEvent) : void {
			view.panBy(panPt.x - Main.STAGE.mouseX, panPt.y - Main.STAGE.mouseY);
			panPt.x = Main.STAGE.mouseX;
			panPt.y = Main.STAGE.mouseY;
		}
		
		private function viewZoom(e : MouseEvent) : void {
			if (e.delta > 0) {
				zoom += 0.10;
			}
			if (e.delta < 0) {
				zoom -= 0.10;
			}

			if (zoom < 0) zoom = 0;
			view.currentZoom = zoom;
		}
		
		public static function get assets():AssetManager { return sAssets; }
		
    }
}