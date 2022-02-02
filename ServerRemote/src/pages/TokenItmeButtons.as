package src.pages
//src.pages.TokenItmeButtons
{
    import contents.displayPages.LinkItemButtons;
    import contents.LinkData;
    import src.TokenData;
    import src.Core;
    import flash.display.MovieClip;

    public class TokenItmeButtons extends LinkItemButtons
    {
        private var data:TokenData ;

        private var deleteMC:MovieClip,
                    editM:MovieClip;

        public function TokenItmeButtons()
        {
            super();
            deleteMC = Obj.get('delete_mc',this);
            editM = Obj.get("edit_mc",this);
            Obj.setButton(deleteMC,deleteMe);
            Obj.setButton(editM,editMe);
        }

        override public function setUp(linkData:LinkData):void
        {
            data = linkData.dynamicData as TokenData ;
        }

        private function editMe():void
        {
            Login.edit(data.title,data.token);
        }

        private function deleteMe():void
        {
            Core.removeToken(data);
            this.alpha = 0.5 ;
        }

        

    }
}