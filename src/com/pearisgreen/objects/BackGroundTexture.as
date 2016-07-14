package com.pearisgreen.objects
{
	import com.pearisgreen.etc.MutableColor;
	
	import flash.utils.getTimer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class BackGroundTexture extends Sprite
	{
		private var previousTime:Number = 0;
		private var deltaTime:Number = 0;
		
		private var tiles:Array;
		
		private var color0:uint;
		private var color1:uint;
		private var color2:uint;
		
		private var numberSequenze:Array;
		private var sequenzePos:uint = 0;
		
		public function BackGroundTexture(_colornum:Number)
		{
			super();
			
			//20 * 12 tiles
			tiles = new Array(240);
			
			var ncolor:int = 0;
			
			color0 = 0xffffff ^ MutableColor.getColor(_colornum);
			color1 = 0xffffff ^ MutableColor.getColor(_colornum + 0.008);
			color2 = 0xffffff ^ MutableColor.getColor(_colornum + 0.016);
			
			var size:uint = StackIt.HEIGHT/20;
			
			for(var i:Number = 0; i < 20; i++)
			{
				for(var n:Number = 0; n < 12; n++)
				{
					tiles[i * 12 + n] = new fadingQuad(size,size);
					
					tiles[i * 12 + n].x = size * n;
					tiles[i * 12 + n].y = size * i;
					tiles[i * 12 + n].alpha = 0.8;
					
					ncolor = 3*Math.random();
					if(ncolor <= 1)
					{
						tiles[i * 12 + n].color = color0;
					}
					else if(ncolor <= 2 && ncolor > 1)
					{
						tiles[i * 12 + n].color = color1;
					}
					else
					{
						tiles[i * 12 + n].color = color2;
					}
				}
			}
			
			//generate a random pattern
			numberSequenze = new Array(240);
			
			var numberV:Vector.<int> = new Vector.<int>();
			for(var m:uint = 0; m < numberSequenze.length; m++)
			{
				numberV.push(m);
			}
			
			for(var k:int = 0; k < numberSequenze.length; k++)
			{
				var randNumber:uint = Math.round((numberV.length - 1) * Math.random());
				
				numberSequenze[k] = numberV[randNumber];
					
				numberV.splice(randNumber,1);
				
				trace(randNumber);
				
				/*
				for(var m:uint = 0; m < k; m++)
				{
					if(randNumber == numberSequenze[m])
						randNumber = Math.round(239 * Math.random());
				}
				*/
				//
			}
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			for each(var qua:Quad in tiles)
			{
				addChild(qua);
			}
			
			addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		public function onUpdate(e:Event):void
		{
			deltaTime += getTimer() - previousTime;
			
			previousTime = getTimer();
			
			if(deltaTime >= 40)
			{
				deltaTime = 0;
				setRandomColor();
			}
			
		}
		
		public function onColorChange(_currentColor:uint):void
		{
			color2 = color1;
			color1 = color0;
			color0 = 0xffffff ^ _currentColor;
		}
		
		public function setRandomColor():void
		{
			for(var i:int = 0; i < 2; i++)
			{	
				var tile:fadingQuad = tiles[numberSequenze[sequenzePos]];
				sequenzePos ++;
				if(sequenzePos >= 240)
					sequenzePos = 0; 
				
				var fadeTween:Tween = new Tween(tile, 0.2);
				
				var ncolor:Number = 3*Math.random();
				if(ncolor <= 1)
				{
					//tile.color = color0;
					fadeTween.animate("colorR", Color.getRed(color0));
					fadeTween.animate("colorG", Color.getGreen(color0));
					fadeTween.animate("colorB", Color.getBlue(color0));
				}
				else if(ncolor <= 2 && ncolor > 1)
				{
					//tile.color = color1;
					fadeTween.animate("colorR", Color.getRed(color1));
					fadeTween.animate("colorG", Color.getGreen(color1));
					fadeTween.animate("colorB", Color.getBlue(color1));
				}
				else
				{
					//tile.color = color2;
					fadeTween.animate("colorR", Color.getRed(color2));
					fadeTween.animate("colorG", Color.getGreen(color2));
					fadeTween.animate("colorB", Color.getBlue(color2));
				}	
				
				Starling.juggler.add(fadeTween);
			}
		}
		
		//alpha can range from 0 - 239
		public function set malpha(_alpha:Number):void
		{
			for each(var qua:Quad in tiles)
			{
				qua.alpha = _alpha;
			}
			
			/*
			trace(_alpha);
			
			for(var i:Number = 239; i > Math.ceil(_alpha); i--)
			{
				tiles[i].alpha = 0;
			}
			
			//tiles[Math.ceil(_alpha)].alpha = 0.5;//_alpha - Math.floor(_alpha);*/
		}
		
		public function get malpha():Number
		{
			
			/*
			var _alpha:Number;
			
			for each(var qua:Quad in tiles)
			{
				_alpha += qua.alpha;
			}*/
			
			return tiles[0].alpha
		}
		
		public function getColor():uint
		{
			return color0;
		}

	}
}