package com.detager.services
{
	import com.detager.models.domain.Bookmark;
	import com.detager.models.domain.Tag;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	
	import org.swizframework.utils.services.MockDelegateHelper;

	public class BookmarkServiceMock implements IBookmarkService
	{
		[Inject]
		public var mockHelper:MockDelegateHelper;
		
		private var newId:Number = 1;
		
		public function save(linkEntry:Bookmark):AsyncToken
		{
			var mockId:Number = linkEntry.id;
			if (!mockId)
			{
				mockId = newId++; 
			}
			return mockHelper.createMockResult(mockId);
		}
		
		public function open(linkEntryId:Number):AsyncToken
		{
			return null;
		}
		
		public function remove(linkEntryId:Number):AsyncToken
		{
			return null;
		}

		public function loadLatest(since:Date):AsyncToken
		{
			return mockHelper.createMockResult(createMockBookmarks());
		}
		
		public function searchBookmarks(searchString:String, searchTagsIds:ArrayCollection):AsyncToken
		{
			return mockHelper.createMockResult(createMockBookmarks(3));
		}
		
		private function createMockBookmarks(count:int = 100):ArrayCollection
		{
			var result:ArrayCollection = new ArrayCollection();
			
			for(var i:int = 0; i < count; i++)
			{
				var b:Bookmark = new Bookmark();
				b.id = i + 1;
				b.title = "Space of RIA techs " + i;
				b.description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
				b.url = "http://riaspace.com";
				b.entryDate = new Date();
				b.ownerUsername = "pwalczyszyn";
				b.isOwner = false;
				b.otherTaggers = new ArrayCollection();
				
				var tags:ArrayCollection = new ArrayCollection();
				tags.addItem(new Tag(1, "Flex"));
				tags.addItem(new Tag(2, "Desktop AIR"));
				
				b.tags = tags;
				
				result.addItem(b);
			}
			
			return result;
		}
	}
}