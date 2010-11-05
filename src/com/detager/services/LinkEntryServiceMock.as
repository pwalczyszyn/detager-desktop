package com.detager.services
{
	import com.detager.models.domain.LinkEntry;
	
	import mx.rpc.AsyncToken;
	
	import org.swizframework.utils.services.MockDelegateHelper;

	public class LinkEntryServiceMock implements ILinkEntryService
	{
		[Inject]
		public var mockHelper:MockDelegateHelper;
		
		private var newId:Number = 1;
		
		public function save(linkEntry:LinkEntry):AsyncToken
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

	}
}