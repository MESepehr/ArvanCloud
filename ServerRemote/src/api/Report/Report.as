package src.api.Report
{
	import restDoaService.RestDoaServiceCaller;
	
	public class Report extends RestDoaServiceCaller
	{
		public var data:ReportRespond = new ReportRespond() ;
		
		/***/
		public function Report(region:String,id:String)
		{
			super('/ecc/v1/regions/'+region+'/reports/'+id, data, true, false, null, true);
		}
		
		public function load(period:String='1h'):RestDoaServiceCaller
		{
			super.loadParam({period:period});
			return this;
		}
	}
}