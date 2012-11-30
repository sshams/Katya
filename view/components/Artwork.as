/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.components {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import model.valueObjects.ArtworkVO;
	
	import view.events.ArtworkEvent;
	
	public class Artwork extends MovieClip {
		
		public var artworkVO:ArtworkVO;
		
		private var loader:Loader;
		private var spinner:Sprite;
		
		private var maskNormal:Sprite;
		private var maskOver:Sprite;
		private var borderNormal:Sprite;
		private var borderOver:Sprite;
		
		public static const offset:int = 6;
		
		public function Artwork(){ 
			maskNormal = this.getChildByName("_maskNormal") as Sprite;
			maskOver = this.getChildByName("_maskOver") as Sprite;
			borderNormal = this.getChildByName("_borderNormal") as Sprite;
			borderOver = this.getChildByName("_borderOver") as Sprite;
			spinner = this.getChildByName("_spinner") as Sprite;
			
			maskNormal.visible = false;
			maskOver.visible = false;
			this.buttonMode = true;
			
			removeChild(borderNormal);
			removeChild(borderOver);
		}
		
		public function loadArtwork(artworkVO:ArtworkVO):void {
			this.artworkVO = artworkVO;
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_IOErrorHandler);
			loader.load(new URLRequest(artworkVO.thumbnail));
		}
		
		private function loader_completeHandler(event:Event):void {
			removeChild(spinner);
			loader.x = -offset;
			loader.y = -offset * 3;
			
			addChild(loader);
			addChild(borderNormal);
			
			loader.mask = maskNormal;
			
			loader.addEventListener(MouseEvent.MOUSE_DOWN, loader_mouseDownHandler);
			loader.addEventListener(MouseEvent.MOUSE_OVER, loader_mouseOverHandler);
			loader.addEventListener(MouseEvent.MOUSE_OUT, loader_mouseOutHandler);
		}
		
		private function loader_mouseDownHandler(event:MouseEvent):void {
			dispatchEvent(new ArtworkEvent(ArtworkEvent.ARTWORK_EVENT, artworkVO));
		}
		
		private function loader_mouseOverHandler(event:MouseEvent):void {
			addChild(borderOver);
			removeChild(borderNormal);
			loader.mask = maskOver;
		}
		
		private function loader_mouseOutHandler(event:MouseEvent):void {
			addChild(borderNormal);
			removeChild(borderOver);
			loader.mask = maskNormal;
		}
		
		private function loader_IOErrorHandler(event:IOErrorEvent):void {
			trace("Failed to load thumbnail: " + artworkVO.thumbnail);
		}
		
	}
}