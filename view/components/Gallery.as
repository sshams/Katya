/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package view.components {
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	
	public class Gallery extends Sprite {
		
		private var artworkClips:Array = [];
		
		public var artworks:Artworks;
		public var blowup:Blowup;
		public var submenu:Submenu;
		
		private var block:Sprite;
		
		public function Gallery() {
			artworks = this.getChildByName("_artworks") as Artworks;
			blowup = this.getChildByName("_blowup") as Blowup;
			submenu = this.getChildByName("_submenu") as Submenu;
			block = this.getChildByName("_block") as Sprite;
			
			removeBlowup();
			
			block.alpha = 0;
			block.visible = false;
		}
		
		public function addBlowup():void {
			addChild(blowup);
		}
		
		public function removeBlowup():void {
			removeChild(blowup);
			blowup.unload();
		}
		
		public function showBlock():void {
			block.visible = true;
			TweenMax.to(block, .5, {alpha:1});
		}
		
		public function hideBlock():void {
			TweenMax.to(block, .5, {alpha:0, onComplete:block_onComplete});
		}
		
		private function block_onComplete():void {
			block.visible = false;
		}
		
	}
}