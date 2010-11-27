package com.detager.components
{
	import flash.events.ProgressEvent;
	
	import mx.preloaders.SparkDownloadProgressBar;
	
	public class SparkPreloader extends SparkDownloadProgressBar
	{
		public function SparkPreloader()
		{
			super();
		}
		
		override protected function showDisplayForDownloading(elapsedTime:int, event:ProgressEvent):Boolean
		{
			return false;
		}
		
		override protected function showDisplayForInit(elapsedTime:int, count:int):Boolean
		{
			return false;
		}
	}
}