package com.pearisgreen.etc
{
	import com.pearisgreen.assets.Assets;
	
	import starling.display.Button;
	
	public class myButton extends Button
	{
		public function myButton(text:String="")
		{
			super(Assets.getTexture("nButton"), text,Assets.getTexture("pButton"));
			
			fontName = "bitFontBorder";
			fontColor = 0x00000;
			fontSize = StackIt.HEIGHT/22;
			width = StackIt.WIDTH/3;
			height = (StackIt.HEIGHT)/10;
			//btnPlay.scaleX = StackIt.WIDTH/480;
			//btnPlay.scaleY = StackIt.HEIGHT/800
		}
	}
}