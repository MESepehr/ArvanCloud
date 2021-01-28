package src.api.FindServers.ServersList2
{
	import restDoaService.RestDoaServiceCaller;
	import contents.PageData;
	
	public class ServersList2 extends RestDoaServiceCaller
	{
		public var data:ServersList2Respond = new ServersList2Respond() ;

		private var _region:String ;
		
		/***/
		public function ServersList2(region:String)
		{
			_region = region ;
			super('/ecc/v1/regions/'+region+'/servers', data, false, false, null, true);
		}

		public function pageData(basePage:PageData):PageData
		{
			var page:PageData = basePage;
			for(var i:int= 0 ; data!=null && data.data!=null && i<data.data.length ; i++)
			{
				page.links1.push(data.data[i].linkData(_region))
			}
			return page ;
		}
		
		public function load():RestDoaServiceCaller
		{
			super.loadParam();
			return this;
		}
	}
}