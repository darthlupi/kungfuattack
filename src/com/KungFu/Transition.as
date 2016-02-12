package com.KungFu 
{
	import org.flixel.*;
	

	public class Transition extends FlxState
	{
		
		
		//Fonts
		[Embed(source = "../../data/BitmapFont2.png")] private var ImgBitmapFont:Class;
		
		private var _master:FlxSprite;
		public static var layer0:FlxLayer;		
		public static var layer1:FlxLayer;
		public static var layer2:FlxLayer;		
		public static var layer3:FlxLayer;
		public static var layerHUD:FlxLayer;
		
		private var _line1:BFont;
		private var _line2:BFont;
		private var _line3:BFont;
		private var _line4:BFont;
		
		
		
		public function Transition() 
		{
			
			super();
		
			layer0 = new FlxLayer();
			layer1 = new FlxLayer();
			layer2 = new FlxLayer();
			layer3 = new FlxLayer();
			layerHUD = new FlxLayer();
			
			_master = new LevelFadeTransition(0, 0)
			layer0.add(_master);
			
			FlxG.fade(0xff000000, 1,gotoComplete,true );
			
			this.add(layer0);  //Since this is the first layer it will be in the background
			this.add(layer1);  //Since this is the second layer it goes in the middle
			this.add(layer2);  //The is layer which is the foreground effects
			this.add(layer3);  //The is the final layer which is the VERY foreground
			this.add(layerHUD);  //The is the final layer which is the VERY foreground
		}
		
		override public function update():void
		{
			
			super.update();
			
		}
		
		private function gotoComplete():void
		{

			FlxG.switchState(LevelComplete);		
		}
		
		
	}
	
}