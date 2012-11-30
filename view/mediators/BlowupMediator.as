/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.mediators {
	import model.valueObjects.ArtworkVO;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;
	
	import view.components.Blowup;
	import view.events.BlowupEvent;
	
	public class BlowupMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "BlowupMediator";
		
		public function BlowupMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
			blowup.addEventListener(BlowupEvent.CLOSE, blowup_closeHandler);
		}
		
		private function blowup_closeHandler(event:BlowupEvent):void {
			facade.sendNotification(ApplicationFacade.HIDE_BLOWUP);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.SHOW_BLOWUP
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()){
				case ApplicationFacade.SHOW_BLOWUP:
					blowup.unload();
					blowup.load(notification.getBody() as ArtworkVO);
					break;
			}
		}
		
		public function get blowup():Blowup {
			return viewComponent as Blowup;
		}
		
	}
}