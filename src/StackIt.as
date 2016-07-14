package
{
	import com.pearisgreen.core.Game;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	public class StackIt extends Sprite
	{
		private var starling:Starling;
		
		public static var HEIGHT:uint;
		public static var WIDTH:uint;
		
		public static var viewPort:Rectangle;
		
		public function StackIt()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			//stage.fullScreenSourceRect = new Rectangle(0,0,480,800);
			//stage.displayState = StageDisplayState.FULL_SCREEN;
			stage.color = 0x000000;
			
			//original with: 480, height: 800
			WIDTH = stage.fullScreenWidth;//480;//1440//stage.fullScreenWidth;
			HEIGHT = stage.fullScreenHeight;//800;//2560//stage.fullScreenHeight;
			
			viewPort = new Rectangle(0,0, WIDTH,HEIGHT);
			
			starling = new Starling(Game,stage,viewPort);
			starling.antiAliasing = 1;
			
			starling.start();
		}
	}
}