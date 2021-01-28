package src.pages
//src.pages.ServerItem  
{
    import contents.displayPages.LinkItem;
    import flash.events.MouseEvent;
    import contents.LinkData;
    import appManager.displayContentElemets.TitleText;
    import src.api.FindServers.ServersList2.ServersList2ResponddataModel;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import src.api.powerOn.PowerOn;
    import contents.alert.Alert;

    public class ServerItem extends LinkItem
    {
        private var titleMC:TitleText ;

        private var osNameMC:TextField ;
        private var statusMC:TextField ;

        private var ipMC:TextField ;

        private var onMC:MovieClip,
                    offMC:MovieClip ;

        private var data:ServersList2ResponddataModel ;

        private var service_poserOn:PowerOn ;

        public function ServerItem()
        {
            super(true,false);
            titleMC = Obj.get("title_mc",this);
            osNameMC = Obj.get("os_mc",this);
            ipMC = Obj.get("ip_mc",this);
            statusMC = Obj.get("stat_mc",this);

            onMC = Obj.get("on_mc",this);
            offMC = Obj.get("off_mc",this);

            Obj.setButton(onMC,startServer);
        }

        private function startServer():void
        {
            if(service_poserOn==null)
            {
                service_poserOn = new PowerOn(data._region,data.id);
                service_poserOn.load().then(showWarning).catch2(showNetError);
                Obj.button_disable(onMC);
            }
        }

        private function showNetError():void
        {
            service_poserOn = null ;
            Alert.show("No internet connection");
        }

        private function showWarning():void
        {
            if(service_poserOn.data.errors!=null)
            {
                Alert.show(service_poserOn.data.errors);
            }
            else
            {
                Alert.show(service_poserOn.data.message);
            }
            service_poserOn = null ;
        }

        override public function setUp(linkData:LinkData):void
        {
            data = linkData.dynamicData as ServersList2ResponddataModel ;

            titleMC.setUp(data.name,false);
            osNameMC.text = data.image.os ;
            statusMC.text = data.status ;
            try
            {
                ipMC.text = data.addresses.public1[0].addr ;
            }
            catch(e:Error)
            {
                ipMC.text = '' ;
            };

            if(data.status=='SHUTOFF')
            {
                Obj.button_disable(offMC);
                Obj.button_enable(onMC);
            }
            else if(data.status == 'ACTIVE')
            {
                Obj.button_disable(onMC);
                Obj.button_enable(offMC);
            }
            else
            {
                Obj.button_disable(onMC);
                Obj.button_disable(offMC);
            }
        }

        override public function imSelected(event:MouseEvent = null):void{}
    }
}