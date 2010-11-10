package com.detager.events
{
	import flash.events.Event;
	
	public class MessageEvent extends Event
	{
		
		public static const ERROR_MESSAGE:String = "ERROR_MESSAGE";
		
		public static const INFO_MESSAGE:String = "INFO_MESSAGE";
		
		public var message:String;
		
		public function MessageEvent(type:String, message:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.message = message;
		}
		
		override public function clone():Event
		{
			return new MessageEvent(type, message, bubbles, cancelable);
		}

	}
}