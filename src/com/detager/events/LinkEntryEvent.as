package com.detager.events
{
	import com.detager.models.domain.LinkEntry;
	
	import flash.events.Event;
	
	public class LinkEntryEvent extends Event
	{
		
		public static const OPEN:String = "OPEN";
		
		public static const SAVE:String = "SAVE";
		
		public static const DELETE:String = "DELETE";
		
		public var linkEntry:LinkEntry;
		
		public function LinkEntryEvent(type:String, linkEntry:LinkEntry, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.linkEntry = linkEntry;
		}
		
		override public function clone():Event
		{
			return new LinkEntryEvent(type, linkEntry, bubbles, cancelable);
		}
	}
}