package com.detager.commands
{
	import com.detager.events.LinkEntryEvent;
	import com.detager.models.domain.LinkEntry;
	import com.detager.services.ILinkEntryService;
	
	import flash.events.Event;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	import org.swizframework.utils.services.IServiceHelper;
	
	public class SaveLinkEntryCmd implements IEventAwareCommand
	{
		
		[Inject]
		public var linkEntryService:ILinkEntryService;
		
		[Inject]
		public var serviceHelper:IServiceHelper;
		
		private var linkEntry:LinkEntry; 
		
		public function set event(value:Event):void
		{
			linkEntry = LinkEntryEvent(value).linkEntry;
		}
		
		public function execute():void
		{
			serviceHelper.executeServiceCall(linkEntryService.save(linkEntry), result, fault);
		}
		
		private function result(event:ResultEvent):void
		{
			
		}
		
		private function fault(event:FaultEvent):void
		{
			
		}
	}
}