package src.api.powerOn
{
	import restDoaService.RestDoaServiceCaller;
	
	public class PowerOn extends RestDoaServiceCaller
	{
		public var data:PowerOnRespond = new PowerOnRespond();
		
		/***/
		public function PowerOn(region:String,id:String)
		{
			super('/ecc/v1/regions/'+region+'/servers/'+id+'/power-on', data, false, false, null, false);
		}
		
		public function load():RestDoaServiceCaller
		{
			super.loadParam();
			return this;
		}
	}
}