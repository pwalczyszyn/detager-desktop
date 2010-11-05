package com.detager.models.presentation
{
	import com.detager.events.LinkEntryEvent;
	import com.detager.events.SwitchViewEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.domain.LinkEntry;
	
	import mx.core.FlexGlobals;

	public class MainPM
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		[Bindable]
		[Inject(source="applicationModel.currentState", twoWay="true", bind="true")]
		public var currentState:String;
		
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
		}

		
		[EventHandler(event="LinkDragEvent.LINK_DRAGGED", properties="url")]
		public function linkDragged_eventHandler(url:String):void
		{
			if (currentState != ApplicationModel.LINK_EDITOR_VIEW_STATE)
				if (!switchViewState(ApplicationModel.LINK_EDITOR_VIEW_STATE))
					return;
			
			dispatcher.dispatchEvent(new LinkEntryEvent(LinkEntryEvent.OPEN, new LinkEntry(url)));
		}
		
		protected function switchViewState(toViewState:String):Boolean
		{
			var event:SwitchViewEvent = new SwitchViewEvent(SwitchViewEvent.SWITCHING_VIEW, ApplicationModel.LINK_EDITOR_VIEW_STATE);
			if (dispatcher.dispatchEvent(event))
			{
				currentState = ApplicationModel.LINK_EDITOR_VIEW_STATE;
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}