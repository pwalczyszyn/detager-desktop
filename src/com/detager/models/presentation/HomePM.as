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
		
		public static const OTHERS_BOOKMARKS_STATE:String = "OTHERS_BOOKMARKS_STATE";
		
		public static const USER_BOOKMARKS_STATE:String = "USER_BOOKMARKS_STATE";
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher; 
		
		[Bindable]
		public var othersBookmarks:ArrayCollection = new ArrayCollection();

		[Bindable]
		public var userBookmarks:ArrayCollection = new ArrayCollection();

		protected var _othersView:Boolean = true;
		
		[Bindable]
		public var currentState:String;
		
		[Inject]
		public var localConfig:LocalConfig;
		
		protected var timer:Timer;
		
		protected var lastSyncTime:Date;
		
		[PostConstruct]
		public function postConstruct():void
		{
			startSyncTimer();
		}
		
		[EventHandler(event="UserEvent.SIGNEDIN")]
		public function startSyncTimer():void
		{
			// Initiating timer for others bookmarks sync
			if (!timer)
			{
				// Initiate bookmarks loading after signin (actually 1 sec after)
				setTimeout(loadLatestBookmarks, 1000);
				
				// start timer
				timer = new Timer(localConfig.syncInterval);
				timer.addEventListener(TimerEvent.TIMER, onTimer);
				timer.start();
			}
			
			// Loading user bookmarks
			dispatcher.dispatchEvent(new BookmarksSyncEvent(BookmarksSyncEvent.SYNC_USERS, lastSyncTime));
		}
		
		[EventHandler(event="UserEvent.SIGNEDOUT")]
		public function stopSyncTimer():void
		{
			timer.stop();
			timer = null;
		}
		
		[EventHandler(event="BookmarksSyncEvent.LATEST_SYNCED", properties="newBookmarks")]
		public function othersBookmarks_syncedHandler(newBookmarks:ArrayCollection):void
		{
			othersBookmarks.addAllAt(newBookmarks, 0);
		}

		[EventHandler(event="BookmarksSyncEvent.USERS_SYNCED", properties="newBookmarks")]
		public function userBookmarks_syncedHandler(newBookmarks:ArrayCollection):void
		{
			userBookmarks.addAllAt(newBookmarks, 0);
		}

		[EventHandler(event="BookmarkEvent.UPDATED")]
		[EventHandler(event="BookmarkEvent.CREATED")]
		[EventHandler(event="BookmarkEvent.DELETED")]
		public function bookmark_eventHandler(event:BookmarkEvent):void
		{
			switch(event.type)
			{
				case BookmarkEvent.UPDATED:
					update(event.bookmark, othersBookmarks);
					update(event.bookmark, userBookmarks);
					break;
				case BookmarkEvent.DELETED:
					update(event.bookmark, othersBookmarks, true);
					update(event.bookmark, userBookmarks, true);
					break;
				case BookmarkEvent.CREATED:
					loadLatestBookmarks();
					userBookmarks.addItemAt(event.bookmark, 0);
					break;
			}
		}
		
		protected function update(bookmark:Bookmark, collection:ArrayCollection, removeOnly:Boolean = false):void
		{
			for (var i:int = 0; i < collection.length; i++)
			{
				if (Bookmark(collection.getItemAt(i)).id == bookmark.id)
				{
					collection.removeItemAt(i);
					if (!removeOnly)
						collection.addItemAt(bookmark, i);
					break;
				}
			}
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			loadLatestBookmarks();
		}

		public function openBookmark(bookmark:Bookmark):void
		{
			if (dispatcher.dispatchEvent(new SwitchViewEvent(SwitchViewEvent.SWITCH_VIEW, ApplicationModel.LINK_EDITOR_VIEW_STATE)))
				dispatcher.dispatchEvent(new BookmarkEvent(BookmarkEvent.OPEN, bookmark));
		}
		
		public function btnRefresh_clickHandler():void
		{
			loadLatestBookmarks();
			dispatcher.dispatchEvent(new BookmarksSyncEvent(BookmarksSyncEvent.SYNC_USERS, lastSyncTime));
		}

		[Bindable]
		public function set othersView(value:Boolean):void
		{
			_othersView = value;
			
			if (value)
				currentState = OTHERS_BOOKMARKS_STATE;
			else
				currentState = USER_BOOKMARKS_STATE;
		}
		
		public function get othersView():Boolean
		{
			return _othersView;
		}
		
		protected function loadLatestBookmarks():void
		{
			dispatcher.dispatchEvent(new BookmarksSyncEvent(BookmarksSyncEvent.SYNC_LATEST, lastSyncTime));
			lastSyncTime = new Date();
		}
		
	}
}