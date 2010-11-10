package com.detager.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class BookmarksSearchEvent extends Event
	{
		
		public static const SEARCH_BOOKMARKS:String = "SEARCH_BOOKMARKS";
		
		public static const SEARCHED_BOOKMARKS:String = "SEARCHED_BOOKMARKS";
		
		public var searchTagsIds:ArrayCollection;
		
		public var searchString:String;
		
		public var searchedBookmarks:ArrayCollection;
		
		public function BookmarksSearchEvent(type:String, searchString:String = null, searchTagsIds:ArrayCollection = null, searchedBookmarks:ArrayCollection = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.searchString = searchString;
			this.searchTagsIds = searchTagsIds;
			this.searchedBookmarks = searchedBookmarks;
		}
		
		override public function clone():Event
		{
			return new BookmarksSearchEvent(type, searchString, searchTagsIds, searchedBookmarks, bubbles, cancelable);
		}
	}
}