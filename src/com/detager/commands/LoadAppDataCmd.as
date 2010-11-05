package com.detager.commands
{
	import com.detager.services.IAppDataService;
	
	import org.swizframework.utils.commands.ICommand;
	import org.swizframework.utils.services.ServiceHelper;
	
	public class LoadAppDataCmd implements ICommand
	{
		[Inject]
		public var appDataService:IAppDataService;
		
		[Inject]
		public var serviceHelper:ServiceHelper;
		
		public function execute():void
		{
		}
	}
}