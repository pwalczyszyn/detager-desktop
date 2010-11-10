package com.detager.commands
{
	import com.detager.events.BookmarksSyncEvent;
	import com.detager.events.MessageEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.LocalConfig;
	import com.detager.services.IBookmarkService;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.commands.ICommand;
	import org.swizframework.utils.services.IServiceHelper;
	
	public class LoadLatestBookmarksCmd implements ICommand
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var bookmarkService:IBookmarkService;
		
		[Inject]
		public var serviceHelper:IServiceHelper;

		[Inject]
		public var localConfig:LocalConfig;
		
		private var now:Date;
		
		[Inject]
		public var applicationModel:ApplicationModel;
		
		public function execute():void
		{
			now = new Date();
			var since:Date = localConfig.lastBookmarksSyncTime;
			if (!since) 
				since = new Date();
			serviceHelper.executeServiceCall(bookmarkService.loadLatest(since), result, fault);
		}
		
		private function result(event:ResultEvent):void
		{
			applicationModel.latestBookmarks.addAll(ArrayCollection(event.result));
			localConfig.lastBookmarksSyncTime = now;

			dispatcher.dispatchEvent(new BookmarksSyncEvent(BookmarksSyncEvent.LATEST_SYNCED, applicationModel.latestBookmarks));
		}
		
		private function fault(event:FaultEvent):void
		{
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.ERROR_MESSAGE, "Couldn't load latest bookmarks!"));
		}
	}
}