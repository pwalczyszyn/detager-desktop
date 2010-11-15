package com.detager.commands
{
	import com.detager.events.MessageEvent;
	import com.detager.events.SwitchViewEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.domain.Tag;
	import com.detager.models.domain.TagGroup;
	import com.detager.services.IAppDataService;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	
	import org.swizframework.utils.commands.ICommand;
	import org.swizframework.utils.services.ServiceHelper;
	
	public class LoadAppDataCmd implements ICommand
	{

		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		[Inject]
		public var applicationModel:ApplicationModel;
		
		[Inject]
		public var appDataService:IAppDataService;

		[Inject]
		public var serviceHelper:ServiceHelper;
		
		public function execute():void
		{
			serviceHelper.executeServiceCall(appDataService.loadAppData(), result, fault);
		}
		
		private function result(event:ResultEvent):void
		{
			var tagGroups:ArrayCollection = new ArrayCollection();
			for each(var tg:TagGroup in event.result as ArrayCollection)
			{
				var tags:ArrayCollection = new ArrayCollection();
				for each(var t:Tag in tg.tags)
				{
					tags.addItem(new ObjectProxy({name:t.name, tag:t, selected:false}));
				}
				tagGroups.addItem(new ObjectProxy({name:tg.name, tagGroup:tg, tags:tags}));
			}
			
			applicationModel.tagGroups = tagGroups;
			
			dispatcher.dispatchEvent(new SwitchViewEvent(SwitchViewEvent.SWITCH_VIEW, ApplicationModel.HOME_VIEW_STATE));
		}
		
		private function fault(event:FaultEvent):void
		{
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.ERROR_MESSAGE, "Error loading application data!"));
			trace("Error loading application data:", event.fault.faultDetail);
		}

	}
}