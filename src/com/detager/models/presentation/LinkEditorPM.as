package com.detager.models.presentation
{
	import com.detager.events.SwitchViewEvent;
	import com.detager.models.ApplicationModel;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class LinkEditorPM
	{
	
		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		[Inject]
		public var applicationModel:ApplicationModel;
		
		[PostConstruct]
		public function postConstruct():void
		{
			trace("AddLinkPM::postConstruct");
			trace(applicationModel.currentLinkEntry.url);
		}
		
		[PreDestroy]
		public function preDestroy():void
		{
			trace("AddLinkPM::preDestroy");
		}
		
		[EventHandler(event="SwitchViewEvent.SWITCHING_VIEW")]
		public function linkDragged_eventHandler(event:SwitchViewEvent):void
		{
			if (applicationModel.currentState == ApplicationModel.LINK_EDITOR_VIEW_STATE)
			{
				event.preventDefault();
				
				Alert.show("Discard editing current link?", "Warning", Alert.YES | Alert.NO, null, 
					function(alertEvent:CloseEvent):void
					{
						if (alertEvent.detail == Alert.YES)
						{
							applicationModel.currentState = event.viewState;
							dispatcher.dispatchEvent(new SwitchViewEvent(SwitchViewEvent.SWITCHED_VIEW, event.viewState));
						}
					}
				);
			}
		}
	}
}