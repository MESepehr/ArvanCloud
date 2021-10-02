package src.pages
//src.pages.ServerList
{
    import flash.display.MovieClip;
    import contents.displayPages.DynamicLinks;
    import stageManager.StageManager;
    import contents.displayElements.SaffronPreLoader;
    import src.Core;
    import src.api.FindServers.ServersList2.ServersList2;
    import contents.LinkData;
    import contents.PageData;
    import contents.alert.Alert;
    import flash.utils.setTimeout;
    import flash.desktop.NativeApplication;
    import flash.events.Event;
    import flash.utils.clearTimeout;
    import flash.display.DisplayObject;

    public class ServerList extends MovieClip
    {
        private var list:DynamicLinks ;

        private var preloaderMC:SaffronPreLoader ;

        private var outMC:MovieClip ;

        private var service_getServers1:ServersList2 ;
        private var service_getServers2:ServersList2 ;
        private var service_getServers3:ServersList2 ;
        private var service_getServers4:ServersList2 ;

        private var timeoutId:uint = 0 ;
        
        public function ServerList()
        {
            super();


            outMC = Obj.get("out_mc",this);
            Obj.setButton(outMC,logOut);

            list = Obj.get("list_mc",this);
            preloaderMC = Obj.findThisClass(SaffronPreLoader,this);

            NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,reload,false,-100000);
        }

        private function logOut():void
        {
            Core.clearKey();
        }

        override public function set visible(value:Boolean):void
        {
            super.visible = value ;
            if(value)
            {
                list.height = StageManager.stageRect.height-list.y ;
                this.y = StageManager.stageDelta.height/-2 ;

                preloaderMC.y = StageManager.stageRect.height/2;

                reload();
            }
        }

        private function reload(e:*=null):void
        {
            if(super.visible==false || !DevicePrefrence.isApplicationActive)
            {
                preloaderMC.visible = false ;   
                return;
            }

            clearTimeout(timeoutId);
            preloaderMC.visible = true ;


            if(service_getServers1)service_getServers1.cancel();
            if(service_getServers2)service_getServers2.cancel();
            if(service_getServers3)service_getServers3.cancel();
            if(service_getServers4)service_getServers4.cancel();


                service_getServers1 = new ServersList2(Core.region1);
                service_getServers1.load().then(finalListLoaded).catchAndReload();

                service_getServers2 = new ServersList2(Core.region2)
                service_getServers2.load().then(finalListLoaded).catchAndReload();

                service_getServers3 = new ServersList2(Core.region3)
                service_getServers3.load().then(finalListLoaded).catchAndReload();

                service_getServers4 = new ServersList2(Core.region4)
                service_getServers4.load().then(finalListLoaded).catchAndReload();

            function finalListLoaded():void
            {
                preloaderMC.visible = false ;

                var cashedServersList:PageData = new PageData();
                if(service_getServers1!=null)cashedServersList.links1 = cashedServersList.links1.concat(service_getServers1.pageData().links1) ;
                if(service_getServers2!=null)cashedServersList.links1 = cashedServersList.links1.concat(service_getServers2.pageData().links1) ;
                if(service_getServers3!=null)cashedServersList.links1 = cashedServersList.links1.concat(service_getServers3.pageData().links1) ;
                if(service_getServers4!=null)cashedServersList.links1 = cashedServersList.links1.concat(service_getServers4.pageData().links1) ;

                if(list.pageData==null || list.pageData.links1.length<=cashedServersList.links1.length)
                    list.setUpOrUpdate(cashedServersList);

                clearTimeout(timeoutId);
                timeoutId = setTimeout(reload,5000);
            }
        }
    }
}