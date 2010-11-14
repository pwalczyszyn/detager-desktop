package com.detager.models
{
	import com.detager.events.UserEvent;
	import com.detager.models.domain.User;
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import org.swizframework.storage.ISharedObjectBean;

	[Bindable(event="propertyChange")]
	public dynamic class LocalConfig extends Proxy
	{
		
		[Inject]
		public var sharedObject:ISharedObjectBean;

		private var _config:Object;
		
		private var currentUser:User;
		
		flash_proxy override function callProperty(name:*, ...parameters):*
		{
			return new Error("callProperty not implemented in LocalConfig class!");
		}
		
		flash_proxy override function getProperty(name:*):*
		{
			return _config[name];
		}

		flash_proxy override function setProperty(name:*, value:*):void
		{
			_config[name] = value;
			sharedObject.setValue(currentUser.username, _config);
		}
		
		public function toString():String
		{
			return "LocalConfig";
		}
		
		[EventHandler(event="UserEvent.SIGNEDIN")]
		public function initUserConfig(event:UserEvent):void
		{
			currentUser = event.user;
			_config = sharedObject.getValue(currentUser.username,
				// this is first time user is signedIn on this machine
				// settings defaults
				{
					showNotifications : true, 
					playNotificationsSound : true, 
					syncInterval : 600000,
					showDragInWindow : true
				});
		}
		
		[EventHandler(event="UserEvent.SIGNEDOUT")]
		public function cleanUserConfig():void
		{
			currentUser = null;
			_config = null;
		}
		
		public function get configObject():Object
		{
			return _config;
		}
		
		public function set configObject(value:Object):void
		{
			_config = value;
			sharedObject.setValue(currentUser.username, _config);
		}
	}
}