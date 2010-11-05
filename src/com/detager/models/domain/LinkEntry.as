package com.detager.models.domain
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass]
	public class LinkEntry
	{
		
		public var id:Number;
		
		public var url:String;
		
		public var title:String;
		
		public var description:String;
		
		public var thumbnail:ByteArray;
		
		public var tags:ArrayCollection;
		
		public function LinkEntry(url:String = null)
		{
			this.url = url;
			this.tags = new ArrayCollection();
		}
	}
}