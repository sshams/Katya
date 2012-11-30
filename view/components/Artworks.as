/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.components {
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import model.valueObjects.ArtworkVO;
	
	import view.events.ArtworkEvent;
	
	public class Artworks extends MovieClip {
		
		private var artworkVOs:Array;
		private var artworks:Array = [];
		private var artworksOriginalX:Array = [];
		private var artworkVO:ArtworkVO;
		private var artwork:Artwork;
		
		private var direction:int;
		private var left:int = 0;
		private var right:int = 0;
		
		private var hotspot:Sprite;
		
		private var originalX:int;
		
		public function Artworks() {
			hotspot = this.getChildByName("_hotspot") as Sprite;
			originalX = this.x;
		}
		
		public function populate(artworkVOs:Array):void {
			this.artworkVOs = artworkVOs;
			var xPosition:int = 0;
			
			for(var i:int=0; i < artworkVOs.length; i++){
				var artwork:Artwork = new Artwork();
				artwork.loadArtwork(artworkVOs[i]);
				
				artwork.name = "_" + i;
				artwork.x = xPosition;
				xPosition += ApplicationConstants.ARTWORK_WIDTH + ApplicationConstants.ARTWORK_GAP;
				
				artwork.addEventListener(ArtworkEvent.ARTWORK_EVENT, artwork_artworkEventHandler);
				addChild(artwork);
				artworks.push(artwork);
			}

			if(artworks.length > ApplicationConstants.ARTWORKS_PER_SCREEN){
				this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		private function enterFrameHandler(event:Event):void {
			if( hotspot.localToGlobal(new Point(hotspot.x, hotspot.y)).y - hotspot.y > stage.mouseY ){
				return;
			}
			if(hotspot.localToGlobal(new Point(hotspot.x, hotspot.y + hotspot.height)).y - hotspot.y < stage.mouseY){
				return;
			}
			
			direction = (ApplicationConstants.STAGE_WIDTH/2 - stage.mouseX)/50;

			if(this.x >= 0 && direction > 0) {
				direction = 0;
				this.x = 0;
			} else if( Math.abs(this.x) >= (this.width - ApplicationConstants.STAGE_WIDTH) && direction < 0) {
				direction = 0;
			}
			
			this.x += direction;
		}
		
		private function artwork_artworkEventHandler(event:ArtworkEvent):void {
			artwork = event.target as Artwork;
			artworkVO = event.artworkVO;
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			this.scatter();
		}
		
		private function scatter():void {
			left = globalToLocal(new Point(-ApplicationConstants.ARTWORK_WIDTH - 1, this.y)).x;
			right = globalToLocal(new Point(ApplicationConstants.STAGE_WIDTH, this.y)).x;

			
			for(var i:int=0; i<artworks.length; i++){
				artworksOriginalX.push(artworks[i].x);
				
				if(localToGlobal(new Point(artworks[i].x, artworks[i].y)).x < stage.stageWidth/2){
					TweenMax.to(artworks[i], .5, {x:left, onComplete:(i==artworks.length-1) ? scatter_completeHandler : null});
				} else {
					TweenMax.to(artworks[i], .5, {x:right, onComplete:(i==artworks.length-1) ? scatter_completeHandler : null});
				}
			}
		}
		
		private function scatter_completeHandler():void {
			dispatchEvent(new ArtworkEvent(ArtworkEvent.ARTWORK_EVENT, artworkVO));
			var id:int = artwork.name.split("_")[1];

			if(id>0){
				artworks[id-1].x = left;
				TweenMax.to(artworks[id-1], .5, {x:left + ApplicationConstants.ARTWORK_WIDTH, delay:.25});
				TweenMax.to(artworks[id-1], .2, {colorMatrixFilter:{colorize:0x8e8579, amount:1}, alpha:.2});
				
				Sprite(artworks[id-1]).addEventListener(MouseEvent.MOUSE_OVER, artwork_mouseOverHandler);
				Sprite(artworks[id-1]).addEventListener(MouseEvent.MOUSE_OUT, artwork_mouseOutHandler);
			}
			
			if(id < artworks.length-1){
				artworks[id+1].x = right
				TweenMax.to(artworks[id+1], .5, {x:right - ApplicationConstants.ARTWORK_WIDTH, delay:.25});
				TweenMax.to(artworks[id+1], .2, {colorMatrixFilter:{colorize:0x8e8579, amount:1}, alpha:.2});
				
				Sprite(artworks[id+1]).addEventListener(MouseEvent.MOUSE_OVER, artwork_mouseOverHandler);
				Sprite(artworks[id+1]).addEventListener(MouseEvent.MOUSE_OUT, artwork_mouseOutHandler);
			}
		}
		
		public function unscatter():void {
			this.removeFilters();
			
			for(var i:int=0; i<artworks.length; i++){
				if(localToGlobal(new Point(artworksOriginalX[i], 0)).x <= ApplicationConstants.STAGE_WIDTH/2){
					artworks[i].x = left;
				} else {
					artworks[i].x = right;
				}
				
				TweenMax.to(artworks[i], .5, {x:artworksOriginalX[i], onComplete:(i==artworks.length-1) ? unscatter_completeHandler : null});
			}
		}
		
		private function unscatter_completeHandler():void {
			if(artworks.length > ApplicationConstants.ARTWORKS_PER_SCREEN){
				this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		public function clear():void {
			for(var i:int=0; i<artworks.length; i++){
				artworks[i].removeEventListener(ArtworkEvent.ARTWORK_EVENT, artwork_artworkEventHandler);
				removeChild(artworks[i]);
			}
			if(artworks){
				artworks = [];
				artworksOriginalX = [];
			}
			this.x = originalX;
			
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function removeFilters():void {
			for(var i:int=0; i<artworks.length; i++){
				TweenMax.to(artworks[i], .2, {colorMatrixFilter:{}});
				Sprite(artworks[i]).alpha = 1;
				
				Sprite(artworks[i]).removeEventListener(MouseEvent.MOUSE_OVER, artwork_mouseOverHandler);
				Sprite(artworks[i]).removeEventListener(MouseEvent.MOUSE_OUT, artwork_mouseOutHandler);
			}
		}
		
		private function artwork_mouseOverHandler(event:MouseEvent):void {
			Sprite(event.currentTarget).filters = [];
			Sprite(event.currentTarget).alpha = 1;
		}
		
		private function artwork_mouseOutHandler(event:MouseEvent):void {
			TweenMax.to(event.currentTarget, .2, {colorMatrixFilter:{colorize:0x8e8579, amount:1}, alpha:.2});
		}
		
	}
}