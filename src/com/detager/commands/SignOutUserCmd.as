package com.detager.commands
{
	import com.detager.events.UserEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.domain.User;
	import com.detager.services.IUserService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.swizframework.storage.IEncryptedLocalStorageBean;
	import org.swizframework.utils.commands.IEventAwareCommand;
	import org.swizframework.utils.services.IServiceHelper;
	
	public class SignOutUserCmd implements IEventAwareCommand
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var userService:IUserService;

		[Inject(source="usersService")]
		public var remoteObject:RemoteObject;

		[Inject]
		public var serviceHelper:IServiceHelper;

		[Inject]
		public var applicationModel:ApplicationModel;
		
		[Inject]
		public var encryptedLocalStorage:IEncryptedLocalStorageBean;

		private var user:User;
		
		public function set event(value:Event):void
		{
			user = UserEvent(value).user;
		}
		
		public function execute():void
		{
			serviceHelper.executeServiceCall(userService.signOut(), result, fault);
		}
		
		private function result(event:ResultEvent):void
		{
			remoteObject.logout();
			remoteObject.setCredentials(null, null);
			
			applicationModel.currentUser = null;
			encryptedLocalStorage.setObject("rememberMeUser", null);
		
			dispatcher.dispatchEvent(new UserEvent(UserEvent.SIGNEDOUT, user));
		}
		
		private function fault(event:FaultEvent):void
		{
			trace("error loging out:", event.fault.faultDetail);
		}

	}
}