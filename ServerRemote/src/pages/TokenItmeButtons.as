package src.pages
//src.pages.TokenItmeButtons
{
    import contents.displayPages.LinkItemButtons;
    import contents.LinkData;
    import src.TokenData;
    import src.Core;

    public class TokenItmeButtons extends LinkItemButtons
    {
        private var data:TokenData ;

        public function TokenItmeButtons()
        {
            super();
            Obj.setButton(this,deleteMe);
        }

        override public function setUp(linkData:LinkData):void
        {
            data = linkData.dynamicData as TokenData ;
        }

        private function deleteMe():void
        {
            Core.removeToken(data);
            this.alpha = 0.5 ;
        }

        

    }
}