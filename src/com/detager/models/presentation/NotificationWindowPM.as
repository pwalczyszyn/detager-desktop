package com.detager.models.presentation
{
	import com.detager.models.LocalConfig;
	import com.detager.views.NotificationWindow;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	public class NotificationWindowPM
	{
		[Inject]
		public var localConfig:LocalConfig;
		
		protected var window:NotificationWindow;
		
		protected var idle:Boolean = false;
		
		protected static var sound:Sound = new Sound(new URLRequest("/assets/sounds/message.mp3"));
		
		protected var idleQueue:Vector.<ArrayCollection>;
		
		public function NotificationWindowPM()
		{
			var nativeApp:NativeApplication = NativeApplication.nativeApplication;
			nativeApp.idleThreshold = 30;
			nativeApp.addEventListener(Event.USER_IDLE, userIdleHandler);
			nativeApp.addEventListener(Event.USER_PRESENT, userActiveHandler);
		}
		
		[EventHandler(event="BookmarksSyncEvent.LATEST_SYNCED", properties="newBookmarks")]
		public function handleNewFeeds(newBookmarks:ArrayCollection):void
		{
			if (localConfig.showNotifications)
			{
				if (!idle)
				{
					createWindow();
					window.addBookmarks(newBookmarks);
				}
				else
				{
					idleQueue.push(newBookmarks);
				}
			}
			else if (localConfig.playNotificationsSound)
			{
				sound.play();
			}
		}
		
		protected function createWindow():void
		{
			if (window == null)
			{
				window = new NotificationWindow();
				window.addEventListener(Event.CLOSE, function():void {window = null;});
				window.addEventListener(FlexEvent.CREATION_COMPLETE, 
					function():void 
					{
						if (localConfig.playNotificationsSound)
							sound.play();
					});
				window.open(false);
			}
		}
		
		protected function userIdleHandler(event:Event):void
		{
			idle = true;
			idleQueue = new Vector.<ArrayCollection>();
		}
		
		protected function userActiveHandler(event:Event):void
		{
			idle = false;
			if (idleQueue.length > 0)
			{
				createWindow();
				window.addAllBookmarks(idleQueue);
			}
		}
	}
}