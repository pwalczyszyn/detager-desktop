package com.detager.configs
{
	import com.detager.commands.SaveLinkEntryCmd;
	import com.detager.events.LinkEntryEvent;
	
	import org.swizframework.utils.commands.CommandMap;
	
	public class Commands extends CommandMap
	{
		override protected function mapCommands():void
		{
			mapCommand(LinkEntryEvent.SAVE, SaveLinkEntryCmd, LinkEntryEvent, false);
		}	
	}
}