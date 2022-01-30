package src
{
    import dataManager.GlobalStorage;
    import flash.utils.setTimeout;
    import restDoaService.RestDoaService;
    import flash.system.System;
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import diagrams.calender.MyShamsi;
    import contents.PageData;
    import contents.LinkData;

    public class Core
    {
        private static var selectet_token_index:int = -1 ;
        private static var allTokens:Vector.<TokenData> ;

        private static const id_key:String = "id_key";

        private static const id_keys:String = "id_keys",
                            id_selectedKeyIndex:String = id_selectedKeyIndex;

        private static var _onStatusChanged:Function ;

        private static const region1:String = "ir-thr-mn1";
        private static const region2:String = "ir-thr-at1";
        private static const region3:String = "nl-ams-su1";
        private static const region4:String = "ir-thr-fr1";

        public static var regions:Array = [region1,region2,region3,region4];

        public static function setUp(onStatusChanged:Function):void
        {
            var _key:String = GlobalStorage.load(id_key);
            _onStatusChanged = onStatusChanged ;

            allTokens = GlobalStorage.loadObject(id_keys,new Vector.<TokenData>());
            if(allTokens==null)
            {
                allTokens = new Vector.<TokenData>();
                if(_key!=null)
                {
                    setToken('untitled',_key);
                }
            }
            var loadedIndex:* = GlobalStorage.load(id_selectedKeyIndex);
            if(loadedIndex!=null)
            {
                selectet_token_index = loadedIndex ;
            }

            RestDoaService.addHeader("Authorization",_key);

            setTimeout(onStatusChanged,0);
        }

        private static function setToken(title:String,token:String):void
        {
            for(var i:int = 0 ; i<allTokens.length ; i++)
            {
                if(allTokens[i].token == token)
                {
                    selectet_token_index = i ;
                    GlobalStorage.save(id_selectedKeyIndex,selectet_token_index);
                    return;
                }
            }
            var currentToken:TokenData = new TokenData();
            currentToken.title = title ;
            currentToken.token = token ;
            allTokens.unshift(currentToken);
            selectet_token_index = 0 ;
            GlobalStorage.saveObject(id_keys,allTokens);
        }

        public static function removeToken(tok:TokenData):void
        {  
            for(var i:int = 0 ; i<allTokens.length ; i++)
            {
                if(allTokens[i].token == tok.token)
                {
                    allTokens.removeAt(i);
                    selectet_token_index = -1 ;
                    GlobalStorage.save(id_selectedKeyIndex,selectet_token_index);
                    GlobalStorage.saveObject(id_keys,allTokens);
                    return;
                }
            }
        }

        public static function setKey(key:String,title:String=null):void
        {
            if(key==null)
            {
                selectet_token_index = -1 ;
                RestDoaService.removeHeader("Authorization");
            }
            else
            {
                if(title==null)title = MyShamsi.miladiToShamsi(new Date()).showStringFormat(true,false);
                setToken(title,key)
                RestDoaService.addHeader("Authorization",key);
            }

            _onStatusChanged();
        }

        public static function allTokenPageData():PageData
        {
            var page:PageData = new PageData();

            for(var i:int = 0 ; i<allTokens.length ; i++)
            {
                page.links1.push(new LinkData().createLinkFor(null,allTokens[i]));
            }

            return page ;
        }

        public static function getTokenObject():TokenData
        {
            if(allTokens!=null && allTokens.length<selectet_token_index)
            {
                return allTokens[selectet_token_index];
            }
            return null ;
        }

        private static function getKey():String
        {
            return getTokenObject().token ;
            //It will throw error
        }

        public static function clearKey():void
        {
            setKey(null);
        }

        public static function haveKey():Boolean
        {
            return selectet_token_index!=-1 ;
        }
    }
}