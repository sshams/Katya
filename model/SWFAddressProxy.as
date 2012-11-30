/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package model {
	import com.afw.swfaddress.SWFAddressUtil;
	import com.asual.SWFAddress;
	import com.asual.SWFAddressEvent;
	
	import flash.external.ExternalInterface;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	
	public class SWFAddressProxy extends Proxy implements IProxy {
		
		public static const NAME:String = "SWFAddressProxy";
		
		public function SWFAddressProxy() {
			super(NAME, "/");
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, swfAddress_changeHandler);
		}
		
		private function swfAddress_changeHandler(event:SWFAddressEvent):void {
			setTargetURI(SWFAddressUtil.segmentURI(event.value));
			//trace('change', event.value);
			
			switch(event.value){
				case "/works":
					if(ApplicationConstants.worksProxyLoaded){
						sendNotification(ApplicationFacade.SHOW_WORKS, 0);
					} else {
						ApplicationConstants.currentSubmenu = 0;
					}
					break;
				
				case "/paintings":
					if(ApplicationConstants.worksProxyLoaded){
						sendNotification(ApplicationFacade.SHOW_WORKS, 0);
					} else {
						ApplicationConstants.currentSubmenu = 0;
					}
					break;
				
				case "/drawings":
					if(ApplicationConstants.worksProxyLoaded){
						sendNotification(ApplicationFacade.SHOW_WORKS, 1);
					} else {
						ApplicationConstants.currentSubmenu = 1;
					}
					break;
				
				case "/bookartwork":
					if(ApplicationConstants.worksProxyLoaded){
						sendNotification(ApplicationFacade.SHOW_WORKS, 2);
					} else {
						ApplicationConstants.currentSubmenu = 2;
					}
					break;
				
				case "/sculptures":
					if(ApplicationConstants.worksProxyLoaded){
						sendNotification(ApplicationFacade.SHOW_WORKS, 3);
					} else {
						ApplicationConstants.currentSubmenu = 3;
					}
					break;
				
				case "/publications":
					if(ApplicationConstants.worksProxyLoaded){
						sendNotification(ApplicationFacade.SHOW_WORKS, 4);
					} else {
						ApplicationConstants.currentSubmenu = 4;
					}
					break;
					
				case "/biography":
					ApplicationConstants.currentSubmenu = -1;
					sendNotification(ApplicationFacade.LOAD_SWF, "biography.swf");
					break;
				
				case "/contact":
					ApplicationConstants.currentSubmenu = -1;
					sendNotification(ApplicationFacade.LOAD_SWF, "contact.swf");
					break;
			}
		}
		
		public function setTitle(title:String):void {
			SWFAddress.setTitle(title);
		}
		
		private function setTargetURI(uriSegments:Array):void {
			sendNotification("$" + uriSegments[0], uriSegments, "Array");
			//trace('setTargetURI', uriSegments);
		}
		
		public function requestURI(uri:String):void {
			if (ExternalInterface.available) {
				SWFAddress.setValue(uri);
			} else {
				setTargetURI(SWFAddressUtil.segmentURI(uri));
			}
			//trace('requstURI', uri);
		}
		
	}
}