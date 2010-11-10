package com.detager.models.domain
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="Bookmark")]
	public class Bookmark
	{
		
		public var id:Number;
		
		public var url:String;
		
		public var title:String;
		
		public var description:String;
		
		public var thumbnail:ByteArray;
		
		public var tags:ArrayCollection;
		
		public var entryDate:Date;
		
		public var ownerUsername:String;
		
		public var otherTaggers:ArrayCollection;
		
		public var isOwner:Boolean;
		
		public var publicAccess:Boolean;
		
		public function Bookmark(url:String = null)
		{
			this.url = url;
			this.publicAccess = true;
			this.tags = new ArrayCollection();
		}
	}
}