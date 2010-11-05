package com.detager.models.presentation
{
	import com.detager.events.LinkEntryEvent;
	import com.detager.models.domain.LinkEntry;
	import com.detager.models.domain.Tag;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;

	public class LinkEditorPM
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		[Bindable]
		public var currentLinkEntry:LinkEntry;

		[Bindable]
		public var currentTagGroups:ArrayCollection;

		[Inject(source="applicationModel.tagGroups")]
		public var tagGroups:ArrayCollection;
		
		[Bindable]
		[Inject(source="applicationModel.statusBarText", twoWay="true", bind="true")]
		public var statusBarText:String;
		
		[Bindable]
		public var enabledTitle:Boolean = true;
		
		protected var originalLinkEntry:LinkEntry;
		
		[PostConstruct]
		public function postConstruct():void
		{
			btnNewLink_clickHandler();
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
		
		public function btnNewLink_clickHandler():void
		{
			var clipboardUrl:String = Clipboard.generalClipboard.getData(ClipboardFormats.URL_FORMAT) as String;
			openLinkEntry(new LinkEntry(clipboardUrl));
		}
		
		public function btnSaveLink_clickHandler():void
		{
			var selectedTags:ArrayCollection = new ArrayCollection();
			for each(var tgp:ObjectProxy in currentTagGroups)
				for each(var tp:ObjectProxy in tgp.tags)
					if (tp.selected)
						selectedTags.addItem(tp.tag);
					
			currentLinkEntry.tags = selectedTags;
			
			dispatcher.dispatchEvent(new LinkEntryEvent(LinkEntryEvent.SAVE, currentLinkEntry));
		}

		public function txtUrl_changeHandler():void
		{
			if (currentLinkEntry.url)
				loadTitle();
		}
		
		protected function setCurrentLinkEntry(newLinkEntry:LinkEntry):void
		{
			originalLinkEntry = ObjectUtil.copy(newLinkEntry) as LinkEntry;
			currentLinkEntry = ObjectUtil.copy(newLinkEntry) as LinkEntry;
		
			currentTagGroups = ObjectUtil.copy(tagGroups) as ArrayCollection;

			// In case this is existing link loaded
			var tagIds:Vector.<Number> = new Vector.<Number>();
			for each(var tag:Tag in currentLinkEntry.tags)
				tagIds.push(tag.id);
			
			if (tagIds.length > 0)
				for each(var tgp:ObjectProxy in currentTagGroups)
					for each(var tp:ObjectProxy in tgp.tags)
						if (tagIds.indexOf(tp.tag.id) > -1)
							tp.selected = true;
			
			if (currentLinkEntry.url)
				loadTitle();
		}
		
		protected function loadTitle():void
		{
			statusBarText = "Loading link title...";
			enabledTitle = false;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, 
				function(event:Event):void
				{
					var arr:Array = String(loader.data).match(/<title>.*<\/title>/);
					if (arr.length > 0)
					{
						var titleElement:String = String(arr[0]);
						originalLinkEntry.title = titleElement.substr(7).substr(0,titleElement.length - 15);
						currentLinkEntry.title = originalLinkEntry.title;
						
						statusBarText = "";
						enabledTitle = true;
					}
				});
			loader.addEventListener(IOErrorEvent.IO_ERROR,
				function(event:IOErrorEvent):void
				{
					statusBarText = "";
					enabledTitle = true;
					trace("Failed to load title:", event.text);					
				});
			loader.load(new URLRequest(currentLinkEntry.url));
			
		}
	}
}