package src.pages
//src.pages.ServerList
{
    import flash.display.MovieClip;
    import contents.displayPages.DynamicLinks;
    import stageManager.StageManager;
    import contents.displayElements.SaffronPreLoader;
    import src.Core;

    public class ServerList extends MovieClip
    {
        private var list:DynamicLinks ;

        private var preloaderMC:SaffronPreLoader ;

        private var outMC:MovieClip ;
        
        public function ServerList()
        {
            super();

            outMC = Obj.get("out_mc",this);
            Obj.setButton(outMC,logOut);

            list = Obj.get("list_mc",this);
            preloaderMC = Obj.findThisClass(SaffronPreLoader,this);
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

        private function reload():void
        {
            preloaderMC.visible = true ;
        }
    }
}