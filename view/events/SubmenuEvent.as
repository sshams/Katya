/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.events {
	import flash.events.Event;
	
	public class SubmenuEvent extends Event {
		
		public static const SUBMENU_EVENT:String = "SubMenuEvent";
		
		public var id:int;
		
		public function SubmenuEvent(type:String, id:int, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.id = id;
		}
		
		override public function clone():Event {
			return new SubmenuEvent(type, id, bubbles, cancelable);
		}
	}
}