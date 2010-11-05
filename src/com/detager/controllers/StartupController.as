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
		
		[Inject]
		public var applicationModel:ApplicationModel;
		
		[Inject]
		public var appDataService:IAppDataService;

		[Inject]
		public var serviceHelper:IServiceHelper;
		
		[PostConstruct]
		public function postConstruct():void
		{
			serviceHelper.executeServiceCall(
				appDataService.loadAppData(), 
				loadAppData_resultHandler,
				loadAppData_faultHandler);
		}

		protected function loadAppData_resultHandler(event:ResultEvent):void
		{
			var tagGroups:ArrayCollection = new ArrayCollection();
			for each(var tg:TagGroup in event.result as ArrayCollection)
			{
				var tags:ArrayCollection = new ArrayCollection();
				for each(var t:Tag in tg.tags)
				{
					tags.addItem(new ObjectProxy({name:t.name, tag:t, selected:true}));
				}
				tagGroups.addItem(new ObjectProxy({name:tg.name, tagGroup:tg, tags:tags}));
			}
			
			applicationModel.tagGroups = tagGroups;
			applicationModel.currentState = ApplicationModel.HOME_VIEW_STATE;
		}
		
		protected function loadAppData_faultHandler(event:FaultEvent):void
		{
			Alert.show("Error loading application data: " + event.fault.faultString);
		}

	}
}