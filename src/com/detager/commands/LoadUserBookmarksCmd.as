package com.detager.commands
{
	import com.detager.events.BookmarksSyncEvent;
	import com.detager.events.MessageEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.services.IBookmarkService;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.commands.ICommand;
	import org.swizframework.utils.services.IServiceHelper;
	
	public class LoadUserBookmarksCmd implements ICommand
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var bookmarkService:IBookmarkService;
		
		[Inject]
		public var serviceHelper:IServiceHelper;

		[Inject]
		public var applicationModel:ApplicationModel;
		
		public function execute():void
		{
			serviceHelper.executeServiceCall(bookmarkService.loadUserBookmarks(), result, fault);
		}
		
		private function result(event:ResultEvent):void
		{
			dispatcher.dispatchEvent(new BookmarksSyncEvent(BookmarksSyncEvent.USERS_SYNCED, null, ArrayCollection(event.result)));
		}
		
		private function fault(event:FaultEvent):void
		{
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.ERROR_MESSAGE, "Couldn't load user bookmarks!"));
		}
	}
}