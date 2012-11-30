/**
* @author Saad Shams :: sshams@live.com
* Copy or reuse is prohibited.
* */
package controller {
	import model.SWFAddressProxy;
	import model.WorksProxy;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;
	
	import view.mediators.ArtworksMediator;
	import view.mediators.BlowupMediator;
	import view.mediators.GalleryMediator;
	import view.mediators.KatyaMediator;
	import view.mediators.MenuMediator;
	import view.mediators.SWFMediator;
	import view.mediators.SubmenuMediator;
	
	public class StartupCommand extends SimpleCommand implements ICommand {
		
		override public function execute(notification:INotification):void {
			
			facade.registerProxy(new SWFAddressProxy());
			facade.registerProxy(new WorksProxy());
			
			var katya:Katya = notification.getBody() as Katya;
			facade.registerMediator(new KatyaMediator(katya));
			facade.registerMediator(new MenuMediator(katya.menu));
			facade.registerMediator(new GalleryMediator(katya.gallery));
			facade.registerMediator(new ArtworksMediator(katya.gallery.artworks));
			facade.registerMediator(new BlowupMediator(katya.gallery.blowup));
			facade.registerMediator(new SubmenuMediator(katya.gallery.submenu));
			facade.registerMediator(new SWFMediator(katya.swf));
			
		}
		
	}
}