/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.mediators {
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;
	
	import view.components.SWF;
	
	public class SWFMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "SWFMediator";
		
		public function SWFMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.LOAD_SWF
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()){
				case ApplicationFacade.LOAD_SWF:
					swf.clear();
					swf.load(notification.getBody() as String);
					break;
			}
		}
		
		public function get swf():SWF {
			return viewComponent as SWF;
		}
	}
}