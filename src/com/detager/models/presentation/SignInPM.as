package com.detager.models.presentation
{
	import com.detager.events.MessageEvent;
	import com.detager.events.UserEvent;
	import com.detager.models.domain.User;
	
	import flash.events.IEventDispatcher;
	
	import mx.validators.Validator;
	
	import org.swizframework.storage.IEncryptedLocalStorageBean;

	public class SignInPM
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Bindable]
		public var user:User;
		
		[Bindable]
		public var rememberMe:Boolean = false;
		
		[Bindable]
		public var formEnabled:Boolean = true;
		
		[Inject]
		public var encryptedLocalStorage:IEncryptedLocalStorageBean;
		
		[PostConstruct]
		public function postConstruct():void
		{
			user = encryptedLocalStorage.getObject("rememberMeUser") as User;
			if (user)
				dispatcher.dispatchEvent(new UserEvent(UserEvent.SIGNIN, user, rememberMe));
			else
				user = new User();
		}
		
		public function btnSignIn_clickHandler(validators:Array):void
		{
			if (Validator.validateAll(validators).length == 0)
			{
				formEnabled = false;
				dispatcher.dispatchEvent(new UserEvent(UserEvent.SIGNIN, user, rememberMe));
			}
		}

		[EventHandler(event="UserEvent.SIGNEDIN")]
		public function signedIn_eventHandler():void
		{
			formEnabled = true;
		}
		
		[EventHandler(event="UserEvent.SIGNIN_FAILED", properties="signInFailReason")]
		public function signInFault_eventHandler(signInFailReason:String):void
		{
			formEnabled = true;
			
			if (signInFailReason == "WRONG_CREDENTIALS")
			{
				dispatcher.dispatchEvent(new MessageEvent(MessageEvent.INFO_MESSAGE, "Wrong username or password!"));
			}
			else
			{
				dispatcher.dispatchEvent(new MessageEvent(MessageEvent.ERROR_MESSAGE, "Error connecting to the service!"));
			}
		}
	}
}