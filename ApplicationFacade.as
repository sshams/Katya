/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package {
	import controller.StartupCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade {
		
		public static const STARTUP:String = "startup";
		public static const SHOW_WORKS:String = "showWorks";
		public static const SHOW_BLOWUP:String = "showBlowup";
		public static const HIDE_BLOWUP:String = "hideBlowup";
		public static const LOAD_SWF:String = "loadSWF";
		public static const SHOW_ERROR:String = "showError";
		
		public static function getInstance():ApplicationFacade {
			if(instance == null){
				instance = new ApplicationFacade();
			}
			return instance as ApplicationFacade;
		}
		
		override protected function initializeController():void {
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
		}
		
		public function startup(app:Object):void {
			sendNotification(STARTUP, app);
		}
		
	}
}