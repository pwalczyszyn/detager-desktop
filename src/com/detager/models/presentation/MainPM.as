package com.detager.models.presentation
{
	import com.detager.events.LinkDragEvent;
	import com.detager.models.ApplicationModel;
	
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
		
		public function btnHome_clickHandler():void
		{
			switchState(ApplicationModel.HOME_VIEW_STATE);
		}
		
		public function btnAddLink_clickHandler():void
		{
			switchState(ApplicationModel.ADD_LINK_VIEW_STATE);
		}

		[EventHandler(event="LinkDragEvent.LINK_DRAGGED", properties="url")]
		public function linkDragged_eventHandler(url:String):void
		{
			switchState(ApplicationModel.ADD_LINK_VIEW_STATE);
		}
		
		private function switchState(state:String):void
		{
			if (currentState == ApplicationModel.ADD_LINK_VIEW_STATE)
			{
				Alert.show("Discard editing current link?", "Warning", Alert.YES | Alert.NO, null, 
					function(event:CloseEvent):void
					{
						if (event.detail == Alert.YES)
							currentState = state;
					}
				);
			}
			else
			{
				currentState = state;
			}
			
		}
	}
}