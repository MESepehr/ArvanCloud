package src.pages
//src.pages.ServerList
{
    import flash.display.MovieClip;
    import contents.displayPages.DynamicLinks;
    import stageManager.StageManager;
    import contents.displayElements.SaffronPreLoader;
    import src.Core;
    import src.api.FindServers.ServersList2.ServersList2;
    import contents.PageData;
    import flash.utils.setTimeout;
    import flash.desktop.NativeApplication;
    import flash.events.Event;
    import flash.utils.clearTimeout;
    import appManager.displayContentElemets.TitleText;
    import src.api.Finance.Finance;
    import com.mteamapp.StringFunctions;

    public class ServerList extends MovieClip
    {
        private var list:DynamicLinks ;

        private var preloaderMC:SaffronPreLoader ;

        private var outMC:MovieClip ;

        private var walletTXT:TitleText,
                    invoiceTXT:TitleText;

        private var services:Vector.<ServersList2> = new Vector.<ServersList2>();

        private var timeoutId:uint = 0 ;

        private var service_finance:Finance ;
        
        public function ServerList()
        {
            super();


            outMC = Obj.get("out_mc",this);
            Obj.setButton(outMC,logOut);

            walletTXT = Obj.get("wallet_txt",this);
            invoiceTXT = Obj.get("invoice_txt",this);

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
                list.setUp(new PageData());

                reload();
            }
        }

        private function showFinanceDetail():void
        {
            walletTXT.setUp(StringFunctions.currancyPrint(Math.round(service_finance.data.data.totalBalance/10)),false);
            invoiceTXT.setUp(StringFunctions.currancyPrint(Math.round(service_finance.data.data.currentInvoicePrice/10)),false);
        }

        private function reload(e:*=null):void
        {
            if(super.visible==false || !DevicePrefrence.isApplicationActive)
            {
                preloaderMC.visible = false ;   
                return;
            }

            service_finance = new Finance();
            service_finance.load().onConnected(showFinanceDetail)

            clearTimeout(timeoutId);
            preloaderMC.visible = true ;

            for(var i:int = 0 ; i<Core.regions.length ; i++)
            {
                if(services.length>i && services[i])
                {
                    services[i].cancel();
                }
                services[i] = new ServersList2(Core.regions[i]);
                services[i].load().then(finalListLoaded).catchAndReload();
            }


            function finalListLoaded():void
            {
                preloaderMC.visible = false ;

                var cashedServersList:PageData = new PageData();

                for(var i:int = 0 ; i<services.length ; i++)
                {
                    if(services[i]!=null)cashedServersList.links1 = cashedServersList.links1.concat(services[i].pageData().links1) ;
                }

                if(list.pageData==null || list.pageData.links1.length<=cashedServersList.links1.length)
                    list.setUpOrUpdate(cashedServersList);

                clearTimeout(timeoutId);
                timeoutId = setTimeout(reload,5000);
            }
        }
    }
}