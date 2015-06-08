/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 - 3000 J.W.Opitz, All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

 */
package as3isolib.display.primitive {
	import as3isolib.core.as3isolib_internal;
	import as3isolib.enum.RenderStyleType;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.IFill;
	import as3isolib.graphics.IStroke;

	import starling.Utils;
	import starling.display.Image;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;

	use namespace as3isolib_internal;
	/**
	 * 3D polygon primitive in isometric space.
	 */
	public class IsoPolygon extends IsoPrimitive {
		/**
		 * @inheritDoc
		 */
		override protected function validateGeometry() : Boolean {
			return pts.length > 2;
		}

		/**
		 * @inheritDoc
		 */
		override protected function drawGeometry() : void {
			var sprite : Sprite = new Sprite();
			var geometry : Shape = new Shape();
			var g : Graphics = geometry.graphics;

			sprite.addChild(geometry);

			g.clear();
			g.moveTo(pts[0].x, pts[0].y);

			var fill : IFill = IFill(fills[0]);
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);

			var stroke : IStroke = strokes.length >= 1 ? IStroke(strokes[0]) : DEFAULT_STROKE;
			if (stroke)
				stroke.apply(g);

			var i : uint = 1;
			var l : uint = pts.length;
			while (i < l) {
				g.lineTo(pts[i].x, pts[i].y);
				i++;
			}

			g.lineTo(pts[0].x, pts[0].y);

			if (fill)
				fill.end(g);

			geometry.x = this.length;
			geometry.y = this.height;

			var img : Image = Utils.createImage(sprite, container.width + 1, container.height + 1);
			img.pivotX = length;
			img.pivotY = height;
			this.container.addChild(img);
		}

		// // // // // //////////////////////////////////////////////////////////////
		// PTS
		// // // // // //////////////////////////////////////////////////////////////
		/**
		 * @private
		 */
		protected var geometryPts : Vector.<Pt>;

		/**
		 * @private
		 */
		public function get pts() : Vector.<Pt> {
			return this.geometryPts ||= new Vector.<Pt>();
		}

		/**
		 * The set of points in isometric space needed to render the polygon.  At least 3 points are needed to render.
		 */
		public function set pts(value : Vector.<Pt>) : void {
			if (geometryPts != value) {
				geometryPts = value;
				this.invalidateSize();

				if (autoUpdate)
					this.render();
			}
		}

		/**
		 * Constructor
		 */
		public function IsoPolygon(descriptor : Object = null) {
			super(descriptor);
		}
	}
}