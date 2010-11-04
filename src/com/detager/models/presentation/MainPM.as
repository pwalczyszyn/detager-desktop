package com.detager.models.presentation
{
	import com.detager.events.LinkDragEvent;
	import com.detager.events.SwitchViewEvent;
	import com.detager.models.ApplicationModel;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.InteractiveObject;
	import flash.events.NativeDragEvent;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;

	public class MainPM
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		[Bindable]
		[Inject(source="applicationModel.currentState", twoWay="true", bind="true")]
		public var currentState:String;
		
		[Bindable]
		[Inject(source="applicationModel.currentUrl", twoWay="true", bind="true")]
		public var currentUrl:String;
		
		
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
			currentUrl = url;
			
			var event:SwitchViewEvent = new SwitchViewEvent(SwitchViewEvent.SWITCHING_VIEW, ApplicationModel.LINK_EDITOR_VIEW_STATE);
			if (dispatcher.dispatchEvent(event))
				currentState = ApplicationModel.LINK_EDITOR_VIEW_STATE;
		}
	}
}