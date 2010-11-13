package com.detager.models.presentation
{
	import com.detager.events.BookmarkEvent;
	import com.detager.events.MessageEvent;
	import com.detager.events.SettingsEvent;
	import com.detager.events.SwitchViewEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.domain.Bookmark;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.FlexGlobals;

	public class MainPM
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		[Bindable]
		[Inject(source="applicationModel.currentState", twoWay="true", bind="true")]
		public var currentState:String;
		
		[Bindable]
		public var showMessage:Boolean = false;
		
		[Inject(source="applicationModel.statusBarText", bind="true")]
		public function set statusBarText(value:String):void
		{
			FlexGlobals.topLevelApplication.statusText.text = value;
		}
		
		public function btnHomeView_clickHandler():void
		{
			switchViewState(ApplicationModel.HOME_VIEW_STATE);
		}
		
		public function btnLinkView_clickHandler():void
		{
			switchViewState(ApplicationModel.LINK_EDITOR_VIEW_STATE);
		}

		public function btnSearchView_clickHandler():void
		{
			switchViewState(ApplicationModel.SEARCH_VIEW_STATE);
		}

		public function btnSettingsView_clickHandler():void
		{
			switchViewState(ApplicationModel.SETTINGS_VIEW_STATE);
			if (currentState == ApplicationModel.SETTINGS_VIEW_STATE)
				dispatcher.dispatchEvent(new SettingsEvent(SettingsEvent.OPEN));
		}

		public function messageView_closeHandler():void
		{
			closeMessage();
		}

		protected var messageTimer:Timer;
		
		[EventHandler(event="MessageEvent.*")]
		public function messageEvent_openHandler(event:MessageEvent):void
		{
			if (event.displayTime && event.displayTime > 0)
			{
				if (!messageTimer)
				{
					messageTimer = new Timer(event.displayTime * 1000, 1);
					messageTimer.addEventListener(TimerEvent.TIMER, messageTimer_eventHandler);
				}
				else if (messageTimer.running)
					messageTimer.stop();
				
				messageTimer.delay = event.displayTime * 1000;
				messageTimer.reset();
				messageTimer.start();
			}
			
			showMessage = true;
		}

		protected function closeMessage():void
		{
			if (messageTimer && messageTimer.running)
				messageTimer.stop();
			showMessage = false;
		}
		
		protected function messageTimer_eventHandler(event:TimerEvent):void
		{
			closeMessage();
		}

		[EventHandler(event="UserEvent.SIGNEDOUT")]
		public function signOut_eventHandler():void
		{
			currentState = ApplicationModel.SIGNIN_VIEW_STATE;
		}
		
		[EventHandler(event="LinkDragEvent.LINK_DRAGGED", properties="url")]
		public function linkDragged_eventHandler(url:String):void
		{
			if (currentState != ApplicationModel.LINK_EDITOR_VIEW_STATE)
				if (!switchViewState(ApplicationModel.LINK_EDITOR_VIEW_STATE))
					return;
			
			dispatcher.dispatchEvent(new BookmarkEvent(BookmarkEvent.OPEN, new Bookmark(url)));
		}
		
		[EventHandler(event="SwitchViewEvent.SWITCH_VIEW")]
		public function switchViewState_eventHandler(event:SwitchViewEvent):void
		{
			if (!switchViewState(event.viewState))
				event.preventDefault();
		}
		
		protected function switchViewState(toViewState:String):Boolean
		{
			var event:SwitchViewEvent = new SwitchViewEvent(SwitchViewEvent.SWITCHING_VIEW, toViewState);
			if (!dispatcher.dispatchEvent(event))
				return false;

			closeMessage();
			currentState = toViewState;
			return true;
		}
	}
}