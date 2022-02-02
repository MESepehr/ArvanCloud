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
    import src.api.regions.Regions;
    import com.mteamapp.StringFunctions;

    public class Core
    {
        private static var selectet_token_index:int = -1 ;
        private static var allTokens:Vector.<TokenData> ;

        private static const id_key:String = "id_key";

        private static const id_keys:String = "id_keys",
                            id_selectedKeyIndex:String = id_selectedKeyIndex;

        private static var _onStatusChanged:Function ;

        private static var service_regions:Regions;

        public static var regions:Array = [];

        public static function setUp(onStatusChanged:Function):void
        {
            var _key:String = GlobalStorage.load(id_key);
            _onStatusChanged = onStatusChanged ;
            
            var loadedIndex:* = GlobalStorage.load(id_selectedKeyIndex);
            if(loadedIndex!=null)
            {
                selectet_token_index = loadedIndex ;
            }

            allTokens = GlobalStorage.loadObject(id_keys,new Vector.<TokenData>());
            if(allTokens==null)
            {
                allTokens = new Vector.<TokenData>();
                if(_key!=null)
                {
                    setToken('untitled',_key);
                }
            }
            GlobalStorage.save(id_key,null);

            if(getKey()!=null)
            {
                RestDoaService.addHeader("Authorization",getKey());
                setTimeout(loadRegions,0);
            }

            setTimeout(onStatusChanged,0);
        }

        private static function loadRegions():void
        {
            service_regions = new Regions();
            service_regions.load().onConnected(setRegions);
        }

            private static function setRegions():void
            {
                regions = [];
                for(var i:int = 0 ; i<service_regions.data.data.length ; i++)
                {
                    if(service_regions.data.data[i].soon!=true)
                        regions.push(service_regions.data.data[i].code);
                }
                _onStatusChanged();
            }

        private static function setToken(title:String,token:String):void
        {
            for(var i:int = 0 ; i<allTokens.length ; i++)
            {
                if(allTokens[i].token == token)
                {
                    allTokens[i].title = title ;
                    selectet_token_index = i ;
                    GlobalStorage.save(id_selectedKeyIndex,selectet_token_index,false);
                    GlobalStorage.saveObject(id_keys,allTokens);
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
                _onStatusChanged();
            }
            else
            {
                if(StringFunctions.isNullOrEmpty(title))title = MyShamsi.miladiToShamsi(new Date()).showStringFormat(true,false);
                setToken(title,key)
                RestDoaService.addHeader("Authorization",key);
                loadRegions();//This function will call onStatusChange function at final phase
            }

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
            if(allTokens!=null && allTokens.length>selectet_token_index)
            {
                return allTokens[selectet_token_index];
            }
            return null ;
        }

        private static function getKey():String
        {
            var tokObject:TokenData = getTokenObject();
            if(tokObject!=null)
                return tokObject.token ;
            return null;
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