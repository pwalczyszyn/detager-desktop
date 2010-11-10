package com.detager.models.presentation
{
	import com.detager.events.BookmarkEvent;
	import com.detager.events.BookmarksSyncEvent;
	import com.detager.events.SwitchViewEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.LocalConfig;
	import com.detager.models.domain.Bookmark;
	
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;

	public class HomePM
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher; 
		
		[Bindable]
		[Inject(source="applicationModel.latestBookmarks", bind="true")]
		public var latestBookmarks:ArrayCollection;
		
		[Inject]
		public var localConfig:LocalConfig;
		
		private var timer:Timer;
		
		[PostConstruct]
		public function postConstruct():void
		{
			startSyncTimer();
		}
		
		[EventHandler(event="UserEvent.SIGNEDIN")]
		public function startSyncTimer():void
		{
			if (!timer)
			{
				// Initiate bookmarks loading after signin (actually 1 sec after)
				setTimeout(loadLatestBookmarks, 1000);
				
				// start timer
				timer = new Timer(localConfig.syncInterval);
				timer.addEventListener(TimerEvent.TIMER, onTimer);
				timer.start();
			}
		}
		
		[EventHandler(event="UserEvent.SIGNEDOUT")]
		public function stopSyncTimer():void
		{
			timer.stop();
			timer = null;
		}
		
		private function onTimer(event:TimerEvent):void
		{
			loadLatestBookmarks();
		}

		public function openBookmark(bookmark:Bookmark):void
		{
			if (dispatcher.dispatchEvent(new SwitchViewEvent(SwitchViewEvent.SWITCH_VIEW, ApplicationModel.LINK_EDITOR_VIEW_STATE)))
				dispatcher.dispatchEvent(new BookmarkEvent(BookmarkEvent.OPEN, bookmark));
		}
		
		protected function loadLatestBookmarks():void
		{
			dispatcher.dispatchEvent(new BookmarksSyncEvent(BookmarksSyncEvent.SYNC_LATEST));
		}
		
	}
}