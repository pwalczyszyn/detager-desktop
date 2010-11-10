package com.detager.models.domain
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="TagGroup")]
	public class TagGroup
	{
		public var id:Number;
		
		public var name:String;
		
		public var tags:ArrayCollection;
		
		public function TagGroup(id:Number = NaN, name:String = null, tags:ArrayCollection = null)
		{
			this.id = id;
			this.name = name;
			this.tags = tags;
		}
	}
}