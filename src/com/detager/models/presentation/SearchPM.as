package com.detager.models.presentation
{
	import com.detager.events.BookmarkEvent;
	import com.detager.events.BookmarksSearchEvent;
	import com.detager.events.SwitchViewEvent;
	import com.detager.models.ApplicationModel;
	import com.detager.models.domain.Bookmark;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;

	public class SearchPM
	{
		
		public static const SEARCH_CRITERIA_STATE:String = "SEARCH_CRITERIA_STATE"; 
		
		public static const SEARCH_PROCESS_STATE:String = "SEARCH_PROCESS_STATE";
		
		public static const SEARCH_RESULTS_STATE:String = "SEARCH_RESULTS_STATE";
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Bindable]
		public var currentState:String;
		
		[Bindable]
		public var currentTagGroups:ArrayCollection;

		[Inject(source="applicationModel.tagGroups")]
		public var tagGroups:ArrayCollection;

		[Bindable]
		public var searchResults:ArrayCollection;
		
		[PostConstruct]
		public function postConstruct():void
		{
			btnNewSearch_clickHandler();
		}
		
		public function btnNewSearch_clickHandler():void
		{
			currentTagGroups = ObjectUtil.copy(tagGroups) as ArrayCollection;
		}
		
		public function btnSearch_clickHandler():void
		{
			var selectedTagsIds:ArrayCollection = new ArrayCollection();
			for each(var tgp:ObjectProxy in currentTagGroups)
				for each(var tp:ObjectProxy in tgp.tags)
					if (tp.selected)
						selectedTagsIds.addItem(tp.tag.id);

			currentState = SEARCH_PROCESS_STATE;
			
			dispatcher.dispatchEvent(new BookmarksSearchEvent(BookmarksSearchEvent.SEARCH_BOOKMARKS, null, selectedTagsIds));
		}

		public function btnBack_clickHandler():void
		{
			currentState = SEARCH_CRITERIA_STATE;
		}

		[EventHandler(event="BookmarksSearchEvent.SEARCHED_BOOKMARKS", properties="searchedBookmarks")]
		public function searchedBookmarks_eventHandler(results:ArrayCollection):void
		{
			searchResults = results;
			currentState = SEARCH_RESULTS_STATE;
		}
		
		public function openBookmark(bookmark:Bookmark):void
		{
			if (dispatcher.dispatchEvent(new SwitchViewEvent(SwitchViewEvent.SWITCH_VIEW, ApplicationModel.LINK_EDITOR_VIEW_STATE)))
				dispatcher.dispatchEvent(new BookmarkEvent(BookmarkEvent.OPEN, bookmark));
		}
	}
}