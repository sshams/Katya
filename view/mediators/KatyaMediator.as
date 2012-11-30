/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.mediators {
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;
	
	public class KatyaMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "KatyaMediator";
		
		public function KatyaMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
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
					katya.removeSWF();
					katya.addGallery();
					break;
				
				case ApplicationFacade.LOAD_SWF:
					katya.addSWF();
					katya.removeGallery();
					break;
			}
		}
		
		public function get katya():Katya {
			return viewComponent as Katya;
		}
		
	}
}