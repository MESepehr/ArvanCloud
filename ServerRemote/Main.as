package
{
    import flash.display.MovieClip;
    import stageManager.StageManager;
    import src.Core;
    import src.pages.Login;

    public class Main extends MovieClip
    {
        private var loginPage:Login ;

        public function Main()
        {
            super();

            Core.setUp(pageStatusChanged);
            StageManager.setUp(stage);
            StageManager.add('api_key',0,1);

            loginPage = Obj.findThisClass(Login,this);
        }

        private function pageStatusChanged():void
        {
            if(Core.haveKey())
            {
                loginPage.visible = false ;
            }
            else
            {
                loginPage.visible = true ;
            }
        }
    }
}