/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.mediators {
	import model.SWFAddressProxy;
	import model.WorksProxy;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;
	
	import view.components.Submenu;
	import view.events.SubmenuEvent;
	
	public class SubmenuMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "SubmenuMediator";
		
		public function SubmenuMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
			submenu.addEventListener(SubmenuEvent.SUBMENU_EVENT, submenu_submenuEventHandler);
		}
		
		private function submenu_submenuEventHandler(event:SubmenuEvent):void {
			var worksProxy:WorksProxy = facade.retrieveProxy(WorksProxy.NAME) as WorksProxy;
			var swfAddressProxy:SWFAddressProxy = facade.retrieveProxy(SWFAddressProxy.NAME) as SWFAddressProxy;
			
			swfAddressProxy.setTitle(ApplicationConstants.title + " - " + worksProxy.getSubmenus()[event.id]);
			swfAddressProxy.requestURI(String(worksProxy.getSubmenus()[event.id]).toLowerCase().replace(" ", ""));
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.SHOW_WORKS,
				ApplicationFacade.LOAD_SWF
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()){
				case ApplicationFacade.SHOW_WORKS:
					if(!ApplicationConstants.submenuPopulated){
						var worksProxy:WorksProxy = facade.retrieveProxy(WorksProxy.NAME) as WorksProxy;
						submenu.populate(worksProxy.getSubmenus());
						ApplicationConstants.submenuPopulated = true;
					}
					
					submenu.setCurrent(int(notification.getBody()));
					break;
				
				case ApplicationFacade.LOAD_SWF:
					submenu.reset();
					break;
			}
		}
		
		public function get submenu():Submenu {
			return viewComponent as Submenu;
		}
	}
}