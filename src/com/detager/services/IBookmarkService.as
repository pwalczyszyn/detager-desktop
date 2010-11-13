package com.detager.services
{
	import com.detager.models.domain.Bookmark;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;

	public interface IBookmarkService
	{
		
		function create(bookmark:Bookmark):AsyncToken;

		function update(bookmark:Bookmark):AsyncToken;

		function remove(bookmarkId:Number):AsyncToken;
		
		function loadLatest(since:Date):AsyncToken;
		
		function loadUserBookmarks():AsyncToken;
		
		function searchBookmarks(searchString:String, searchTagsIds:ArrayCollection):AsyncToken;
	}
}