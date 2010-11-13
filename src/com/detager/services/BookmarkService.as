package com.detager.services
{
	import com.detager.models.domain.Bookmark;
	import com.detager.models.domain.Tag;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import org.swizframework.utils.services.MockDelegateHelper;

	public class BookmarkService implements IBookmarkService
	{
		[Inject(source="bookmarksService")]
		public var remoteObject:RemoteObject;
		
		[Inject]
		public var mockHelper:MockDelegateHelper;

		public function create(bookmark:Bookmark):AsyncToken
		{
			return remoteObject.create(bookmark);
		}
		
		public function update(bookmark:Bookmark):AsyncToken
		{
			return remoteObject.update(bookmark);
		}
		
		public function remove(bookmarkId:Number):AsyncToken
		{
			return remoteObject.remove(bookmarkId);
		}

		public function loadLatest(since:Date):AsyncToken
		{
			return remoteObject.loadLatest(since);
		}
		
		public function loadUserBookmarks():AsyncToken
		{
			return remoteObject.loadUserBookmarks();
		}
		
		public function searchBookmarks(searchString:String, searchTagsIds:ArrayCollection):AsyncToken
		{
			return remoteObject.searchBookmarks(searchString, searchTagsIds.source);
		}
		
	}
}