package com.detager.controllers
{
	import com.detager.models.ApplicationModel;
	import com.detager.models.domain.Tag;
	import com.detager.models.domain.TagGroup;
	import com.detager.services.IAppDataService;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	import org.swizframework.utils.services.IServiceHelper;

	public class StartupController
	{
		
		[PostConstruct]
		public function postConstruct():void
		{
		}


	}
}