package com.detager.events
{
	import flash.events.Event;
	
	public class OAuthEvent extends Event
	{
		public static const AUTHORIZED:String = "AUTHORIZED";
		
		public var callbackUrl:String;
		
		public function OAuthEvent(type:String, callbackUrl:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.callbackUrl = callbackUrl;
		}
		
		override public function clone():Event
		{
			return new OAuthEvent(type, callbackUrl, bubbles, cancelable);
		}
	}
}