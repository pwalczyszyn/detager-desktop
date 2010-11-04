package com.detager.controllers
{
	import com.detager.models.ApplicationModel;

	public class StartupController
	{
		
		[Inject]
		public var applicationModel:ApplicationModel;
		
		[PostConstruct]
		public function postConstruct():void
		{
			applicationModel.currentState = ApplicationModel.HOME_VIEW_STATE;
		}

	}
}