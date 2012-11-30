/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.components {
	import com.greensock.TweenMax;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class SWF extends Sprite {
		
		private var swf:Loader;
		private var url:String;
		private var spinner:Sprite;
		
		public function SWF() {
			spinner = this.getChildByName("_spinner") as Sprite;
			
			swf = new Loader();
			swf.contentLoaderInfo.addEventListener(Event.COMPLETE, swf_completeHandler);
			swf.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, swf_IOErrorEventHandler);
		}
		
		public function load(url:String):void {
			this.url = url;
			addChild(spinner);
			swf.load(new URLRequest(url));
		}
		
		private function swf_completeHandler(event:Event):void {
			removeChild(spinner);
			addChild(swf);
			TweenMax.from(swf, .5, {alpha: 0, y:String(10)});
		}
		
		public function clear():void {
			if(swf && swf.stage){
				removeChild(swf);
			}
		}
		
		private function swf_IOErrorEventHandler(event:IOErrorEvent):void {
			trace("Failed to load", url);
		}
	}
}