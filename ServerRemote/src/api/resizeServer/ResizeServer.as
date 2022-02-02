package src.api.resizeServer
{
	import restDoaService.RestDoaServiceCaller;
	import contents.alert.Alert;
	
	public class ResizeServer extends RestDoaServiceCaller
	{
		public var data:ResizeServerRespond = new ResizeServerRespond();
		
		/***/
		public function ResizeServer(region:String,id:String)
		{
			super('/ecc/v1/regions/'+region+'/servers/'+id+'/resize', data, false, false, null,false);
		}
		
		/**"g1-16-8-125" */
		public function load(ramIngGig:uint,cpuInCore:uint,hardInGit:uint):RestDoaServiceCaller
		{
			var newSizeId:String = 'g1-'+ramIngGig+'-'+cpuInCore+'-'+hardInGit;
			Alert.show('درخواست تغییر اندازه '+newSizeId+' ارسال شد.')
			super.loadParam({flavor_id:newSizeId});
			return this;
		}
	}
}