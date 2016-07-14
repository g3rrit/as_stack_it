package com.pearisgreen.objects
{
	import flash.utils.getTimer;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Block extends Sprite
	{
		private var xPos:Number;
		private var yPos:Number;
		
		private var quad:Quad;
		
		public function Block(width:Number, color:uint)
		{
			super();
			
			//maximum with for quad 160 - 1/3 of screem
			this.quad = new Quad(width, StackIt.HEIGHT/16, color)
			setY(StackIt.HEIGHT/3);
			//setX(250);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			onUpdate(null);
			addChild(quad);
			
			addEventListener(Event.ENTER_FRAME, onUpdate);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		public function onRemoved(e:Event):void
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			removeEventListener(Event.ENTER_FRAME, onUpdate);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		public function onUpdate(e:Event):void
		{
			setX(StackIt.WIDTH/3 * Math.cos(getTimer() * 0.002) + StackIt.WIDTH/2);
		}
		
		public function setX(x:Number):void
		{
			this.xPos = x;
			this.quad.x = x - quad.width/2;
		}
		
		public function setY(y:Number):void
		{
			this.yPos = y;
			this.quad.y = y - quad.height/2;
		}
		
		public function get xpos():Number
		{
			return xPos;
		}
		
		public function get w():Number
		{
			return quad.width;
		}
		
		public function set w(_w:Number):void
		{
			xPos += (_w - quad.width)/2;
			quad.width = _w;
			quad.x = xPos + quad.width/2;
		}
		
		public function set acolor(_color:uint):void
		{
			quad.color = _color;
		}
		
		public function get acolor():uint
		{
			return quad.color;
		}
	}
}