package com.detager.services
{
	import com.detager.models.domain.LinkEntry;
	
	import mx.rpc.AsyncToken;

	public interface ILinkEntryService
	{
		
		function save(linkEntry:LinkEntry):AsyncToken;

		function open(linkEntryId:Number):AsyncToken;

		function remove(linkEntryId:Number):AsyncToken;
	}
}