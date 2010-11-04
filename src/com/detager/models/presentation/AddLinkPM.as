package com.detager.models.presentation
{
	public class AddLinkPM
	{
		
		[Inject(source="applicationModel.currentUrl")]
		public function set currentUrl(value:String):void
		{
			
		}
		
		[PostConstruct]
		public function postConstruct():void
		{
			
		}
	}
}