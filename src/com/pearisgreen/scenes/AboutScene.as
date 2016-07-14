package com.pearisgreen.scenes
{
	import com.pearisgreen.assets.Assets;
	import com.pearisgreen.events.NavigationEvent;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AboutScene extends Sprite
	{
		
		private var btnBack:Button;
		
		public function AboutScene()
		{
			super();
			
			btnBack = new Button(Assets.getTexture("pButton"),"Back");
			btnBack.fontName = "bitFont";
			btnBack.fontColor = 0xffffff;
			btnBack.scaleX = StackIt.WIDTH/480;
			btnBack.scaleY = StackIt.HEIGHT/800;
			btnBack.alpha = 0;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			addChild(btnBack);
			var btnBackTween:Tween = new Tween(btnBack, 0.5);
			btnBackTween.fadeTo(1);
			btnBackTween.onComplete = function():void
			{
				addEventListener(Event.TRIGGERED, onTriggered);
			}
			Starling.juggler.add(btnBackTween);
		}
		
		public function onTriggered(e:Event):void
		{
			var buttonClicked:Button = e.target as Button;
			if((buttonClicked as Button) == btnBack)
			{
				var fadeTween:Tween = new Tween(this, 0.7);
				fadeTween.fadeTo(0);
				fadeTween.onComplete = function():void
				{
					dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN,{id: "menue"},true));
				}
				Starling.juggler.add(fadeTween);
			}
		}
	}
}