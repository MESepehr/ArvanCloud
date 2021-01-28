package src.pages
//src.pages.ServerItem  
{
    import contents.displayPages.LinkItem;
    import flash.events.MouseEvent;
    import contents.LinkData;
    import appManager.displayContentElemets.TitleText;

    public class ServerItem extends LinkItem
    {
        private var titleMC:TitleText ;

        public function ServerItem()
        {
            super(true,false);
            titleMC = Obj.get("title_mc",this);
        }

        override public function setUp(linkData:LinkData):void
        {

        }

        override public function imSelected(event:MouseEvent = null):void{}
    }
}