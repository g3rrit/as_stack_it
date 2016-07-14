package com.pearisgreen.etc
{
	import starling.utils.Color;

	public class MutableColor
	{
		
		private static var inR:Boolean = false;
		private static var inG:Boolean = true;
		private static var inB:Boolean = false;
		/*
		private var activeColor:uint;
		
		private var timeValue:Number = 0;
		
		public function MutableColor(_color:uint)
		{
				
			activeColor = _color;
		}*/
		
		private static const redConst:Number = 0.02;
		private static const greenConst:Number = 0.03;
		private static const blueConst:Number = -0.04;
		
		public static const productConst:Number = (2 * Math.PI)/0.01;
		
		public static function getColor(colornum:Number):uint
		{
			if(colornum > 1)
				colornum -= Math.floor(colornum);
			
			if(colornum < 0)
				colornum += Math.ceil(colornum);
			
			var _r = 127 * Math.sin(colornum * productConst * redConst) + 127;
			var _g = 127 * Math.sin(colornum * productConst * greenConst) + 127;
			var _b = 127 * Math.sin(colornum * productConst * blueConst) + 127;
			
			return Color.rgb(_r,_g,_b);
		}
		/*
		public static function getNextColor(activeColor:uint):uint
		{	
			//var inR:Boolean = false;
			//var inG:Boolean = false;
			//var inB:Boolean = false;
			
			var _r = Color.getRed(activeColor);
			var _g = Color.getGreen(activeColor);
			var _b = Color.getBlue(activeColor);
			
			if(_r <= 11)
				inR = true;
			if(_g <= 16)
				inG = true;
			if(_b <= 21)
				inB = true;
			
			if(_r >= 244)
				inR = false;
			if(_g >= 239)
				inG = false;
			if(_b >= 234)
				inB = false;
			
			if(inR)
			{
				_r += 5;
			}
			else
			{
				_r -= 5;
			}
			
			if(inG)
			{
				_g += 10;
			}
			else
			{
				_g -= 10;
			}
			
			if(inB)
			{
				_b += 15;
			}
			else
			{
				_b -= 15;
			}
			
			//trace("RGB: ");
			//trace("R: " + _r);
			//trace("G: " + _g);
			//trace("B: " + _b);
			
			var resColor:uint = Color.rgb(_r,_g,_b);
			
			return resColor;
		}
		
		public static function getPreviousColor(activeColor:uint):uint
		{	
			//var inR:Boolean = true;
			//var inG:Boolean = true;
			//var inB:Boolean = true;
			
			var _r = Color.getRed(activeColor);
			var _g = Color.getGreen(activeColor);
			var _b = Color.getBlue(activeColor);
			
			if(_r <= 11)
				inR = true;
			if(_g <= 16)
				inG = true;
			if(_b <= 21)
				inB = true;
			
			if(_r >= 244)
				inR = false;
			if(_g >= 239)
				inG = false;
			if(_b >= 234)
				inB = false;
			
			if(inR)
			{
				_r += 5;
			}
			else
			{
				_r -= 5;
			}
			
			if(inG)
			{
				_g += 10;
			}
			else
			{
				_g -= 10;
			}
			
			if(inB)
			{
				_b += 15;
			}
			else
			{
				_b -= 15;
			}
			
			//trace("RGB: ");
			//trace("R: " + _r);
			//trace("G: " + _g);
			//trace("B: " + _b);
			
			var resColor:uint = Color.rgb(_r,_g,_b);
			
			return resColor;
		}
		
		/*
		public function get color():uint
		{
			return activeColor;
		}
		
		public function set color(_color:uint):void
		{
			activeColor = _color;
		}*/
	}
}