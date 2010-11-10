package com.detager.commands
{
	import com.detager.events.BookmarkEvent;
	import com.detager.events.MessageEvent;
	import com.detager.models.domain.Bookmark;
	import com.detager.services.IBookmarkService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	import org.swizframework.utils.services.IServiceHelper;
	
	public class SaveBookmarkCmd implements IEventAwareCommand
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var bookmarkService:IBookmarkService;
		
		[Inject]
		public var serviceHelper:IServiceHelper;
		
		private var linkEntry:Bookmark; 
		
		public function set event(value:Event):void
		{
			linkEntry = BookmarkEvent(value).linkEntry;
		}
		
		public function execute():void
		{
			serviceHelper.executeServiceCall(bookmarkService.save(linkEntry), result, fault);
		}
		
		private function result(event:ResultEvent):void
		{
			linkEntry.id = event.result as Number;
			dispatcher.dispatchEvent(new BookmarkEvent(BookmarkEvent.SAVED, linkEntry));
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.INFO_MESSAGE, "Link saved successfully!"));
		}
		
		private function fault(event:FaultEvent):void
		{
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.ERROR_MESSAGE, "Error saving: " + event.fault.faultString));
		}
	}
}