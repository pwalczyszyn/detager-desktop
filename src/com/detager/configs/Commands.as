package com.detager.configs
{
	import com.detager.commands.CreateBookmarkCmd;
	import com.detager.commands.LoadAppDataCmd;
	import com.detager.commands.LoadLatestBookmarksCmd;
	import com.detager.commands.SearchBookmarksCmd;
	import com.detager.commands.SignInUserCmd;
	import com.detager.commands.SignOutUserCmd;
	import com.detager.commands.UpdateBookmarkCmd;
	import com.detager.events.BookmarkEvent;
	import com.detager.events.BookmarksSearchEvent;
	import com.detager.events.BookmarksSyncEvent;
	import com.detager.events.UserEvent;
	
	import org.swizframework.utils.commands.CommandMap;
	
	public class Commands extends CommandMap
	{
		override protected function mapCommands():void
		{
			mapCommand(BookmarkEvent.CREATE, CreateBookmarkCmd, BookmarkEvent, false);
			mapCommand(BookmarkEvent.UPDATE, UpdateBookmarkCmd, BookmarkEvent, false);
			
			mapCommand(UserEvent.SIGNIN, SignInUserCmd, UserEvent, false);
			mapCommand(UserEvent.SIGNEDIN, LoadAppDataCmd, UserEvent, false);
			mapCommand(UserEvent.SIGNOUT, SignOutUserCmd, UserEvent, false);
			
			mapCommand(BookmarksSyncEvent.SYNC_LATEST, LoadLatestBookmarksCmd, BookmarksSyncEvent, false);
			mapCommand(BookmarksSearchEvent.SEARCH_BOOKMARKS, SearchBookmarksCmd, BookmarksSearchEvent, false);
		}	
	}
}