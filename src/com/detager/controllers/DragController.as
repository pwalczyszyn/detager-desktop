package com.detager.controllers
{
	import com.detager.events.LinkDragEvent;
	import com.detager.models.ApplicationModel;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.InteractiveObject;
	import flash.events.IEventDispatcher;
	import flash.events.NativeDragEvent;
	
	import mx.core.FlexGlobals;

	public class DragController
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var applicationModel:ApplicationModel;
		
		[PostConstruct]
		public function postConstruct():void
		{
			var io:InteractiveObject = FlexGlobals.topLevelApplication as InteractiveObject;
			io.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onNativeDragEnter);
			io.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, onNativeDragDrop);
		}
		
		protected function onNativeDragEnter(event:NativeDragEvent):void
		{
			if (event.clipboard.hasFormat(ClipboardFormats.URL_FORMAT))
				NativeDragManager.acceptDragDrop(FlexGlobals.topLevelApplication as InteractiveObject);
		}
		
		protected function onNativeDragDrop(event:NativeDragEvent):void
		{
			var url:String = event.clipboard.getData(ClipboardFormats.URL_FORMAT) as String;
			dispatcher.dispatchEvent(new LinkDragEvent(LinkDragEvent.LINK_DRAGGED, url));
		}

	}
}