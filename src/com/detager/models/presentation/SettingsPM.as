package com.detager.models.presentation
{
	import com.detager.events.SettingsEvent;
	import com.detager.events.SwitchViewEvent;
	import com.detager.events.UserEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.LocalConfig;
	
	import flash.desktop.NativeApplication;
	import flash.events.IEventDispatcher;
	import flash.system.Capabilities;
	
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;

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

	}
}