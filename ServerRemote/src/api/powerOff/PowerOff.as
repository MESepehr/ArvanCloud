package src.api.powerOff
{
	import restDoaService.RestDoaServiceCaller;
	
	public class PowerOff extends RestDoaServiceCaller
	{
		public var data:PowerOffRespond = new PowerOffRespond();
		
		/***/
		public function PowerOff(region:String,id:String)
		{
			super('/ecc/v1/regions/'+region+'/servers/'+id+'/power-off', data, false, false, null, false);
		}
		
		public function load():RestDoaServiceCaller
		{
			super.loadParam();
			return this;
		}
	}
}