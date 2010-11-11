package com.detager.events
{
	import com.detager.models.domain.Bookmark;
	
	import flash.events.Event;
	
	public class BookmarkEvent extends Event
	{
		
		public static const OPEN:String = "OPEN";
		
		public static const CREATE:String = "CREATE";
		
		public static const CREATED:String = "CREATED";

		public static const UPDATE:String = "UPDATE";
		
		public static const UPDATED:String = "UPDATED";

		public static const DELETE:String = "DELETE";
		
		public static const DELETED:String = "DELETED";
		
		public var bookmark:Bookmark;
		
		public function BookmarkEvent(type:String, bookmark:Bookmark, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.bookmark = bookmark;
		}
		
		override public function clone():Event
		{
			return new BookmarkEvent(type, bookmark, bubbles, cancelable);
		}
	}
}