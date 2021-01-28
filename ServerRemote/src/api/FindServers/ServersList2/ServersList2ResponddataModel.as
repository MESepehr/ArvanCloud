package src.api.FindServers.ServersList2
{
	import contents.LinkData;

	public class ServersList2ResponddataModel
	{
		/**"addresses":"[object Object]"*/
		public var addresses:ServersList2ResponddataModeladdressesModel = new ServersList2ResponddataModeladdressesModel()
		/**"ar_next":"null"*/
		public var ar_next:* ;
		/**"created":"2021-01-28T03:12:27Z"*/
		public var created:String ;
		/**"flavor":"[object Object]"*/
		public var flavor:ServersList2ResponddataModelflavorModel = new ServersList2ResponddataModelflavorModel()
		/**"id":"e07c149b-4899-4bca-b540-79068cbe046d"*/
		public var id:String ;
		/**"image":"[object Object]"*/
		public var image:ServersList2ResponddataModelimageModel = new ServersList2ResponddataModelimageModel()
		/**"key_name":"null"*/
		public var key_name:* ;
		/**"name":"mHelli"*/
		public var name:String ;
		/**"password":"null"*/
		public var password:* ;
		/**"security_groups":"[object Object]"*/
		public var security_groups:Vector.<ServersList2ResponddataModelsecurity_groupsModel> = new Vector.<ServersList2ResponddataModelsecurity_groupsModel>()
		/**"status":"SHUTOFF"*/
		public var status:String ;
		/**"tags":""*/
		public var tags:Array = [] ;
		/**"task_state":"null"*/
		public var task_state:* ;

		public var _region:String ;

		
		public function ServersList2ResponddataModel()
		{
		}

		public function linkData(region:String):LinkData
		{
			_region = region ;

			var link:LinkData = new LinkData();
			link.dynamicData = this ;
			return link ;
		}
	}
}