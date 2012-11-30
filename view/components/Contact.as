/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.components {
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Contact extends MovieClip {
		
		private var defaultTexts:Array;
		private var textFields:Array;
		private var submit:Sprite;
		private var defaultTextColor:uint = 0xD1CABB;
		private var invalidTextColor:uint = 0xFF0000;
		private var defaultTextFormat:TextFormat;
		private const TOTAL_TEXTFIELDS:int = 3;
		private var urlRequest:URLRequest;
		private var urlVariables:URLVariables;
		private var urlLoader:URLLoader;
		private var address:String = "http://katyatraboulsi.com/model/php/email.php";
		
		public function Contact() {
			
			textFields = new Array();
			defaultTexts = new Array();
			submit = this.getChildByName("_submit") as Sprite;
			
			for(var i:int=0; i<TOTAL_TEXTFIELDS; i++){
				textFields.push(this.getChildByName("_textField" + i));
				defaultTexts.push(TextField(textFields[i]).text);
				TextField(textFields[i]).addEventListener(FocusEvent.FOCUS_IN, textFields_focusInHandler);
				TextField(textFields[i]).addEventListener(FocusEvent.FOCUS_OUT, textFields_focusOutHandler);
				TextField(textFields[i]).defaultTextFormat = TextField(textFields[0]).getTextFormat();
			}
			
			submit.buttonMode = true;
			submit.addEventListener(MouseEvent.CLICK, submit_clickHandler);
		}
		
		private function validate():Boolean {
			var valid:Boolean = true;
			
			for(var i:int=0; i<TOTAL_TEXTFIELDS; i++){
				if(TextField(textFields[i]).text == defaultTexts[i]){
					valid = false;
					TextField(textFields[i]).textColor = invalidTextColor;
				} else {
					TextField(textFields[i]).textColor = defaultTextColor;
				}
			}
			
			//var emailRegExp:RegExp = /^([a-zA-Z0-9_-]+)@([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,4})$/i;
			var emailRegExp:RegExp = /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)+)@(([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)){2,}\.([A-Za-z]){2,4}+$/g;
			if(!emailRegExp.exec(TextField(textFields[1]).text)){
				valid = false;
				TextField(textFields[1]).textColor = invalidTextColor;
			} else {
				TextField(textFields[1]).textColor = defaultTextColor;
			}
			
			return valid;
		}
		
		private function submit_clickHandler(event:MouseEvent):void {
			if(validate()){ //send values to server
				while(this.numChildren){
					this.removeChildAt(0);
				}
				
				urlVariables = new URLVariables();
				urlVariables.name = textFields[0].text; 
				urlVariables.email = textFields[1].text;
				urlVariables.message = textFields[2].text;
				
				urlRequest = new URLRequest(address);
				urlRequest.method = URLRequestMethod.POST;
				urlRequest.data = urlVariables;
				
				urlLoader = new URLLoader();
				urlLoader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoader_IOErrorEventHandler);
				urlLoader.load(urlRequest);
			}
		}
		
		private function urlLoader_completeHandler(event:Event):void {
				var thanks:MovieClip = new Thanks();
				addChild(thanks);
				TweenMax.from(thanks, .5, {alpha: 0, y: String(10)});
		}
		
		private function urlLoader_IOErrorEventHandler(event:IOErrorEvent):void {
			trace("error");
		}
		
		private function textFields_focusOutHandler(event:FocusEvent):void { //change back to default values
			var index:int = parseInt(event.target.name.charAt(event.target.name.length - 1));
			if(event.target.text == ""){
				event.target.text = defaultTexts[index];
			}			
		}
		
		private function textFields_focusInHandler(event:FocusEvent):void { //empty text fileds on focus
			TextField(event.target).textColor = defaultTextColor;
			var index:int = parseInt(event.target.name.charAt(event.target.name.length - 1));
			if(event.target.text == defaultTexts[index]){
				event.target.text = "";
			}
		}
		
	}
}