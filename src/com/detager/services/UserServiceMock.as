package com.detager.services
{
	import com.detager.models.domain.SignInResult;
	import com.detager.models.domain.User;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	
	import org.swizframework.utils.services.MockDelegateHelper;

	public class UserServiceMock implements IUserService
	{

		[Inject]
		public var mockHelper:MockDelegateHelper;

		public function signIn(username:String, password:String):AsyncToken
		{
			var result:SignInResult = new SignInResult();
			
			var user:User = new User();
			user.id = 1;
			user.username = username;
			
			result.user = user;
			result.signedIn = true;
			
			if (username != "fault")
				return mockHelper.createMockResult(result);
			else
			{
				result.signedIn = false;
				return mockHelper.createMockResult(result);
			}
		}

	}
}