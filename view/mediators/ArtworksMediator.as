/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.mediators {
	import model.WorksProxy;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;
	
	import view.components.Artworks;
	import view.events.ArtworkEvent;
	
	public class ArtworksMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "ArtworksMediator";
		
		public function ArtworksMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
			artworks.addEventListener(ArtworkEvent.ARTWORK_EVENT, artworks_artworEventHandler);
		}

		private function artworks_artworEventHandler(event:ArtworkEvent):void {
			facade.sendNotification(ApplicationFacade.SHOW_BLOWUP, event.artworkVO);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.SHOW_WORKS,
				ApplicationFacade.HIDE_BLOWUP
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()){
				case ApplicationFacade.SHOW_WORKS:
					var worksProxy:WorksProxy = facade.retrieveProxy(WorksProxy.NAME) as WorksProxy;
					var id = int(notification.getBody()) == -1 ? 0 : int(notification.getBody());
					artworks.clear();
					artworks.populate(worksProxy.getArtworkVOs(id));
					break;
				case ApplicationFacade.HIDE_BLOWUP:
					artworks.unscatter();
					break;
			}
		}
		
		public function get artworks():Artworks {
			return viewComponent as Artworks;
		}
		
	}
}