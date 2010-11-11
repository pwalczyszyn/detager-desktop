package com.detager.commands
{
	import com.detager.events.BookmarksSyncEvent;
	import com.detager.events.MessageEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.LocalConfig;
	import com.detager.services.IBookmarkService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	import org.swizframework.utils.services.IServiceHelper;
	
	public class LoadLatestBookmarksCmd implements IEventAwareCommand
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var bookmarkService:IBookmarkService;
		
		[Inject]
		public var serviceHelper:IServiceHelper;

		[Inject]
		public var localConfig:LocalConfig;
		
		private var since:Date;
		
		[Inject]
		public var applicationModel:ApplicationModel;
		
		public function set event(value:Event):void
		{
			since = BookmarksSyncEvent(value).since;
		}

		public function execute():void
		{
			serviceHelper.executeServiceCall(bookmarkService.loadLatest(since), result, fault);
		}
		
		private function result(event:ResultEvent):void
		{
			dispatcher.dispatchEvent(new BookmarksSyncEvent(BookmarksSyncEvent.LATEST_SYNCED, since, ArrayCollection(event.result)));
		}
		
		private function fault(event:FaultEvent):void
		{
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.ERROR_MESSAGE, "Couldn't load latest bookmarks!"));
		}
	}
}