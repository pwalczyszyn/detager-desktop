package com.detager.models
{
	import com.detager.models.domain.LinkEntry;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ApplicationModel
	{
		public static const STARTUP_VIEW_STATE:String = "STARTUP_VIEW_STATE";
		
		public static const HOME_VIEW_STATE:String = "HOME_VIEW_STATE";
		
		public static const LINK_EDITOR_VIEW_STATE:String = "LINK_EDITOR_VIEW_STATE";
		
		public static const SEARCH_VIEW_STATE:String = "SEARCH_VIEW_STATE";
		
		public static const SETTINGS_VIEW_STATE:String = "SETTINGS_VIEW_STATE";

		public var currentState:String = STARTUP_VIEW_STATE;
		
		public var tagGroups:ArrayCollection;
		
		public var statusBarText:String;
	}
}