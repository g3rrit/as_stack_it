package com.pearisgreen.objects
{
	import com.pearisgreen.events.mEvent;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class BlockManager extends Sprite
	{
		private var stackCountS:Number = 0;
		
		private var activeBlock:Block;	
			
		private var stackBlock:StackBlock;
			
		private var fadingQuad:Quad;
		
		private var backGroundQuad:Quad;
		
		public function BlockManager(startingColornum:Number)
		{
			super();
			
			backGroundQuad = new Quad(StackIt.WIDTH,StackIt.HEIGHT);
			backGroundQuad.alpha = 0;
			
			stackBlock = new StackBlock(startingColornum);
			stackBlock.alpha = 0;
			
			activeBlock = new Block(StackIt.WIDTH/3, stackBlock.acolor);
			activeBlock.alpha = 0;
			
			fadingQuad = new Quad(StackIt.HEIGHT/16,StackIt.HEIGHT/16);
			fadingQuad.color = 0xAAAAAA;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			addChild(backGroundQuad);
			
			addChild(stackBlock);
			
			addChild(activeBlock);
			
			intro();
		}
		
		public function intro():void
		{
			var stackBlockTween:Tween = new Tween(stackBlock, 0.5);
			stackBlockTween.fadeTo(1);
			Starling.juggler.add(stackBlockTween);
			
			var activeBlockTween:Tween = new Tween(activeBlock, 0.5);
			activeBlockTween.fadeTo(1);
			activeBlockTween.onComplete = function():void 
			{
				addEventListener(TouchEvent.TOUCH, onClick);
			};
			Starling.juggler.add(activeBlockTween);
		}
		
		public function onClick(e:TouchEvent):void
		{
			removeEventListener(TouchEvent.TOUCH, onClick);
			
			removeChild(activeBlock);
			
			//getTopquad
			var topQuad:Quad = stackBlock.getHighestQuad();
			
			//set new quad of stackBlock
			var deltaX:Number = (activeBlock.xpos - (topQuad.x + topQuad.width/2));
			var newWidth:Number = topQuad.width - Math.abs(deltaX);
			
			if(newWidth > StackIt.WIDTH/200)
			{	
				activeBlock.w = newWidth;
				
				var newXpos:Number = 0;//activeBlock.xpos - newWidth/2;
				
				
				//set pos and size of fadingQuad
				fadingQuad.alpha = 1;
				fadingQuad.y = (StackIt.HEIGHT*29)/96;
				var fadeBlock:Boolean = true;
				
				if(deltaX > StackIt.WIDTH/96)
				{
					stackCountS = 0;
					newXpos = topQuad.x + deltaX;
					fadingQuad.x = topQuad.x + topQuad.width;
					fadingQuad.width = deltaX;
					fadeBlock = true
				}
				else if(deltaX < -StackIt.WIDTH/96)
				{
					stackCountS = 0;
					newXpos = topQuad.x;
					fadingQuad.x = topQuad.x + deltaX;
					fadingQuad.width = deltaX * (-1);
					fadeBlock = true;
				}
				else
				{
					stackCountS ++;
					newXpos = topQuad.x;
					newWidth = topQuad.width;
					fadeBlock = false;
				}
				
				if(stackCountS >= 5 && newWidth < StackIt.WIDTH/3)
				{
					newWidth += StackIt.WIDTH/48;
					newXpos -= StackIt.WIDTH/96;
				}
				
				stackBlock.setQuadTo(newWidth, newXpos);
			
				if(fadeBlock)
				{	
					//add fadingQuad
					fadingQuad.color = activeBlock.acolor;
					addChild(fadingQuad);
					var fadingQuadTween:Tween = new Tween(fadingQuad, 0.7);
					fadingQuadTween.animate("y", (StackIt.HEIGHT*35)/96);
					fadingQuadTween.fadeTo(0);
					Starling.juggler.add(fadingQuadTween);
				}
				
				activeBlock.acolor = stackBlock.acolor;
			
				//fade and move quads down with a tween
				var quadTween:Tween = new Tween(stackBlock,0.7);
				quadTween.animate("ypos",(StackIt.HEIGHT*35)/96);
				quadTween.onComplete = function():void {onFaded();};
				Starling.juggler.add(quadTween);
				
				dispatchEvent(new mEvent(mEvent.SCORE_UP, true, {currentColor: activeBlock.acolor}));//,{newcolor: activeBlock.acolor}));
			
			}
			else
			{
				var lostQuad:Quad = new Quad(activeBlock.w, StackIt.HEIGHT/16);
				lostQuad.x = activeBlock.xpos - activeBlock.w/2;
				lostQuad.y = (StackIt.HEIGHT*29)/96;
				lostQuad.color = activeBlock.acolor;
				addChild(lostQuad);
				var lostTween:Tween = new Tween(lostQuad, 0.7);
				lostTween.animate("y", (StackIt.HEIGHT*35)/96);
				lostTween.fadeTo(0);
				Starling.juggler.add(lostTween);
				
				onLost();
			}
		}
		
		public function onFaded():void
		{
			removeChild(fadingQuad);
			
			addChild(activeBlock);
			
			addEventListener(TouchEvent.TOUCH, onClick);
		}
		
		private function onLost():void
		{
			dispatchEvent(new mEvent(mEvent.GAME_LOST,true));
		}
		
	}
}