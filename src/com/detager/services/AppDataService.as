package com.detager.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;

	public class AppDataService implements IAppDataService
	{
		[Inject(source="appDataRemoteObject")]
		public var remoteObject:RemoteObject;
		
		public function loadAppData():AsyncToken
		{
			return remoteObject.loadAppData();
		}
	}
}