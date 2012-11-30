/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package model.valueObjects {
	public class ArtworkVO {
		
		public var id:int;
		public var title:String;
		public var description:String;
		public var date:String;
		public var thumbnail:String;
		public var image:String;
		
		public function ArtworkVO() {
		}
		
		public function toString():String {
			return String([id, title, description, date, thumbnail, image]);
		}
	}
}