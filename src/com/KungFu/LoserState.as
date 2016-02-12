package com.KungFu 
{
	import org.flixel.*;
	

	public class LoserState extends FlxState
	{
		
		
		//Fonts
		[Embed(source = "../../data/BitmapFont2.png")] private var ImgBitmapFont:Class;
		[Embed(source = "../../data/Sounds/Death2.mp3")] private var SndDeath:Class;
		
		private var _master:Master;
		public static var layer0:FlxLayer;		
		public static var layer1:FlxLayer;
		public static var layer2:FlxLayer;		
		public static var layer3:FlxLayer;
		public static var layerHUD:FlxLayer;
		
		private var _line1:BFont;
		private var _line2:BFont;
		private var _line3:BFont;
		private var _line4:BFont;
		private var _timer:Number = 2;
		
		
		
		public function LoserState() 
		{
			
			super();
			
			
			
			layer0 = new FlxLayer();
			layer1 = new FlxLayer();
			layer2 = new FlxLayer();
			layer3 = new FlxLayer();
			layerHUD = new FlxLayer();
			
			FlxG.flash(0xff000000, 1);x
			_master = new Master(68, 14)
			layer0.add(_master);	
			
			_line1 = new BFont(160, 200, "Hello there.\nHow\nI hope", ImgBitmapFont, 9, 12, 33, 0, 0,"center")
			layerHUD.add(_line1);
			_line1.update_text("Your SUCK-FU is strong!\n\nPress X to continue");
			_line1.alpha = 0;
			
			this.add(layer0);  //Since this is the first layer it will be in the background
			this.add(layer1);  //Since this is the second layer it goes in the middle
			this.add(layer2);  //The is layer which is the foreground effects
			this.add(layer3);  //The is the final layer which is the VERY foreground
			this.add(layerHUD);  //The is the final layer which is the VERY foreground
			FlxG.play(SndDeath);
			bgColor = 0xff000000;
			
			
		}
		
		override public function update():void
		{
			
			
			if ( _timer > 0)
			{
				_timer -= FlxG.elapsed;
				_line1.alpha += FlxG.elapsed * 0.5
			}
			
			if (FlxG.keys.justPressed("X") && _timer <= 0 )
			{
				FlxG.switchState(SelectState)
			}
			
			super.update();
			
		}
		

		
		
	}
	
}