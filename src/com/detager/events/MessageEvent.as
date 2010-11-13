package com.detager.events
{
	import flash.events.Event;
	
	public class MessageEvent extends Event
	{
		
		public static const ERROR_MESSAGE:String = "ERROR_MESSAGE";
		
		public static const INFO_MESSAGE:String = "INFO_MESSAGE";
		
		public var message:String;
		
		public var displayTime:Number;
		
		/**
		 * MessageEvent constructor.
		 * 
		 * @param type event type
		 * @param message Possible values ERROR_MESSAGE or INFO_MESSAGE.
		 * @param displayTime Time to display the message in seconds, if 0 it will not close automatically.
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function MessageEvent(type:String, message:String, displayTime:Number = 0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.message = message;
			this.displayTime = displayTime;
		}
		
		override public function clone():Event
		{
			return new MessageEvent(type, message, displayTime, bubbles, cancelable);
		}

	}
}