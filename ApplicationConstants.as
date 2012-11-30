/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package {
	public class ApplicationConstants {
		
		public static const title:String = "Katya Assouad Traboulsi";
		public static const labels:Array = ["Works", "Biography", "Contact"];
		
		public static var currentSubmenu:int = 0;
		public static var worksProxyLoaded:Boolean = false;
		public static var submenuPopulated:Boolean = false;
		
		public static const ARTWORK_GAP:int = 6;
		public static const ARTWORK_WIDTH:int = 135;
		public static const ARTWORKS_PER_SCREEN:int = 7;
		
		public static const TITLE_CHARACTER_LIMIT:int = 40;
		public static const DESCRIPTION_CHARACTER_LIMIT:int = 50;
		
		public static const STAGE_WIDTH:int = 1024;
		
		public static const SUBMENU_DEFAULT_COLOR:uint = 0x585858;
		public static const SUBMENU_HIGHLIGHT_COLOR:uint = 0xd1cabb;
		
		public function ApplicationConstants() {
		}
	}
}