/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package {
	import flash.display.Sprite;
	
	import view.components.Gallery;
	import view.components.SWF;
	
	public class Katya extends Sprite {
		
		public var menu:Sprite;
		public var gallery:Gallery;
		public var swf:SWF;
		
		private var block:Sprite;
		
		public function Katya() {
			menu = this.getChildByName("_menu") as Sprite;
			gallery = this.getChildByName("_gallery") as Gallery;
			swf = this.getChildByName("_swf") as SWF;
			
			var facade:ApplicationFacade = ApplicationFacade.getInstance();
			facade.startup(this);
		}
		
		public function addGallery():void {
			gallery.visible = true;
		}
		
		public function removeGallery():void {
			gallery.visible = false;
		}
		
		public function addSWF():void {
			swf.visible = true;
		}
		
		public function removeSWF():void {
			swf.visible = false;
		}
		
	}
}