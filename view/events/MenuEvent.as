/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.events {
	import flash.events.Event;
	
	public class MenuEvent extends Event {
		
		public static const MENU_EVENT:String = "menuEvent";
		public var id:int;
		
		public function MenuEvent(type:String, id:int, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.id = id;
		}
	}
}