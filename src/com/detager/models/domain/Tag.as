package com.detager.models.domain
{
	[Bindable]
	[RemoteClass(alias="Tag")]
	public class Tag
	{
		public var id:Number;
		
		public var name:String;
		
		public function Tag(id:Number = NaN, name:String = null)
		{
			this.id = id;
			this.name = name;
		}
	}
}