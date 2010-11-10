package com.detager.models.domain
{
	[Bindable]
	[RemoteClass(alias="User")]
	public class User
	{
		
		public var id:Number;
		
		/**
		 * User login
		 */
		public var username:String;
		
		/**
		 * User password
		 */
		public var password:String;
		
		/**
		 * User full name
		 */
		public var fullName:String;
		
		/**
		 * User description
		 */
		public var description:String;
		
		/**
		 * User website
		 */
		public var website:String;
		
		/**
		 * User last name
		 */
		public var email:String;
		
		/**
		 * User last name
		 */
		public var entryDate:Date;
		
		public function User()
		{
		}
	}
}