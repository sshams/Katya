/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.mediators {
	import model.WorksProxy;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;
	
	import view.components.Gallery;
	
	public class GalleryMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "GalleryMediator";
		
		public function GalleryMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.SHOW_BLOWUP,
				ApplicationFacade.HIDE_BLOWUP
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()){
				case ApplicationFacade.SHOW_BLOWUP:
					gallery.addBlowup();
					gallery.showBlock();
					break;
				case ApplicationFacade.HIDE_BLOWUP:
					gallery.removeBlowup();
					gallery.hideBlock();
					break;
			}
		}
		
		public function get gallery():Gallery {
			return viewComponent as Gallery;
		}
		
	}
}