package com.detager.events
{
	import flash.events.Event;
	
	public class SwitchViewEvent extends Event
	{
		
		public static const SWITCHING_VIEW:String = "SWITCHING_VIEW";
		
		public static const SWITCHED_VIEW:String = "SWITCHED_VIEW";
		
		public var viewState:String;
		
		public function SwitchViewEvent(type:String, viewState:String, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
			this.viewState = viewState;
		}
		
		override public function clone():Event
		{
			return new SwitchViewEvent(type, viewState, bubbles, cancelable);
		}
	}
}