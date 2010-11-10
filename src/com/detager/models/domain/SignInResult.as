package com.detager.models.domain
{
	[RemoteClass(alias="SignInResult")]
	public class SignInResult
	{
		
		public var signedIn:Boolean = false;
		
		public var user:User;
		
		public function SignInResult()
		{
		}
	}
}