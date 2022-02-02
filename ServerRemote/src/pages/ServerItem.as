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
    import src.api.powerOff.PowerOff;
    import src.api.Report.Report;

    public class ServerItem extends LinkItem
    {
        private var titleMC:TitleText ;

        private var osNameMC:TextField,
                    hardTF:TextField,
                    ramTF:TextField,
                    ramPrecent:Precenter,
                    coreTF:TextField,
                    corePrecent:Precenter ;

        private var statusMC:TextField ;

        private var ipMC:TextField ;

        private var onMC:MovieClip,
                    offMC:MovieClip ;

        private var data:ServersList2ResponddataModel ;

        private var service_poserOn:PowerOn ;
        private var service_poserff:PowerOff ;

        private var service_report:Report ;

        public function ServerItem()
        {
            super(true,false);
            this.buttonMode = false ;
            titleMC = Obj.get("title_mc",this);
            osNameMC = Obj.get("os_mc",this);
            hardTF = Obj.get("hard_mc",this);
            ramTF = Obj.get("ram_mc",this);
                ramPrecent = new Precenter(ramTF.width,ramTF.height);
                ramPrecent.x = ramTF.x;
                ramPrecent.y = ramTF.y;
                this.addChild(ramPrecent);
                this.swapChildren(ramPrecent,ramTF);
                //ramPrecent.setUp(0.4);
            coreTF = Obj.get("core_mc",this);
                corePrecent = new Precenter(coreTF.width,coreTF.height);
                corePrecent.x = coreTF.x;
                corePrecent.y = coreTF.y;
                this.addChild(corePrecent);
                this.swapChildren(corePrecent,coreTF);
                //corePrecent.setUp(0.4);

            ipMC = Obj.get("ip_mc",this);
            statusMC = Obj.get("stat_mc",this);

            onMC = Obj.get("on_mc",this);
            offMC = Obj.get("off_mc",this);

            Obj.setButton(onMC,startServer);
            Obj.setButton(offMC,stopServer);
        }

        private function startServer():void
        {
            if(service_poserOn==null)
            {
                service_poserOn = new PowerOn(data._region,data.id);
                service_poserOn.load().then(showWarningOn).catch2(showNetError);
                Obj.button_disable(onMC);
            }
        }

        private function stopServer():void
        {
            if(service_poserff==null)
            {
                service_poserff = new PowerOff(data._region,data.id);
                service_poserff.load().then(showWarningOff).catch2(showNetError);
                Obj.button_disable(offMC);
            }
        }

        private function showNetError():void
        {
            service_poserOn = null ;
            service_poserff = null ;
            updateButtonInterface();
            Alert.show("No internet connection");
        }

        private function showWarningOn():void
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
            updateButtonInterface();
        }
        private function showWarningOff():void
        {
            if(service_poserff.data.errors!=null)
            {
                Alert.show(service_poserff.data.errors);
            }
            else
            {
                Alert.show(service_poserff.data.message);
            }
            service_poserff = null ;
            updateButtonInterface();
        }

        private function updatePrecent():void
        {
            if(service_report.data.data.charts.ram!=null)
            {
                trace("Used:"+(service_report.data.data.charts.ram.series[0].data[
                    service_report.data.data.charts.ram.series[0].data.length-1
                ]));
                trace("total:"+data.flavor.ram);
                ramPrecent.setUp(service_report.data.data.charts.ram.series[0].data[
                    service_report.data.data.charts.ram.series[0].data.length-1
                ]/(data.flavor.ram*1000*1000));
            }
            if(service_report.data.data.charts.cpu!=null)
            {
                trace("Used:"+(service_report.data.data.charts.cpu.series[0].data[
                    service_report.data.data.charts.cpu.series[0].data.length-1
                ]));
                corePrecent.setUp(service_report.data.data.charts.cpu.series[0].data[
                    service_report.data.data.charts.cpu.series[0].data.length-1
                ]);
            }
        }

        override public function setUp(linkData:LinkData):void
        {
            var newData:ServersList2ResponddataModel = linkData.dynamicData as ServersList2ResponddataModel ;

            if(data==null || (data.name != newData.name))
            {
                if(service_report)service_report.cancel();
                service_report = new Report(newData._region,newData.id);
            }

            data = linkData.dynamicData as ServersList2ResponddataModel ;

            titleMC.setUp(data.name,false);
            osNameMC.text = data.name ;
            hardTF.text = data.flavor.disk+' GB Hard';
            ramTF.text = data.flavor.ram+' MB Ram';
            coreTF.text = data.flavor.vcpus+' Core CPU';
            statusMC.text = data.status ;
            try
            {
                ipMC.text = data.addresses.public1[0].addr+' '+data._region ;
            }
            catch(e:Error)
            {
                try
                {
                    ipMC.text = data.addresses.public210[0].addr+' '+data._region ;
                }
                catch(e:Error)
                {
                    ipMC.text = '' ;
                };
            };

            updateButtonInterface();
        }

        private function updateButtonInterface():void
        {
            if(data.status=='SHUTOFF')
            {
                Obj.button_disable(offMC);
                Obj.button_enable(onMC);
            }
            else if(data.status == 'ACTIVE')
            {
                Obj.button_disable(onMC);
                Obj.button_enable(offMC);

                //service_report.changeOfflineDate(new Date(new Date().time-10*1000));
                if(!service_report.isLoading)
                    service_report.load().onConnected(updatePrecent);
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