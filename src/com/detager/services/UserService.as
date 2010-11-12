package com.detager.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;

	public class UserService implements IUserService
	{
		[Inject(source="usersService")]
		public var remoteObject:RemoteObject;
		

		public function signOut():void
		{
			remoteObject.logout();
			
		}

		public function signIn(username:String, password:String):AsyncToken
		{
			remoteObject.setCredentials(username, password);
			return remoteObject.login();
		}
	}
}