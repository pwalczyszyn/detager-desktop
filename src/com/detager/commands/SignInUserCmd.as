package com.detager.commands
{
	import com.detager.events.MessageEvent;
	import com.detager.events.UserEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.domain.SignInResult;
	import com.detager.models.domain.User;
	import com.detager.services.IUserService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.storage.IEncryptedLocalStorageBean;
	import org.swizframework.utils.commands.IEventAwareCommand;
	import org.swizframework.utils.services.IServiceHelper;
	
	public class SignInUserCmd implements IEventAwareCommand
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var userService:IUserService;
		
		[Inject]
		public var serviceHelper:IServiceHelper;

		[Inject]
		public var applicationModel:ApplicationModel;
		
		[Inject]
		public var encryptedLocalStorage:IEncryptedLocalStorageBean;

		private var user:User;
		
		private var rememberMe:Boolean;
		
		public function set event(value:Event):void
		{
			user = UserEvent(value).user;
			rememberMe = UserEvent(value).rememberMe;
		}
		
		public function execute():void
		{
			serviceHelper.executeServiceCall(userService.signIn(user.username, user.password), result, fault); 
		}
		
		private function result(event:ResultEvent):void
		{
			var signInResult:SignInResult = SignInResult(event.result);
			if (signInResult.signedIn)
			{				
				if (rememberMe)
					encryptedLocalStorage.setObject("rememberMeUser", user);
				
				applicationModel.currentUser = signInResult.user;
				dispatcher.dispatchEvent(new UserEvent(UserEvent.SIGNEDIN, signInResult.user));
			}
			else
			{
				var userEvent:UserEvent = new UserEvent(UserEvent.SIGNIN_FAILED, user);
				userEvent.signInFailReason = "WRONG_CREDENTIALS";
				dispatcher.dispatchEvent(userEvent);
			}
		}
		
		private function fault(event:FaultEvent):void
		{
			trace(event.fault.faultDetail);
			
			var userEvent:UserEvent = new UserEvent(UserEvent.SIGNIN_FAILED, user);
			userEvent.signInFailReason = "CONNECTION_FAULT";
			
			dispatcher.dispatchEvent(userEvent);
		}
	}
}