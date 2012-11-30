/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.events {
	import flash.events.Event;
	
	public class BlowupEvent extends Event {
		
		public static const CLOSE:String = "close";
		
		public function BlowupEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}