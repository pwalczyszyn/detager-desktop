package com.detager.events
{
	import flash.events.Event;
	
	public class LinkDragEvent extends Event
	{
		
		public static const LINK_DRAGGED:String = "LINK_DRAGGED";
		
		public var url:String;
		
		public function LinkDragEvent(type:String, url:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.url = url;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new LinkDragEvent(type, url, bubbles, cancelable);
		}
	}
}