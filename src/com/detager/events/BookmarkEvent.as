package com.detager.events
{
	import com.detager.models.domain.Bookmark;
	
	import flash.events.Event;
	
	public class BookmarkEvent extends Event
	{
		
		public static const OPEN:String = "OPEN";
		
		public static const SAVE:String = "SAVE";
		
		public static const SAVED:String = "SAVED";
		
		public static const DELETE:String = "DELETE";
		
		public static const DELETED:String = "DELETED";
		
		public var linkEntry:Bookmark;
		
		public function BookmarkEvent(type:String, linkEntry:Bookmark, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.linkEntry = linkEntry;
		}
		
		override public function clone():Event
		{
			return new BookmarkEvent(type, linkEntry, bubbles, cancelable);
		}
	}
}