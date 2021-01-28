package
{
    import flash.display.MovieClip;
    import stageManager.StageManager;
    import src.Core;
    import src.pages.Login;
    import src.pages.ServerList;
    import restDoaService.RestDoaServiceCaller;
    import restDoaService.RestDoaService;

    public class Main extends MovieClip
    {
        private var loginPage:Login ;

        private var serverList:ServerList ;

        public function Main()
        {
            Core.setUp(pageStatusChanged);
            super();

            RestDoaService.setUp('https://napi.arvancloud.com');

            StageManager.setUp(stage);
            StageManager.add('api_key',0,1);

            loginPage = Obj.findThisClass(Login,this);
            serverList = Obj.findThisClass(ServerList,this);

        }

        private function pageStatusChanged():void
        {
            if(Core.haveKey())
            {
                loginPage.visible = false ;
                serverList.visible = true ;
            }
            else
            {
                loginPage.visible = true ;
                serverList.visible = false ;
            }
        }
    }
}