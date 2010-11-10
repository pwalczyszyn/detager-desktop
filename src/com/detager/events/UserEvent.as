package com.detager.events
{
	import com.detager.models.domain.User;
	
	import flash.events.Event;
	
	public class UserEvent extends Event
	{
		
		public static const SIGNIN:String = "SIGNIN";
		
		public static const SIGNEDIN:String = "SIGNEDIN";
		
		public static const SIGNOUT:String = "SIGNOUT";
		
		public static const SIGNEDOUT:String = "SIGNEDOUT";
		
		public var user:User;
		
		public var rememberMe:Boolean;
		
		public function UserEvent(type:String, user:User, rememberMe:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.user = user;
			this.rememberMe = rememberMe;
		}
		
		override public function clone():Event
		{
			return new UserEvent(type, user, rememberMe, bubbles, cancelable);
		}
	}
}