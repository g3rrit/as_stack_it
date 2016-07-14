package com.pearisgreen.scenes
{
	import com.pearisgreen.etc.DoubleTextField;
	import com.pearisgreen.etc.myButton;
	import com.pearisgreen.events.NavigationEvent;
	import com.pearisgreen.events.mEvent;
	import com.pearisgreen.objects.BackGroundTexture;
	import com.pearisgreen.objects.BlockManager;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class GameScene extends Sprite
	{	
		private var startingColornum:Number;
		
		private var score:Number = 0;
		private var scoreText:DoubleTextField;
		private var highScoreText:DoubleTextField;
		
		private var backGroundQuad:Quad;
		
		private var backGroundTexture:BackGroundTexture;
		
		private var blockManager:BlockManager;
		
		//lost stuff
		private var backButton:myButton;
		private var replayButton:myButton;
		
		public function GameScene()
		{
			super();
			
			startingColornum = Math.random();//Color.rgb(Math.round(255 * Math.random()),Math.round(255 * Math.random()),Math.round(255 * Math.random()));
			
			backGroundQuad = new Quad(480,800);
			backGroundQuad.color = 0x000000;
			
			scoreText = new DoubleTextField(StackIt.WIDTH,StackIt.HEIGHT/2,"SCORE: 0");
			scoreText.color0 = 0x00ffff;
			scoreText.hAlign = HAlign.CENTER;
			scoreText.vAlign = VAlign.TOP;
			scoreText.fontSize = StackIt.HEIGHT/40;
			//scoreText.x = -(StackIt.WIDTH - scoreText.textBounds.width)/2;
			scoreText.alpha = 0;
			
			highScoreText = new DoubleTextField(StackIt.WIDTH,StackIt.HEIGHT/2,"HIGHSCORE: 0");
			highScoreText.color0 = 0x00ffff;
			highScoreText.hAlign = HAlign.CENTER;
			highScoreText.vAlign = VAlign.TOP;
			highScoreText.fontSize = StackIt.HEIGHT/35;
			highScoreText.alpha = 0;
			highScoreText.y = StackIt.HEIGHT/3.5;
			
			backGroundTexture = new BackGroundTexture(startingColornum);
			backGroundTexture.malpha = 0;
			
			blockManager = new BlockManager(startingColornum);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);	
		}
		
		public function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);	
			
			addChild(backGroundQuad);
			
			addChild(backGroundTexture);
			var backGroundTextureTween:Tween = new Tween(backGroundTexture, 0.5);
			backGroundTextureTween.animate("malpha", 1);
			backGroundTextureTween.onComplete = function():void 
			{
				addChild(blockManager);
			}
			Starling.juggler.add(backGroundTextureTween);
			
			addChild(scoreText);
			var scoreTween:Tween = new Tween(scoreText, 0.5);
			scoreTween.animate("malpha", 1);
			Starling.juggler.add(scoreTween);
			
			addEventListener(mEvent.SCORE_UP, onScoreUp);
			addEventListener(mEvent.GAME_LOST, onLost);
		}
		
		public function onLost(e:mEvent):void
		{
			var highScoreInt:uint = 0;
			
			/*
			var file:File = File.applicationStorageDirectory;
			file = file.resolvePath("highscore.sc");
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file,FileMode.READ);
			highScoreInt = fileStream.readUnsignedInt();
			fileStream.close();
			
			if(score > highScoreInt)
			{
				highScoreInt = score;
				var fileStreamOut:FileStream = new FileStream();
				fileStreamOut.open(file,FileMode.WRITE);
				fileStreamOut.writeUnsignedInt(score);
				fileStreamOut.close();	
			}*/
			//
			
			//SCORE
			var scoreTween:Tween = new Tween(scoreText, 0.5);
			scoreTween.animate("fontSize", StackIt.HEIGHT/20);
			scoreTween.moveTo(0, StackIt.HEIGHT/6);
			//scoreTween.animate("hAlign", HAlign.CENTER);
			scoreTween.onComplete = function():void 
			{
				addEventListener(Event.TRIGGERED, onButton);
			}
			Starling.juggler.add(scoreTween);
			
			//highscore
			highScoreText.text = "HIGHSCORE: " + highScoreInt;
			addChild(highScoreText);
			
			var highScoreTween:Tween = new Tween(highScoreText, 0.7);
			highScoreTween.animate("malpha", 1);;
			Starling.juggler.add(highScoreTween);
			
			//REPLAYBUTTON
			replayButton = new myButton("REPLAY");
			replayButton.x = StackIt.WIDTH/2 - replayButton.width/2;
			replayButton.y = (StackIt.HEIGHT*35)/96;
			replayButton.alpha = 0;
			addChild(replayButton);
			
			var replayTween:Tween = new Tween(replayButton, 0.7);
			replayTween.fadeTo(1);
			Starling.juggler.add(replayTween);
			
			//BACKBUTTON
			backButton = new myButton("BACK");
			backButton.x = StackIt.WIDTH/2 - backButton.width/2;
			backButton.y = StackIt.HEIGHT/2;
			backButton.alpha = 0;
			addChild(backButton);
			
			var backTween:Tween = new Tween(backButton, 0.5);
			backTween.fadeTo(1);
			Starling.juggler.add(backTween);
		}
		
		public function onButton(e:Event):void
		{
			removeEventListener(Event.TRIGGERED, onButton);
			
			var buttonClicked:Button = e.target as Button;
			if((buttonClicked as Button) == backButton)
			{	
				var fadeTween0:Tween = new Tween(this, 0.5);
				fadeTween0.fadeTo(0);
				fadeTween0.onComplete = function():void
				{
					dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN,{id: "menue"},true));
				}
				Starling.juggler.add(fadeTween0);
			}
			else if((buttonClicked as Button) == replayButton)
			{
				var fadeTween:Tween = new Tween(this, 0.5);
				fadeTween.fadeTo(0);
				fadeTween.onComplete = function():void
				{
					dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN,{id: "play"},true));
				}
				Starling.juggler.add(fadeTween);
			}
		}
		
		public function onScoreUp(e:mEvent):void
		{
			score ++;
			scoreText.text = "SCORE: " + score;
			
			backGroundTexture.onColorChange(e.data.currentColor);
		}
	}
}