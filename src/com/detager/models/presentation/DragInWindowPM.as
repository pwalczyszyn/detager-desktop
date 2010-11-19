package com.detager.models.presentation
{
	import com.detager.events.LinkDragEvent;
	import com.detager.models.LocalConfig;
	import com.detager.views.DragInWindow;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeDragManager;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.NativeDragEvent;

	public class DragInWindowPM
	{
		protected var window:DragInWindow;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var localConfig:LocalConfig;
		
		protected function openWindow():void
		{
			if (window && !window.closed && !localConfig.showDragInWindow)
			{
				closeWindow();
			} 
			else if (!window && localConfig.showDragInWindow)
			{
				window = new DragInWindow();
				window.dragEnterHandler = window_nativeDragEnterHandler;
				window.dragDropHandler = window_nativeDragDropHandler;
				window.closeHandler = window_closeHandler;
				window.open(false);
			}
		}
		
		protected function window_closeHandler(event:Event):void
		{
			localConfig.showDragInWindow = false;
			closeWindow();
		}
		
		protected function closeWindow():void
		{
			window.close();
			window = null;
		}
		
		[EventHandler(event="UserEvent.SIGNEDIN")]
		[EventHandler(event="SettingsEvent.UPDATED")]
		public function settings_updatedHandler():void
		{
			openWindow();
		}
		
		[EventHandler(event="UserEvent.SIGNEDOUT")]
		public function user_signedOutHandler():void
		{
			closeWindow();
		}
		
		protected function window_nativeDragEnterHandler(event:NativeDragEvent):void
		{
			if (event.clipboard.hasFormat(ClipboardFormats.URL_FORMAT))
				NativeDragManager.acceptDragDrop(window);
		}
		
		protected function window_nativeDragDropHandler(event:NativeDragEvent):void
		{
			var url:String = event.clipboard.getData(ClipboardFormats.URL_FORMAT) as String;
			dispatcher.dispatchEvent(new LinkDragEvent(LinkDragEvent.LINK_DRAGGED, url));

			var mainWindow:NativeWindow = NativeApplication.nativeApplication.openedWindows[0];
			mainWindow.restore();
			mainWindow.alwaysInFront = true;
			mainWindow.orderToFront();
			mainWindow.alwaysInFront = false;
		}

	}
}