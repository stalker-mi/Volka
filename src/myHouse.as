package 
{
	import flash.geom.Point;
	
	import isohill.IsoHill;
	import isohill.IsoMovieClip;
	import isohill.Point3;
	import isohill.GridDisplay;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.display.MovieClip;
	/**
	 * ...
	 * @author vovik
	 */
	public class myHouse extends Sprite
	{
		public static const GRID_ARR:String = "gridArray";
		
		private var isoHill:IsoHill;
		public var my_x:int;
		public var my_y:int;
		public var lifes:int;
		public var sprite:IsoMovieClip;
		private var grid:GridDisplay;
		
		public function myHouse(isoHill:IsoHill, grid:GridDisplay) {
			this.isoHill = isoHill;
			this.grid = grid;
		}
		
		public function addSprite(x:int, y:int):void {
			my_x = x;
			my_y = y;
			sprite = rand_house(x, y);
			sprite.display.addEventListener(TouchEvent.TOUCH, function(event:TouchEvent):void {
				if (event.getTouch(sprite.display, TouchPhase.BEGAN))
				{
					var point:Point = new Point(sprite.pt.x / 30, sprite.pt.y / 30);
					dispatchEventWith(GRID_ARR,true,point);
					var global_point:Point = sprite.display.localToGlobal(point);
					dust(global_point.x,global_point.y);
					grid.remove(sprite);
					//txt.text = "Количество домов:\n" + len(gridArr).toString();
				}
			});
			grid.add(sprite);
			//txt.text = "Количество домов:\n" + len(gridArr).toString();
		}
		
		public function removeSprite(x:int, y:int):void {
			dust(grid.getCell(x, y)[1].display.localToGlobal(new Point(x,y)).x, grid.getCell(x, y)[1].display.localToGlobal(new Point(x,y)).y);
			grid.remove(grid.getCell(x,y)[1]);
			txt.text = "Количество домов:\n" + len(gridArr).toString();
		}
		
		private function dust(x:int, y:int):void {
			var frames:Vector.<Texture> = Root.assets.getTextures("dust1x1_2");
			var mMovie:MovieClip = new MovieClip(frames, 23);
			mMovie.x = x-20;
			mMovie.y = y + 20;
			addChild(mMovie);
			isoHill.juggler.add(mMovie);
			mMovie.addEventListener(Event.COMPLETE, function():void {
				isoHill.juggler.remove(mMovie);
				removeChild(mMovie);
			});
		}
		
		private function rand_house(x:int, y:int):IsoMovieClip {
			var pt3:Point3 = grid.toLayerPt(x, y);
			var index:int = y * grid.width + x;
			var k:int = Math.random() * 2 + 1;
			var skin:int;
			var sprite:IsoMovieClip;
			switch(k) {
				case 1: 
					skin = int(Math.random() * 7);
					sprite = new IsoMovieClip(myAssets.ASSETS_64, "sprite"+index, pt3);
					sprite.currentFrame = skin;
					break;
				case 2:
					skin = Math.round(Math.random());
					sprite = new IsoMovieClip(myAssets.ASSETS_128, "sprite"+index, pt3);
					sprite.currentFrame = skin;
					break;
				case 3:
					skin = Math.round(Math.random());
					sprite = new IsoMovieClip(myAssets.ASSETS_192, "sprite"+index, pt3);
					sprite.currentFrame = skin;
					break;
			}
			return sprite;
		}
		
	}
	
}