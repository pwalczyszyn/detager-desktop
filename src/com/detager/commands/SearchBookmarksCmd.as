package com.detager.commands
{
	import com.detager.events.BookmarksSearchEvent;
	import com.detager.events.MessageEvent;
	import com.detager.services.IBookmarkService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	import org.swizframework.utils.services.IServiceHelper;
	
	public class SearchBookmarksCmd implements IEventAwareCommand
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		[Inject]
		public var bookmarkService:IBookmarkService;
		
		[Inject]
		public var serviceHelper:IServiceHelper;

		private var searchTagsIds:ArrayCollection;
		
		private var searchString:String;
		
		public function set event(value:Event):void
		{
			var event:BookmarksSearchEvent = BookmarksSearchEvent(value);
			this.searchString = event.searchString;
			this.searchTagsIds = event.searchTagsIds;
		}
		
		public function execute():void
		{
			serviceHelper.executeServiceCall(bookmarkService.searchBookmarks(searchString, searchTagsIds), result, fault);
		}
		
		private function result(event:ResultEvent):void
		{
			dispatcher.dispatchEvent(new BookmarksSearchEvent(
				BookmarksSearchEvent.SEARCHED_BOOKMARKS, 
				searchString, searchTagsIds, ArrayCollection(event.result)));
		}
		
		private function fault(event:FaultEvent):void
		{
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.ERROR_MESSAGE, "Couldn't load searched bookmarks!"));
		}
	}
}