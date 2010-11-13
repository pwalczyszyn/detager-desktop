package com.detager.commands
{
	import com.detager.events.BookmarkEvent;
	import com.detager.events.MessageEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.domain.Bookmark;
	import com.detager.services.IBookmarkService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	import org.swizframework.utils.services.IServiceHelper;
	
	public class CreateBookmarkCmd implements IEventAwareCommand
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var bookmarkService:IBookmarkService;
		
		[Inject]
		public var serviceHelper:IServiceHelper;
		
		[Inject]
		public var applicationModel:ApplicationModel;

		private var bookmark:Bookmark; 
		
		public function set event(value:Event):void
		{
			bookmark = BookmarkEvent(value).bookmark;
		}
		
		public function execute():void
		{
			serviceHelper.executeServiceCall(bookmarkService.create(bookmark), result, fault);
		}
		
		private function result(event:ResultEvent):void
		{
			dispatcher.dispatchEvent(new BookmarkEvent(BookmarkEvent.CREATED, bookmark));
			
			bookmark.id = event.result as Number;
			bookmark.ownerUsername = applicationModel.currentUser.username;
			bookmark.isOwner = true;
		}
		
		private function fault(event:FaultEvent):void
		{
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.ERROR_MESSAGE, "Error saving bookmark: " + event.fault.faultString));
		}
	}
}