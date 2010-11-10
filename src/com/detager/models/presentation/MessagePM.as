package com.detager.models.presentation
{
	import com.detager.events.MessageEvent;

	public class MessagePM
	{
		[Bindable]
		public var currentState:String;
		
		[Bindable]
		public var message:String;
		
		[EventHandler(event="MessageEvent.*")]
		public function messageEvent_openHandler(event:MessageEvent):void
		{
			message = event.message;
			currentState = event.type;
		}

	}
}