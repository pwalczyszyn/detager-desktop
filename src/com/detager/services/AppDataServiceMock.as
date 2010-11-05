package com.detager.services
{
	import com.detager.models.domain.Tag;
	import com.detager.models.domain.TagGroup;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	
	import org.swizframework.utils.services.MockDelegateHelper;

	public class AppDataServiceMock implements IAppDataService
	{
		
		[Inject]
		public var mockHelper:MockDelegateHelper;
		
		public function loadAppData():AsyncToken
		{
			var tagGroups:ArrayCollection = new ArrayCollection();
			tagGroups.addItem(
				new TagGroup(
					1, 
					"Runtimes",
					new ArrayCollection(
						[
							new Tag(1, "Desktop Browser"),
							new Tag(2, "Desktop"),
							new Tag(3, "Mobile Browser"),
							new Tag(4, "Mobile AIR")
						])
					)
				);
			tagGroups.addItem(
				new TagGroup(
					2, 
					"Programing Language",
					new ArrayCollection(
						[
							new Tag(5, "Flash"),
							new Tag(6, "Flex"),
							new Tag(7, "HTML5"),
							new Tag(8, "Silverlight")
						])
					)
				);
			
			return mockHelper.createMockResult(tagGroups);
		}
	}
}