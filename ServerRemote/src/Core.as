package src
{
    import dataManager.GlobalStorage;

    public class Core
    {
        private static var _key:String ;

        private static const id_key:String = "id_key";

        private static var _onStatusChanged:Function ;

        public static function setUp(onStatusChanged:Function):void
        {
            _key = GlobalStorage.load(id_key);
            _onStatusChanged = onStatusChanged ;
        }

        public static function setKey(key:String):void
        {
            _key = key ;
            GlobalStorage.save(id_key,_key);
            _onStatusChanged();
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