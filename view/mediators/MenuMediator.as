/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.mediators {
	import model.SWFAddressProxy;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;
	
	import view.components.Menu;
	import view.events.MenuEvent;
	
	public class MenuMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "Menu Mediator";
		
		public function MenuMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
			menu.addEventListener(MenuEvent.MENU_EVENT, menuEventHandler);
		}
		
		override public function listNotificationInterests():Array {
			return [ApplicationFacade.LOAD_SWF];
		}
		
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()){
				case ApplicationFacade.LOAD_SWF:
					if(notification.getBody() == "biography.swf"){
						menu.setColor(1);
					} else if(notification.getBody() == "contact.swf"){
						menu.setColor(2);
					}
			}
		}
		
		private function menuEventHandler(event:MenuEvent):void {
			var swfAddressProxy:SWFAddressProxy = facade.retrieveProxy(SWFAddressProxy.NAME) as SWFAddressProxy;
			
			swfAddressProxy.setTitle(ApplicationConstants.title + " - " + ApplicationConstants.labels[event.id]);
			swfAddressProxy.requestURI(String(ApplicationConstants.labels[event.id]).toLowerCase());
		}
		
		private function get menu():Menu {
			return viewComponent as Menu;
		}
		
	}
}