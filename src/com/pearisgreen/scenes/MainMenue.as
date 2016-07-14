package com.pearisgreen.scenes
{
	import com.pearisgreen.etc.DoubleTextField;
	import com.pearisgreen.etc.myButton;
	import com.pearisgreen.events.NavigationEvent;
	import com.pearisgreen.objects.BackGroundTexture;
	
	import flash.filesystem.File;
	import flash.utils.getTimer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class MainMenue extends Sprite
	{
		private var startingColornum:Number;
		
		private var backGroundTexture:BackGroundTexture;
		
		private var btnPlay:myButton;
		//private var btnAbout:myButton;
		
		private var titleText:DoubleTextField;
		private var highScoreText:DoubleTextField;
		
		private var nametag:DoubleTextField;
		
		private var highScoreInt:uint;
		
		private var quad:Quad;
		
		public function MainMenue()
		{
			super();
			
			startingColornum = Math.random();//Color.rgb(Math.round(255 * Math.random()),Math.round(255 * Math.random()),Math.round(255 * Math.random()));
			
			quad = new Quad(StackIt.WIDTH,StackIt.HEIGHT);
			quad.color = 0x000000;
			
			backGroundTexture = new BackGroundTexture(startingColornum);
			backGroundTexture.malpha = 0;
			
			//highscore file
			getHighScore();
			
			nametag = new DoubleTextField(StackIt.WIDTH, StackIt.HEIGHT/5, "@ pearisgreen");
			nametag.y = StackIt.HEIGHT/1.2;
			//nametag.x = StackIt.WIDTH/2.7;
			nametag.hAlign = HAlign.CENTER;
			nametag.vAlign = VAlign.CENTER;
			nametag.fontSize = StackIt.HEIGHT/45;
			nametag.color0 = 0x00ffff;
			nametag.alpha = 0;
			
			titleText = new DoubleTextField(StackIt.WIDTH,StackIt.HEIGHT/4,"STACKIT");
			titleText.y = StackIt.HEIGHT/4;
			titleText.hAlign = HAlign.CENTER;
			titleText.vAlign = VAlign.CENTER;
			titleText.fontSize = StackIt.HEIGHT/20;
			titleText.color0 = 0x00ffff;
			titleText.alpha = 0;
			
			highScoreText = new DoubleTextField(StackIt.WIDTH,StackIt.HEIGHT/2,"highscore: " + highScoreInt);
			highScoreText.y = 0;
			highScoreText.fontSize = StackIt.HEIGHT/30;
			highScoreText.color0 = 0x00ffff;
			highScoreText.width = StackIt.WIDTH;
			highScoreText.height = StackIt.HEIGHT/2;
			highScoreText.alpha = 0;
			
			btnPlay = new myButton("PLAY");
			btnPlay.x = StackIt.WIDTH/2 - btnPlay.width/2;
			btnPlay.y = StackIt.HEIGHT/2.5;
			btnPlay.alpha = 0;
			
			/*
			btnAbout = new myButton("ABOUT");
			btnAbout.x = StackIt.WIDTH/2 - btnAbout.width/2;
			btnAbout.y = StackIt.HEIGHT/2;
			btnAbout.alpha = 0;*/
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);	
		}
		
		private function getHighScore():void
		{
			highScoreInt = 0;
			
			//var file:File = File.applicationStorageDirectory;
			//file = file.resolvePath("highscore.sc");
			
			//testing
			/*
			var fileStream:FileStream = new FileStream();
			fileStream.open(file,FileMode.WRITE);
			fileStream.writeUnsignedInt(0);
			fileStream.close();*/
			//
			/*
			var fileStream:FileStream = new FileStream();
			fileStream.open(file,FileMode.READ);
			highScoreInt = fileStream.readUnsignedInt();
			fileStream.close();
			*/
		}
		
		public function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);	
			
			addEventListener(Event.ENTER_FRAME, onUpdate);
			
			addChild(quad);
			
			addChild(backGroundTexture);
			var backGroundTextureTween:Tween = new Tween(backGroundTexture, 0.5);
			backGroundTextureTween.animate("malpha", 1);
			backGroundTextureTween.onComplete = function():void 
			{
				addChild(btnPlay);
				var btnPlayTween:Tween = new Tween(btnPlay, 0.5);
				btnPlayTween.fadeTo(1);
				btnPlayTween.onComplete = function():void
				{
					addEventListener(Event.TRIGGERED, onTriggered);	
				};
				Starling.juggler.add(btnPlayTween);
				
				/*addChild(btnAbout);
				var btnAboutTween:Tween = new Tween(btnAbout, 0.5);
				btnAboutTween.fadeTo(1);
				Starling.juggler.add(btnAboutTween);*/
			};
			Starling.juggler.add(backGroundTextureTween);
			
			addChild(titleText);	
			var titleTextTween:Tween = new Tween(titleText, 0.5);
			titleTextTween.animate("malpha", 1);
			Starling.juggler.add(titleTextTween);
			
			addChild(highScoreText);
			var highScoreTween:Tween = new Tween(highScoreText, 0.5);
			highScoreTween.animate("malpha", 1);
			Starling.juggler.add(highScoreTween);
			
			addChild(nametag);
			var nametagTween:Tween = new Tween(nametag, 0.5);
			nametagTween.animate("malpha", 1);
			Starling.juggler.add(nametagTween);
			
		}
		
		public function onUpdate(e:Event):void
		{
			titleText.y = (StackIt.HEIGHT/100) * Math.sin(getTimer() * 0.002);
			//titleText.color0 = MutableColor.getColor(getTimer() * 0.0001);
		}
		
		public function onTriggered(e:Event):void
		{
			var buttonClicked:Button = e.target as Button;
			if((buttonClicked as Button) == btnPlay)
			{	
				var fadeTween:Tween = new Tween(this, 0.5);
				fadeTween.fadeTo(0);
				fadeTween.onComplete = function():void
				{
					dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN,{id: "play"},true));
				}
				Starling.juggler.add(fadeTween);
			}
			/*else if((buttonClicked as Button) == btnAbout)
			{
				var fadeTween:Tween = new Tween(this, 0.5);
				fadeTween.fadeTo(0);
				fadeTween.onComplete = function():void
				{
					dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN,{id: "about"},true));
				}
				Starling.juggler.add(fadeTween);
			}*/
		}
		
		
	}
}