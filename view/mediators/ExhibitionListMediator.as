/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.mediators {
	import model.ExhibitionsProxy;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;
	
	import view.components.ExhibitionList;
	
	public class ExhibitionListMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "ExhibitionsMediator";
		
		public function ExhibitionListMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ExhibitionsFacade.SHOW_EXHIBITIONS
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()){
				case ExhibitionsFacade.SHOW_EXHIBITIONS:
					var exhibitionsProxy:ExhibitionsProxy = facade.retrieveProxy(ExhibitionsProxy.NAME) as ExhibitionsProxy;
					exhibitionList.populate(exhibitionsProxy.getExhibitions());
					break;
			}
		}
		
		public function get exhibitionList():ExhibitionList {
			return viewComponent as ExhibitionList;
		}
		
	}
}