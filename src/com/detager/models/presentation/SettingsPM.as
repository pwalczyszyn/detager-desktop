package com.detager.models.presentation
{
	import com.detager.events.MessageEvent;
	import com.detager.events.OAuthEvent;
	import com.detager.events.SettingsEvent;
	import com.detager.events.SwitchViewEvent;
	import com.detager.events.UserEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.LocalConfig;
	import com.detager.services.IUserService;
	import com.detager.views.OAuthWindow;
	
	import flash.desktop.NativeApplication;
	import flash.events.IEventDispatcher;
	import flash.system.Capabilities;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	
	import org.swizframework.utils.services.IServiceHelper;

	public class SettingsPM
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
	
		[Bindable]
		public var currentSettings:ObjectProxy;
		private var configObject:Object;
		
		[Inject]
		public var localConfig:LocalConfig;
		
		[Inject]
		public var applicationModel:ApplicationModel;
		
		[Bindable]
		public var startAtLogin:Boolean = false;
		
		[Inject(source="servicesHost")]
		public var servicesHost:String
		
		[Inject]
		public var userService:IUserService;
		
		[Inject]
		public var serviceHelper:IServiceHelper;
		
		[EventHandler(event="SettingsEvent.OPEN")]
		public function openSettings_eventHandler():void
		{
			configObject = ObjectUtil.copy(localConfig.configObject);
			currentSettings = new ObjectProxy(configObject);
			
			if (!Capabilities.isDebugger)
				startAtLogin = NativeApplication.nativeApplication.startAtLogin;
		}
		
		public function btnSave_clickHandler():void
		{
			localConfig.configObject = configObject;
			if (!Capabilities.isDebugger)
				NativeApplication.nativeApplication.startAtLogin = startAtLogin;

			dispatcher.dispatchEvent(new SettingsEvent(SettingsEvent.UPDATED));

			btnCancel_clickHandler();
		}
		
		public function btnCancel_clickHandler():void
		{
			configObject = null;
			currentSettings = null;
			
			dispatcher.dispatchEvent(new SwitchViewEvent(SwitchViewEvent.SWITCH_VIEW, ApplicationModel.HOME_VIEW_STATE));
		}

		public function btnSignOut_clickHandler():void
		{
			dispatcher.dispatchEvent(new UserEvent(UserEvent.SIGNOUT, applicationModel.currentUser));
		}

		public function btnTwitter_clickHandler():void
		{
			var oauthWindow:OAuthWindow = new OAuthWindow();
			oauthWindow.addEventListener(OAuthEvent.AUTHORIZED, twitterAuthorized_eventHandler);
			oauthWindow.userId = applicationModel.currentUser.id;
			oauthWindow.servicesHost = servicesHost;
			
			oauthWindow.open();
		}
		
		private function twitterAuthorized_eventHandler(event:OAuthEvent):void
		{
			OAuthWindow(event.target).close();
			
			var queryData:String = event.callbackUrl.split("?")[1];
			serviceHelper.executeServiceCall(userService.activateTwitter(queryData), activateTwitter_resultHandler, activateTwitter_faultHandler);
		}
		
		private function activateTwitter_resultHandler(event:ResultEvent):void
		{
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.INFO_MESSAGE, "Twitter link activated!", 4));
			// TODO: change state or something
		}
		
		private function activateTwitter_faultHandler(event:FaultEvent):void
		{
			dispatcher.dispatchEvent(new MessageEvent(MessageEvent.ERROR_MESSAGE, "Error activating Twitter: " + event.fault.faultString));
		}
	}
}