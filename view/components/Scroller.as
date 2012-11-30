/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.components {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class Scroller {
		
		private var scroller:Sprite
		private var track:Sprite;
		private var content:Sprite;
		private var stage:Stage;
		
		private var scrollUpper:int;
		private var scrollLower:int;
		private var contentLower:int;
		private var contentUpper:int;
		
		private var scrollRange:int;
		private var textRange:int;
		
		public function Scroller(content:Sprite, scroller:Sprite, track:Sprite, mask:Sprite, stage:Stage) {
			this.content = content;
			this.scroller = scroller;
			this.track = track;
			this.stage = stage;
			
			content.mask = mask;
			
			scrollUpper = scroller.y;
			scrollLower = track.y + track.height - scroller.height;
			
			contentLower = content.y;
			contentUpper = content.y - content.height + mask.height - 30;
			
			scrollRange = scrollLower - scrollUpper;
			textRange = contentLower - contentUpper;
			
			scroller.addEventListener(MouseEvent.MOUSE_DOWN, scroller_mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, scroller_mouseUpHandler);
		}
		
		
		private function scroller_mouseDownHandler(event:MouseEvent):void {
			scroller.startDrag(false, new Rectangle(scroller.x, scrollUpper, 0, scrollRange));
			stage.addEventListener(MouseEvent.MOUSE_MOVE, scroll);
		}
		
		private function scroller_mouseUpHandler(event:MouseEvent):void {
			scroller.stopDrag();
			if(stage){
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, scroll);
			}
		}
		
		private function scroll(event:MouseEvent):void {
			var moved:Number = scroller.y - scrollUpper;
			var percentMoved:Number = moved / scrollRange;
			
			var textMove:Number = percentMoved * textRange;
			content.y = contentLower - textMove;
		}
	}
}