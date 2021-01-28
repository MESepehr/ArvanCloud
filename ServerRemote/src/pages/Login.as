package src.pages
//src.pages.Login
{
    import flash.display.MovieClip;
    import popForm.PopField;
    import popForm.PopButton;
    import src.Core;

    public class Login extends MovieClip
    {
        private var field_token:PopField ;

        private var getTokenLinkMC:MovieClip ;

        private var submitButton:PopButton ;

        public function Login()
        {
            super();
            
            field_token = Obj.get("token_mc",this);
            field_token.setUp('توکن',Core.getKey(),null,true);
            field_token.onEnterPressed(saveMyToken);

            getTokenLinkMC = Obj.get("api_key",this);
            Obj.setButtonLink(getTokenLinkMC,"https://npanel.arvancloud.com/profile/api-keys");

            submitButton = Obj.get("button_mc",this);
            submitButton.setUp('ثبت').onClick(saveMyToken);
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
            Core.setKey(field_token.text);
        }
    }
}