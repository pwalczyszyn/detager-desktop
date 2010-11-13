package com.detager.controllers
{
    import air.update.ApplicationUpdaterUI;
    import air.update.events.UpdateEvent;
    
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.utils.setTimeout;

    public class UpdateController extends EventDispatcher
    {
        private var updater:ApplicationUpdaterUI;

		[PostConstruct]
		public function postConstruct():void
		{
            updater = new ApplicationUpdaterUI();
            updater.configurationFile = new File("app:/com/detager/configs/updateConfig.xml");
            updater.addEventListener(UpdateEvent.INITIALIZED, checkAutomatically);
            updater.initialize();			
		}

		private function checkAutomatically(event:UpdateEvent):void
		{
			setTimeout(function():void{updater.checkNow();}, 3000);
		}
    }
}
