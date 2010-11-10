package com.detager.events
{
	import flash.events.Event;
	
	public class SettingsEvent extends Event
	{
		
		public static const OPEN:String = "OPEN";
		
		public static const UPDATED:String = "UPDATED";
		
		public function SettingsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new SettingsEvent(type, bubbles, cancelable);
		}
	}
}