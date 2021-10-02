package src
{
    import dataManager.GlobalStorage;
    import flash.utils.setTimeout;
    import restDoaService.RestDoaService;
    import flash.system.System;
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;

    public class Core
    {
        private static var _key:String ;

        private static const id_key:String = "id_key";

        private static var _onStatusChanged:Function ;

        public static const region1:String = "ir-thr-mn1";
        public static const region2:String = "ir-thr-at1";
        public static const region3:String = "nl-ams-su1";
        public static const region4:String = "ir-thr-fr1";

        public static function setUp(onStatusChanged:Function):void
        {
            _key = GlobalStorage.load(id_key);
            _onStatusChanged = onStatusChanged ;

            RestDoaService.addHeader("Authorization",_key);

            setTimeout(onStatusChanged,0);
        }

        public static function setKey(key:String):void
        {
            _key = key ;
            GlobalStorage.save(id_key,_key);
            
            if(_key==null)
                RestDoaService.removeHeader("Authorization");
            else
                RestDoaService.addHeader("Authorization",_key);

            _onStatusChanged();
        }

        public static function getKey():String
        {
            return _key ;
        }

        public static function clearKey():void
        {
            setKey(null)
        }

        public static function haveKey():Boolean
        {
            return _key!=null ;
        }
    }
}