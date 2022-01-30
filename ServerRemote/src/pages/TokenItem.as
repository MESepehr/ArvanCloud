package src.pages
//src.pages.TokenItem
{
    import contents.displayPages.LinkItem;
    import contents.LinkData;
    import src.TokenData;
    import flash.display.MovieClip;
    import appManager.displayContentElemets.TitleText;

    public class TokenItem extends LinkItem
    {
        private var data:TokenData ;

        private var backMC:MovieClip,
                    titleMC:TitleText ;

        public function TokenItem()
        {
            super(false,false);
            backMC = Obj.get("back_mc",this);
            titleMC = Obj.get("title_mc",this);
        }

        override public function setUp(linkData:LinkData):void
        {
            data = linkData.dynamicData as TokenData;
            backMC.gotoAndStop((getIndex()%2)+1);
            titleMC.text = data.title ;
        }
    }
}