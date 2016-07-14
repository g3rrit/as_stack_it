package com.pearisgreen.core
{
	import com.pearisgreen.events.NavigationEvent;
	import com.pearisgreen.scenes.AboutScene;
	import com.pearisgreen.scenes.GameScene;
	import com.pearisgreen.scenes.MainMenue;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	public class Game extends Sprite
	{
		
		public function Game()
		{
			super();
			
			addEventListener(NavigationEvent.CHANGE_SCREEN, onScreenChange);
			
			addChild(new MainMenue());
		}
		
		public function onScreenChange(e:NavigationEvent):void
		{
			if(e.params.id != null)
			{
				addScene(e.params.id);
			}
		}
		
		public function addScene(name:String):void
		{
			this.removeChildren();
			
			switch(name)
			{
				case "play":
					addChild(new GameScene());
					break;
				case "menue":
					addChild(new MainMenue());
					break;
				case "about":
					addChild(new AboutScene());
					break;
			}
		}
	}
}