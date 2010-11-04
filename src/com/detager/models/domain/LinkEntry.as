package com.detager.models.domain
{
	[Bindable]
	public class LinkEntry
	{
		
		public var url:String;
		
		public var title:String;
		
		public function LinkEntry(url:String)
		{
			this.url = url;
		}
	}
}