package com.pearisgreen.objects
{
	import com.pearisgreen.etc.MutableColor;
	import com.pearisgreen.scenes.GameScene;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	public class StackBlock extends Sprite
	{
		private var xPos:Number;
		private var yPos:Number;
		
		private var startingyPos:int;
		
		private var quadArray:Array;
		
		private var activeColorNum:Number;
		
		//private var mutableColor:MutableColor;
		
		public function StackBlock(startingColorNum:Number)
		{
			this.xPos = StackIt.WIDTH/3;
			this.yPos = (StackIt.HEIGHT*35)/96;
			this.startingyPos = (StackIt.HEIGHT*35)/96;
			
			activeColorNum = startingColorNum;//Color.rgb(Math.round(255 * Math.random()),Math.round(255 * Math.random()),Math.round(255 * Math.random()));
			
			//mutableColor = new MutableColor(activeColor);
			
			quadArray = new Array(11);
			for(var i:Number = 0; i < quadArray.length; i++)
			{
				quadArray[i] = new Quad(StackIt.WIDTH/3,StackIt.HEIGHT/16);
				quadArray[i].x = xPos;
				quadArray[i].y = yPos + i * StackIt.HEIGHT/16;
				//activeColor += 800;
				quadArray[i].color = MutableColor.getColor(activeColorNum - 0.008);
			}
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			for(var i:Number = 0; i < quadArray.length; i++)
			{
				addChild(quadArray[i]);
			}
		}
		
		public function get ypos():Number
		{
			return yPos;
		}
		
		public function set ypos(_y:Number):void
		{			
			for each(var qua:Quad in quadArray)
			{
				qua.y = (qua.y - yPos) + _y;
			}
			
			yPos = _y;
		}
		
		public function setQuadTo(_width:Number, _x:Number):void
		{
			var bottomQuad:Quad = quadArray[0];
			for each(var qua:Quad in quadArray)
			{
				if(qua.y > bottomQuad.y)
					bottomQuad = qua;
			}
			
			//250 = 29/96
			/*
			activeColor += 800;
			if(activeColor >= 55000)
				activeColor = 10000;*/
			var highestQuad = getHighestQuad();
			if(highestQuad.width >= _width)
			{
				bottomQuad.y = (StackIt.HEIGHT*29)/96;//250;
				bottomQuad.width = _width;
				bottomQuad.x = _x;
				bottomQuad.color = MutableColor.getColor(activeColorNum);
			}
			else
			{
				bottomQuad.y = (StackIt.HEIGHT*29)/96;//250;
				bottomQuad.width = highestQuad.width;
				bottomQuad.x = highestQuad.x;
				var expandingTween:Tween = new Tween(bottomQuad, 0.4);
				expandingTween.animate("x", _x);
				expandingTween.animate("width", _width);
				Starling.juggler.add(expandingTween);
				//bottomQuad.width = _width;
				//bottomQuad.x = _x;	
				
				bottomQuad.color = MutableColor.getColor(activeColorNum);
			}
			
			activeColorNum += 0.008;//= MutableColor.getNextColor(activeColor);
			
			yPos = (StackIt.HEIGHT*29)/96//250;
		}
		
		public function getHighestQuad():Quad
		{
			var topQuad:Quad = quadArray[0];
			for each(var qua:Quad in quadArray)
			{
				if(qua.y < topQuad.y)
					topQuad = qua;
			}
			
			return topQuad;
		}
		
		public function get acolor():uint
		{
			return MutableColor.getColor(activeColorNum);
		}
		
		//public function set acolor(_color:uint):void
		//{
		//	activeColorNum = _color;
		//}
		
		
	}
}