package com.detager.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class BookmarksSyncEvent extends Event
	{
		
		public static const SYNC_LATEST:String = "SYNC_LATEST";
		
		public static const LATEST_SYNCED:String = "LATEST_SYNCED";
		
		public var newBookmarks:ArrayCollection;
		
		public function BookmarksSyncEvent(type:String, newBookmarks:ArrayCollection = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.newBookmarks = newBookmarks;
		}
		
		override public function clone():Event
		{
			return new BookmarksSyncEvent(type, newBookmarks, bubbles, cancelable);
		}
	}
}