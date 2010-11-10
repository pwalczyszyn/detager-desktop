package com.detager.services
{
	import com.detager.models.domain.Bookmark;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;

	public interface IBookmarkService
	{
		
		function save(linkEntry:Bookmark):AsyncToken;

		function open(linkEntryId:Number):AsyncToken;

		function remove(linkEntryId:Number):AsyncToken;
		
		function loadLatest(since:Date):AsyncToken;
		
		function searchBookmarks(searchString:String, searchTagsIds:ArrayCollection):AsyncToken;
	}
}