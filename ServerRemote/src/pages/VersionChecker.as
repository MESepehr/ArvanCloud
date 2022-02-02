package src.pages
{
    import flash.display.MovieClip;
    import appManager.displayContentElemets.TitleText;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLLoaderDataFormat;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.filesystem.File;
    import flash.net.navigateToURL;

    public class VersionChecker extends MovieClip
    {
        private var text:TitleText;

        public function VersionChecker()
        {
            var me:VersionChecker = this ;
            super();
            this.visible = false ;
            text = Obj.findThisClass(TitleText,this);
            text.setUp('New version available...',false);

            Obj.setButton(this,downloadLastVersion);

            var urlLoader:URLLoader = new URLLoader(new URLRequest("https://raw.githubusercontent.com/MESepehr/ArvanCloud/master/ServerRemote/Remote-app.xml?"+new Date().time));
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT ;
			urlLoader.addEventListener(Event.COMPLETE,function(e:*):void{
				var versionPart:Array = String(urlLoader.data).match(/<versionNumber>.*<\/versionNumber>/gi);
				if(versionPart.length>0)
				{
					versionPart[0] = String(versionPart[0]).split('<versionNumber>').join('').split('</versionNumber>').join('');
					trace("version loaded : "+versionPart[0]+' > '+(DevicePrefrence.appVersion==versionPart[0]));
					trace("DevicePrefrence.appVersion : "+DevicePrefrence.appVersion);
					if(!(DevicePrefrence.appVersion==versionPart[0]))
					{
						me.visible = true ;
						me.alpha = 0 ;
						AnimData.fadeIn(me);
					}
				}
			});
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,function(e:*):void{});
        }

        private function downloadLastVersion():void
        {
            navigateToURL(new URLRequest("https://github.com/MESepehr/ArvanCloud/raw/master/ServerRemote/Arvan.apk"));
        }
    }
}