/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package model {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import model.valueObjects.ArtworkVO;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	
	public class WorksProxy extends Proxy implements IProxy {
		
		public static const NAME:String = "WorksProxy";
		
		private var urlLoader:URLLoader;
		private var path:String = "model/xml/works.xml";
		private var works:XML;
		private var submenus:Array;
		
		public function WorksProxy(data:Object=null) {
			super(NAME, data);
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoader_IOErrorHandler);
			urlLoader.load(new URLRequest(path));
		}
		
		private function urlLoader_completeHandler(event:Event):void {
			data = [];
			
			works = XML(event.target.data);
			
			submenus = works.gallery.@type.toXMLString().split("\n");
			
			for(var i:int=0; i<works.children().length(); i++){
				data.push(new Array());
				for(var j:int=0; j<works.children()[i].children().length(); j++){
					
					var artwork:XML = works.children()[i].children()[j];
					
					var artworkVO:ArtworkVO = new ArtworkVO();
					artworkVO.id = j;
					artworkVO.title = artwork.title;
					artworkVO.description = artwork.description;
					artworkVO.date = artwork.date;
					artworkVO.thumbnail = artwork.thumbnail;
					artworkVO.image = artwork.image;
					
					data[i].push(artworkVO);
				}
			}
			ApplicationConstants.worksProxyLoaded = true;
			if(ApplicationConstants.currentSubmenu != -1){
				facade.sendNotification(ApplicationFacade.SHOW_WORKS, ApplicationConstants.currentSubmenu);
			}
		}
		
		public function getArtworkVOs(index:int):Array {
			return data[index];
		}
		
		public function getSubmenus():Array {
			return submenus;
		}
		
		private function urlLoader_IOErrorHandler(event:IOErrorEvent):void {
			sendNotification(ApplicationFacade.SHOW_ERROR);
		}
		
	}
}