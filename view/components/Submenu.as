/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.components {
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	
	import view.components.SubmenuItem;
	import view.events.SubmenuEvent;
	
	public class Submenu extends flash.display.Sprite {
		
		private var submenuItems:Array;
		private var currentID:int = 0;
		private var colorTransform:ColorTransform;
		private var pointer:Sprite;
		
		public function Submenu(){
			submenuItems = new Array();
		}
		
		public function populate(submenuLabels:Array):void {
			var submenuItem:Sprite;
			var label:TextField;
			var offset:int = 0;
			var hotSpot:Sprite;
			
			for(var i:int=0; i<submenuLabels.length; i++){
				submenuItem = new SubmenuItem();
				submenuItems.push(submenuItem);
			
				label = TextField(submenuItem.getChildByName("label"));
				label.text = String(submenuLabels[i]).toUpperCase();
				submenuItem.x = offset;				
				
				hotSpot = new Sprite();
				hotSpot.graphics.beginFill(0x0000FF, 0);
				hotSpot.graphics.drawRect(offset, 0, label.textWidth, label.textHeight);
				hotSpot.graphics.endFill();
				hotSpot.name = "subMenu_" + i;
				hotSpot.buttonMode = true;
				
				hotSpot.addEventListener(MouseEvent.CLICK, submenuItem_clickHandler);
				submenuItem.buttonMode = true;
				addChild(submenuItem);
				addChild(hotSpot);
				
				offset += label.textWidth + 15;
			}

			colorTransform = Sprite(submenuItems[0]).transform.colorTransform;
			colorTransform.color = ApplicationConstants.SUBMENU_HIGHLIGHT_COLOR;
			Sprite(submenuItems[0]).transform.colorTransform = colorTransform;
			
			pointer = this.getChildByName("_pointer") as Sprite;
			pointer.x = submenuItems[0].x;
			addChild(pointer);
		}
		
		private function submenuItem_clickHandler(event:MouseEvent):void {
			var name:String = Sprite(event.target).name;
			var id:int = parseInt(name.charAt(name.length - 1));
			
			if(currentID != id){
				setCurrent(id);
				dispatchEvent(new SubmenuEvent(SubmenuEvent.SUBMENU_EVENT, id));
			}			
		}
		
		public function setCurrent(id:int):void {

			if(currentID != id){
				currentID = id;

				resetColors();
				
				colorTransform = Sprite(submenuItems[id]).transform.colorTransform;
				colorTransform.color = ApplicationConstants.SUBMENU_HIGHLIGHT_COLOR;
				Sprite(submenuItems[id]).transform.colorTransform = colorTransform;
			
				TweenMax.to(pointer, .5, {x: submenuItems[id].x});
			}
		}
		
		private function resetColors():void {
			for(var i:int=0; i<submenuItems.length; i++){
				colorTransform = Sprite(submenuItems[i]).transform.colorTransform;
				colorTransform.color = ApplicationConstants.SUBMENU_DEFAULT_COLOR;
				Sprite(submenuItems[i]).transform.colorTransform = colorTransform;
			}
		}
		
		public function reset():void {
			if(pointer){ //if the first call is to load swf
				resetColors();
				pointer.x = submenuItems[0].x;
				
				colorTransform = Sprite(submenuItems[0]).transform.colorTransform;
				colorTransform.color = ApplicationConstants.SUBMENU_HIGHLIGHT_COLOR;
				Sprite(submenuItems[0]).transform.colorTransform = colorTransform;
			}
		}
	}
}