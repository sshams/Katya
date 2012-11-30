/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.events {
	import flash.events.Event;
	
	import model.valueObjects.ArtworkVO;
	
	public class ArtworkEvent extends Event {
		
		public static const ARTWORK_EVENT:String = "artworkEvent";
		public var artworkVO:ArtworkVO;
		
		public function ArtworkEvent(type:String, artworkVO:ArtworkVO, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.artworkVO = artworkVO;
		}
	}
}