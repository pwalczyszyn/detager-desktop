package com.detager.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;
	
	public class Preloader extends DownloadProgressBar
	{
		public function Preloader()
		{
			super();
		}
		
		override public function set preloader( preloader:Sprite ):void 
		{                   
			preloader.addEventListener( ProgressEvent.PROGRESS , SWFDownloadProgress );    
			preloader.addEventListener( Event.COMPLETE , SWFDownloadComplete );
			preloader.addEventListener( FlexEvent.INIT_PROGRESS , FlexInitProgress );
			preloader.addEventListener( FlexEvent.INIT_COMPLETE , FlexInitComplete );
		}
		
		private function SWFDownloadProgress( event:ProgressEvent ):void {}
		
		private function SWFDownloadComplete( event:Event ):void {}
		
		private function FlexInitProgress( event:Event ):void {}
		
		private function FlexInitComplete( event:Event ):void 
		{      
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}