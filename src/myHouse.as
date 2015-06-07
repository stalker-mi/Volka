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
		public static const CHANGE_HOUSE:String = "Change";
		
		private var isoHill:IsoHill;
		public var my_x:int;
		public var my_y:int;
		public var lifes:int;
		public var totalLifes:int;
		public var sprite:IsoMovieClip;
		public var isAdded:Boolean;
		private var grid:GridDisplay;
		private var bar:IsoMovieClip;
		
		public function myHouse(isoHill:IsoHill, grid:GridDisplay) {
			this.isoHill = isoHill;
			this.grid = grid;
		}
		
		public function addSprite(x:int, y:int):void {
			totalLifes=Math.random() * 4 + 1;
			lifes = totalLifes;
			my_x = x;
			my_y = y;
			isAdded = true;
			sprite = rand_house(x, y);
			sprite.display.addEventListener(TouchEvent.TOUCH, function(event:TouchEvent):void {
				if (event.getTouch(sprite.display, TouchPhase.BEGAN))
				{
					lifes--;
					bar.display.scaleX = lifes/totalLifes;
					if (!lifes) {
						var point:Point = new Point(sprite.pt.x / 30, sprite.pt.y / 30);
						isAdded = false;
						var global_point:Point = sprite.display.localToGlobal(point);
						dust(global_point.x,global_point.y);
						grid.remove(sprite);
						grid.remove(bar);
						dispatchEventWith(CHANGE_HOUSE);
					}
					
				}
			});
			grid.add(sprite);
			bar= new IsoMovieClip(myAssets.ASSETS_GRASS, "sprite_bar", grid.toLayerPt(x, y));
			bar.currentFrame = 1;
			bar.display.touchable = false;
			grid.add(bar);
			//trace(grid.getCell(x,y))
			dispatchEventWith(CHANGE_HOUSE);
		}
		
		public function removeSprite(x:int, y:int):void {
			isAdded = false;
			dust(grid.getCell(x, y)[1].display.localToGlobal(new Point(x,y)).x, grid.getCell(x, y)[1].display.localToGlobal(new Point(x,y)).y);
			//grid.remove(grid.getCell(x, y)[1]);
			grid.remove(sprite);
			grid.remove(bar);
			trace(grid.getCell(x, y));
			dispatchEventWith(CHANGE_HOUSE);
		}
		
		private function dust(x:int, y:int):void {
			var frames:Vector.<Texture> = Root.assets.getTextures("dust1x1_2");
			var mMovie:MovieClip = new MovieClip(frames, 23);
			mMovie.x = x-20;
			mMovie.y = y + 20;
			mMovie.touchable = false;
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
			this.name = index.toString();
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