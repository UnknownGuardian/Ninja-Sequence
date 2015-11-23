package CPMStar {
	public class AdLoader {
		import flash.display.*;
		import flash.net.*;
		import flash.system.*;
		
		private static var cpmstarLoader:Loader;
		public static function LoadAd(poolid:int, subpoolid:int):DisplayObject {
			Security.allowDomain("server.cpmstar.com");
			var cpmstarViewSWFUrl:String = "http://server.cpmstar.com/adviewas3.swf";
			cpmstarLoader = new Loader();
			cpmstarLoader.load(new URLRequest(cpmstarViewSWFUrl + "?poolid="+poolid+"&subpoolid="+subpoolid));
			return cpmstarLoader;
		}
	}
}
