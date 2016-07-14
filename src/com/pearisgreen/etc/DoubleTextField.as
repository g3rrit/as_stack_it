package com.pearisgreen.etc
{
	import flash.geom.Rectangle;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class DoubleTextField extends Sprite
	{
		private var text0:TextField;
		private var text1:TextField;
		
		public function DoubleTextField(width:int, height:int, text:String, fontSize:Number=12, color:uint=0, color0:uint=0xffffff, bold:Boolean=false)
		{
			text0 = new TextField(width, height, text, "bitFontFilled", fontSize, color0, bold);
			text1 = new TextField(width, height, text, "bitFontBorder", fontSize, color, bold);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			addChild(text0);
			addChild(text1);
		}
		
		public function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			removeChild(text1);
			removeChild(text0);
		}
		
		
		override public function set pivotY(_pivoty:Number):void
		{
			text1.pivotY = _pivoty;
			text0.pivotY = _pivoty;
		}
		
		override public function set pivotX(_pivotx:Number):void
		{
			text1.pivotX = _pivotx;
			text0.pivotX = _pivotx;
		}
		
		override public function set y(_y:Number):void
		{
			text1.y = _y;
			text0.y = _y;
		}
		
		override public function set x(_x:Number):void
		{
			text1.x = _x;
			text0.x = _x;
		}
		
		public function set fontSize(_fs:Number):void
		{
			text1.fontSize = _fs;
			text0.fontSize = _fs;
		}
		
		public function get fontSize():Number
		{
			return text0.fontSize;
		}
		
		public function set text(_text:String):void
		{
			text1.text = _text;
			text0.text = _text;
		}
		
		public function set color0(_color:uint):void
		{
			text0.color = _color;
		}
		
		public function set color1(_color:uint):void
		{
			text1.color = _color;
		}
		
		override public function set alpha(_alpha:Number):void
		{
			text1.alpha = _alpha;
			text0.alpha = _alpha;
		}
		
		public function set hAlign(_halign:String):void
		{
			text1.hAlign = _halign;
			text0.hAlign = _halign;
		}
		
		public function set vAlign(_valign:String):void
		{
			text1.vAlign = _valign;
			text0.vAlign = _valign;
		}
		
		public function get textBounds():Rectangle
		{
			return text0.textBounds;
		}
		
		public function get malpha():Number
		{
			return text0.alpha;
		}
		
		public function set malpha(_alpha:Number):void
		{
			text0.alpha = _alpha;
			text1.alpha = _alpha;
		}
	}
}