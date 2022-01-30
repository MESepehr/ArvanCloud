package src.api.Finance
{
	import restDoaService.RestDoaServiceCaller;
	
	public class Finance extends RestDoaServiceCaller
	{
		public var data:FinanceRespond = new FinanceRespond() ;
		
		/***/
		public function Finance()
		{
			super('/resid/v1/wallets/me', data, true, true, new Date(new Date().time-10*60*60*1000), true);
		}
		
		public function load():RestDoaServiceCaller
		{
			super.loadParam();
			return this;
		}
	}
}