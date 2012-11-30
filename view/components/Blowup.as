/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.components {
	import com.greensock.TweenMax;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import model.valueObjects.ArtworkVO;
	
	import view.events.BlowupEvent;
	
	public class Blowup extends MovieClip {
		
		private var artworkVO:ArtworkVO;
		
		public static const OFFSET:int = 5;
		
		private var date:TextField;
		private var title:TextField;
		private var description:TextField;
		private var close:MovieClip;
		private var background:Sprite;
		
		private var loader:Loader;
		private var image:Sprite;
		private var loadProgress:Sprite;
		
		public function Blowup() { 
			date = this.getChildByName("_date") as TextField;
			title = this.getChildByName("_title") as TextField;
			description = this.getChildByName("_description") as TextField;
			background = this.getChildByName("_background") as Sprite;
			close = this.getChildByName("_close") as MovieClip;
			loadProgress = this.getChildByName("_loadProgress") as Sprite;
			image = this.getChildByName("_image") as Sprite;
			
			loadProgress.scaleX = 0;
			
			close.addEventListener(MouseEvent.MOUSE_DOWN, close_mouseDownHandler);
			close.buttonMode = true;
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, artwork_progressHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, artwork_completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, artwork_IOErrorHandler);
		}
		
		public function load(artworkVO:ArtworkVO):void {
			this.artworkVO = artworkVO;
			loader.load(new URLRequest(artworkVO.image));
		}
		
		private function artwork_completeHandler(event:Event):void {
			loader.x = (ApplicationConstants.STAGE_WIDTH - loader.width)/2
				
			image.addChild(loader);
			
			date.text = artworkVO.date;
			title.text = artworkVO.title.substr(0, ApplicationConstants.TITLE_CHARACTER_LIMIT);
			description.text = artworkVO.description.substr(0, ApplicationConstants.DESCRIPTION_CHARACTER_LIMIT);
			
			date.x = loader.x + OFFSET;
			title.x = loader.x + OFFSET;
			if(artworkVO.title != ""){
				description.x = title.x + title.textWidth + OFFSET;
			} else {
				description.x = title.x;
			}

			image.buttonMode = true;
			
			TweenMax.to(background, .5, {x:(ApplicationConstants.STAGE_WIDTH - loader.content.width)/2, width:loader.content.width});
			
			TweenMax.from(loader, .5, {alpha: 0, delay:.5});
			TweenMax.from(date, .5, {alpha: 0, delay:.5});
			TweenMax.from(title, .5, {alpha: 0, delay:.5});
			TweenMax.from(description, .5, {alpha: 0, delay:.5});
		}
		
		public function unload():void {
			while(image.numChildren){
				image.removeChildAt(0);
			}
			loadProgress.scaleX = 0;
			loadProgress.alpha = 1;
		}
		
		private function close_mouseDownHandler(event:MouseEvent):void {
			dispatchEvent(new BlowupEvent(BlowupEvent.CLOSE));
		}
		
		private function artwork_progressHandler(event:ProgressEvent):void {
			loadProgress.scaleX = event.bytesLoaded/event.bytesTotal;
			if(loadProgress.scaleX >= 1){
				TweenMax.to(loadProgress, .5, {alpha: 0, delay:.5});
			}
		}
		
		private function artwork_IOErrorHandler(event:IOErrorEvent):void {
			trace("Failed to load", artworkVO.image);
		}

	}
}