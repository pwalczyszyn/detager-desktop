package com.detager.models.presentation
{
	import com.detager.models.domain.LinkEntry;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.utils.ObjectUtil;

	public class LinkEditorPM
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		[Bindable]
		public var currentLinkEntry:LinkEntry;
		
		protected var originalLinkEntry:LinkEntry;
		
		[PostConstruct]
		public function postConstruct():void
		{
			trace("AddLinkPM::postConstruct");
		}
		
		[PreDestroy]
		public function preDestroy():void
		{
			trace("AddLinkPM::preDestroy");
		}
		
		[EventHandler(event="LinkEntryEvent.OPEN", properties="linkEntry")]
		public function openLinkEntry(linkEntry:LinkEntry):void
		{
			// Checking if linkEntry was updated
			if (ObjectUtil.compare(originalLinkEntry, currentLinkEntry) != 0)
			{
				Alert.show("Discard current changes?", "Question", Alert.YES | Alert.NO, null, 
					function(event:CloseEvent):void
					{
						if (event.detail == Alert.YES)
							setCurrentLinkEntry(linkEntry);
					}
				);
			}
			else
				setCurrentLinkEntry(linkEntry);
		}
		
		public function btnNewLink_clickHandler(event:MouseEvent):void
		{
			var clipboardUrl:String = Clipboard.generalClipboard.getData(ClipboardFormats.URL_FORMAT) as String;
			openLinkEntry(new LinkEntry(clipboardUrl));
		}
		
		public function btnSaveLink_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
		}

		protected function setCurrentLinkEntry(newLinkEntry:LinkEntry):void
		{
			originalLinkEntry = ObjectUtil.copy(newLinkEntry) as LinkEntry;
			currentLinkEntry = ObjectUtil.copy(newLinkEntry) as LinkEntry;
		}
		
	}
}