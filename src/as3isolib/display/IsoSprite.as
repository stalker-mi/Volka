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
package as3isolib.display {
	import as3isolib.core.IsoDisplayObject;
	import as3isolib.core.as3isolib_internal;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import mx.core.IFactory;

	import flash.display.BitmapData;

	use namespace as3isolib_internal;
	/**
	 * IsoSprite is the base class in which visual assets may be attached to be presented in 3D isometric space.
	 * Since visual assets may not clearly define a volume in 3D isometric space, the developer is responsible for establishing the width, length and height properties.
	 */
	public class IsoSprite extends IsoDisplayObject {
		// // // // // // ////////////////////////////////////////////////
		// SKINS
		// // // // // // ////////////////////////////////////////////////
		/**
		 * @private
		 */
		protected var spritesArray : Array = [];

		/**
		 * @private
		 */
		public function get sprites() : Array {
			return spritesArray;
		}

		/**
		 * An array of visual assets to be attached.
		 * Elements in the array are expected be of type DisplayObject or Class (cast to a DisplayObject upon instantiation).
		 */
		public function set sprites(value : Array) : void {
			if ( spritesArray != value ) {
				spritesArray = value;
				bSpritesInvalidated = true;
			}
		}

		protected var actualSpriteObjects : Array = [];

		public function get actualSprites() : Array {
			return actualSpriteObjects.slice();
		}

		// // // // // // ////////////////////////////////////////////////
		// INVALIDATION
		// // // // // // ////////////////////////////////////////////////
		as3isolib_internal var bSpritesInvalidated : Boolean = false;

		/**
		 * This method has been deprecated.  Use invalidateSprites instead.
		 */
		public function invalidateSkins() : void {
			bSpritesInvalidated = true;
		}

		/**
		 * Flags the IsoSprite for invalidation reflecting changes of the spite objects contained in <code>sprites</code>.
		 */
		public function invalidateSprites() : void {
			bSpritesInvalidated = true;
		}

		/**
		 * @inheritDoc
		 */
		override public function get isInvalidated() : Boolean {
			return ( bPositionInvalidated || bSpritesInvalidated );
		}

		// // // // // // ////////////////////////////////////////////////
		// RENDER
		// // // // // // ////////////////////////////////////////////////
		/**
		 * @inheritDoc
		 */
		override protected function renderLogic(recursive : Boolean = true) : void {
			if ( bSpritesInvalidated ) {
				renderSprites();
				bSpritesInvalidated = false;
			}

			super.renderLogic(recursive);
		}

		protected function renderSprites() : void {
			// remove all previous skins
			actualSpriteObjects = [];

			while ( this.container.numChildren > 0 )
				this.container.removeChildAt(0);

			var spriteObj : Object;

			for each (spriteObj in spritesArray) {
				if ( spriteObj is BitmapData ) {
					// starling adapt
					var img : Image = new Image(Texture.fromBitmapData(spriteObj as BitmapData));
					this.container.addChild(img);
					actualSpriteObjects.push(img);
				} else if ( spriteObj is DisplayObject ) {
					this.container.addChild(spriteObj as DisplayObject);
					actualSpriteObjects.push(spriteObj);
				} else if ( spriteObj is Class ) {
					var spriteInstance : DisplayObject = new spriteObj() as DisplayObject;
					this.container.addChild(spriteInstance);
					actualSpriteObjects.push(spriteInstance);
				} else if ( spriteObj is IFactory ) {
					spriteInstance = (spriteObj as IFactory).newInstance() as DisplayObject;
					this.container.addChild(spriteInstance);
					actualSpriteObjects.push(spriteInstance);
				} else
					throw new Error("skin asset is not of the following types: BitmapData, DisplayObject, ISpriteAsset, IFactory or Class cast as DisplayOject.");
			}
		}

		/**
		 * @inheritDoc
		 */
		override protected function createChildren() : void {
			super.createChildren();
			// starling adaptation
			// mainContainer = new MovieClip();
			mainContainer = new Sprite();
			attachMainContainerEventListeners();
		}

		// // // // // // ////////////////////////////////////////////////
		// CONSTRUCTOR
		// // // // // // ////////////////////////////////////////////////
		/**
		 * Constructor
		 */
		public function IsoSprite(descriptor : Object = null) {
			super(descriptor);
		}
	}
}