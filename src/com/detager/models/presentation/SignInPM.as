package com.detager.models.presentation
{
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
				dispatcher.dispatchEvent(new UserEvent(UserEvent.SIGNIN, user, rememberMe));
		}

	}
}