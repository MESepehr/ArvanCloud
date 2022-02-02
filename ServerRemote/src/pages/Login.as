package src.pages
//src.pages.Login
{
    import flash.display.MovieClip;
    import popForm.PopField;
    import popForm.PopButton;
    import src.Core;
    import contents.displayPages.DynamicLinks;
    import contents.LinkData;
    import src.TokenData;

    public class Login extends MovieClip
    {
        private var field_token:PopField, field_title:PopField ;

        private var otherTockens:DynamicLinks ;

        private var getTokenLinkMC:MovieClip ;

        private var submitButton:PopButton ;

        private static var me:Login;

        public function Login()
        {
            super();
            me = this ;
            
            field_title = Obj.get("title_mc",this);
            field_token = Obj.get("token_mc",this);

            
            field_title.setUp('عنوان','',null);
            field_token.setUp('توکن','',null,true);

            field_token.onEnterPressed(saveMyToken);

            otherTockens = Obj.get('tockens_mc',this);
            otherTockens.changeDeltaXY(0,0);
            otherTockens.setUp(Core.allTokenPageData());
            otherTockens.onItemSelected(tokenSelected);

            getTokenLinkMC = Obj.get("api_key",this);
            Obj.setURLButton(getTokenLinkMC,"https://npanel.arvancloud.com/profile/api-keys");

            submitButton = Obj.get("button_mc",this);
            submitButton.setUp('ثبت').onClick(saveMyToken);
        }

        public static function edit(title:String,token:String):void
        {
            me.field_title.text = title;
            me.field_token.text = token ;
        }

        private function tokenSelected(linkdata:LinkData):void
        {
            var tok:TokenData = linkdata.dynamicData as TokenData;
            Core.setKey(tok.token,tok.title);
        }

        override public function set visible(value:Boolean):void
        {
            super.visible = value ;
        }

        private function saveMyToken():void
        {
            field_token.changeColor(1);
            if(field_token.text.length==0)
            {
                field_token.changeColor(2);
                return ;
            }
            Core.setKey(field_token.text,field_title.text);
            otherTockens.setUp(Core.allTokenPageData());
        }
    }
}