package com.detager.models.presentation
{
	import com.detager.events.SwitchViewEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.domain.LinkEntry;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;

	public class MainPM
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		[Bindable]
		[Inject(source="applicationModel.currentState", twoWay="true", bind="true")]
		public var currentState:String;
		
		[Inject(source="applicationModel.currentLinkEntry", twoWay="true", bind="true")]
		public var currentLinkEntry:LinkEntry;
		
		
		public function btnHome_clickHandler():void
		{
			currentState = ApplicationModel.HOME_VIEW_STATE;
		}
		
		public function btnAddLink_clickHandler():void
		{
			switchToLinkEditor(Clipboard.generalClipboard.getData(ClipboardFormats.URL_FORMAT) as String);
		}

		[EventHandler(event="LinkDragEvent.LINK_DRAGGED", properties="url")]
		public function linkDragged_eventHandler(url:String):void
		{
			switchToLinkEditor(url);
		}
		
		private function switchToLinkEditor(url:String):void
		{
			currentLinkEntry = new LinkEntry(url);
			
			var event:SwitchViewEvent = new SwitchViewEvent(SwitchViewEvent.SWITCHING_VIEW, ApplicationModel.LINK_EDITOR_VIEW_STATE);
			if (dispatcher.dispatchEvent(event))
				currentState = ApplicationModel.LINK_EDITOR_VIEW_STATE;
		}
	}
}