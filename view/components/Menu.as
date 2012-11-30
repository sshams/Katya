/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.components {
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import view.events.MenuEvent;
	
	public class Menu extends Sprite {
		
		public static const NUM_BUTTONS:int = 3;
		
		private var buttons:Vector.<Sprite>;
		private var colorTransform:ColorTransform;
		private var currentID:int = 0;
		
		private var defaultColor:uint = 0x585858;
		private var highlightColor:uint = 0xd1cabb;
		
		public function Menu() {
			buttons = new Vector.<Sprite>();
			
			for(var i:int=0; i<NUM_BUTTONS; i++){
				buttons.push(this.getChildByName("button_" + i));
				buttons[i].buttonMode = true;
				buttons[i].addEventListener(MouseEvent.CLICK, buttons_clickHandler);
			}
		}
		
		public function setColor(buttonID:int):void {
			currentID = buttonID;
			resetColors();
			colorTransform = buttons[buttonID].transform.colorTransform;
			colorTransform.color = 0xd1cabb;
			buttons[buttonID].transform.colorTransform = colorTransform;			
		}
		
		private function buttons_clickHandler(event:MouseEvent):void {
			var name:String = Sprite(event.target).name;
			var id:int = parseInt(name.charAt(name.length - 1));
			
			if(currentID != id){
				currentID = id;
				
				resetColors();
				colorTransform = Sprite(event.target).transform.colorTransform;
				colorTransform.color = highlightColor;
				Sprite(event.target).transform.colorTransform = colorTransform;
				
				dispatchEvent(new MenuEvent(MenuEvent.MENU_EVENT, id));
			}
		}
		
		private function resetColors():void {
			for(var i:int=0; i<buttons.length; i++){
				colorTransform = buttons[i].transform.colorTransform;
				colorTransform.color = defaultColor;
				buttons[i].transform.colorTransform = colorTransform;
				buttons[i].buttonMode = true;
			}
		}
	}
}