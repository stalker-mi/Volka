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
package as3isolib.display.renderers {
	import as3isolib.core.IIsoContainer;
	import as3isolib.display.scene.IIsoScene;

	public class SimpleSceneLayoutRenderer implements ISceneLayoutRenderer {
		/**
		 * Array of propert names to sort scene's children by.  The default value is <code>["y", "x", "z"]</code>.
		 */
		public var sortOnProps : Array = ["y", "x", "z"];

		// // // // // //////////////////////////////////////////
		// RENDER SCENE
		// // // // // //////////////////////////////////////////
		/**
		 * @inheritDoc
		 */
		public function renderScene(scene : IIsoScene) : void {
			var vector : Vector.<IIsoContainer> = scene.displayListChildren.slice();
			var children : Array = [];
			while (vector.length) children.push(vector.shift());
			children.sortOn(sortOnProps, Array.NUMERIC);

			var child : IIsoContainer;

			var current : uint;
			const totalChildren : uint = children.length;
			while (current < totalChildren) {
				child = children[current] as IIsoContainer;
				if (child.depth != current)
					scene.setChildIndex(child, current);

				current++;
			}
		}

		// // // // // ///////////////////////////////////////////////////////
		// COLLISION DETECTION
		// // // // // ///////////////////////////////////////////////////////
		private var collisionDetectionFunc : Function = null;

		/**
		 * @inheritDoc
		 */
		public function get collisionDetection() : Function {
			return collisionDetectionFunc;
		}

		/**
		 * @private
		 */
		public function set collisionDetection(value : Function) : void {
			collisionDetectionFunc = value;
		}
	}
}