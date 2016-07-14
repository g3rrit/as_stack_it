package com.pearisgreen.assets
{
	import flash.display.Bitmap;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;

	public class Assets
	{
		//Font
		[Embed(source="/../res/font/BitFontFilled.ttf", embedAsCFF="false", fontFamily="bitFontFilled")]
		private static const BitFont:Class;
		
		[Embed(source="/../res/font/BitFontBorder.ttf", embedAsCFF="false", fontFamily="bitFontBorder")]
		private static const BitFontBorder:Class;
		
		public static function getFontFormat(_size:uint, _color:uint = 0xffffff):TextFormat
		{
			return new TextFormat("bitFont", _size, _color);
		}
		
		//Sprites
		[Embed(source="/../res/sprites/button_normal.png")]
		public static const nButton:Class;
		
		[Embed(source="/../res/sprites/button_pressed.png")]
		public static const pButton:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
	}
}