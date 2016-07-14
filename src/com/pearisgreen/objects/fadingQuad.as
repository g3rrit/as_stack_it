package com.pearisgreen.objects
{
	import starling.display.Quad;
	import starling.utils.Color;
	
	public class fadingQuad extends Quad
	{
		public function fadingQuad(width:Number, height:Number, color:uint=16777215, premultipliedAlpha:Boolean=true)
		{
			super(width, height, color, premultipliedAlpha);
		}
		
		//RED
		public function set colorR(_r:Number):void
		{
			var re = _r;
			var gr = Color.getGreen(this.color);
			var bl = Color.getBlue(this.color);
			
			this.color = Color.rgb(re,gr,bl);
		}
		
		public function get colorR():Number
		{
			return Color.getRed(this.color);
		}
		
		//GREEN
		public function set colorG(_g:Number):void
		{
			var re = Color.getRed(this.color);
			var gr = _g;
			var bl = Color.getBlue(this.color);
			
			this.color = Color.rgb(re,gr,bl);
		}
		
		public function get colorG():Number
		{
			return Color.getGreen(this.color);
		}
		
		//BLUE
		public function set colorB(_b:Number):void
		{
			var re = Color.getRed(this.color);;
			var gr = Color.getGreen(this.color);
			var bl = _b;
			
			this.color = Color.rgb(re,gr,bl);
		}
		
		public function get colorB():Number
		{
			return Color.getBlue(this.color);
		}
	}
}