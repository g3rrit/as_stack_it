package com.pearisgreen.events
{
	import starling.events.Event;
	
	public class mEvent extends Event
	{
		public static const GAME_LOST = "lostgame";
		public static const SCORE_UP = "scoreup";
		public static const CHANGE_COLOR = "changecolor";
		
		public function mEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}