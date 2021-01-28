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

    public class ServerList extends MovieClip
    {
        private var list:DynamicLinks ;

        private var preloaderMC:SaffronPreLoader ;

        private var outMC:MovieClip ;

        private var service_getServers:ServersList2 ;

        private var cashedServersList:PageData;
        
        public function ServerList()
        {
            super();


            outMC = Obj.get("out_mc",this);
            Obj.setButton(outMC,logOut);

            list = Obj.get("list_mc",this);
            preloaderMC = Obj.findThisClass(SaffronPreLoader,this);

            NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,reload);
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
                this.y = StageManager.stageRect.y ;

                preloaderMC.y = StageManager.stageRect.height/2;

                reload();
            }
        }

        private function reload(e:*=null):void
        {
            if(super.visible==false)return;
            preloaderMC.visible = true ;

            if(!DevicePrefrence.isApplicationActive)return;

            if(service_getServers)service_getServers.cancel();
            cashedServersList = new PageData();

            loadFirst();

            function loadFirst():void
            {
                service_getServers = new ServersList2(Core.region1);
                service_getServers.load().then(loadSecond).catchAndReload();
            }

            function loadSecond():void
            {
                cashedServersList = service_getServers.pageData(cashedServersList);
                service_getServers = new ServersList2(Core.region2)
                service_getServers.load().then(loadThird).catchAndReload();
            }

            function loadThird():void
            {
                cashedServersList = service_getServers.pageData(cashedServersList);
                service_getServers = new ServersList2(Core.region3)
                service_getServers.load().then(finalListLoaded).catchAndReload();
            }

            function finalListLoaded():void
            {
                preloaderMC.visible = false ;
                if(service_getServers.data.message!=null)
                {
                    Alert.show(service_getServers.data.message);
                    return;
                }
                cashedServersList = service_getServers.pageData(cashedServersList);
                list.setUpOrUpdate(cashedServersList);

                setTimeout(reload,5000);
            }
        }
    }
}