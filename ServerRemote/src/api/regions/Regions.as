package src.api.regions
{
	import restDoaService.RestDoaServiceCaller;
	
	public class Regions extends RestDoaServiceCaller
	{
		public var data:RegionsRespond = new RegionsRespond() ;
		
		/***/
		public function Regions()
		{
			var date:Date = new Date();
			date.date = date.date-7 ;
			super('/ecc/v1/regions', data, true, true, date, true);
		}
		
		public function load():RestDoaServiceCaller
		{
			super.loadParam();
			return this;
		}
	}
}