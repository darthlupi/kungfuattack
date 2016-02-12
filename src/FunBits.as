package com.KungFu 
{
	import org.flixel.*;
	

	public class FunBits extends FlxState
	{
		
		
		//Fonts
		[Embed(source = "../../data/FunBits.png")] private var Img:Class;
		[Embed(source = "../../data/FunTitle.png")] private var ImgTitle:Class;
		[Embed(source = "../../data/sounds/FunBits.mp3")] private var SndBits:Class;
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
		
		private var _fun_bits:FlxSprite;
		
		private var tmp:FlxSprite;
		
		private var go:Number = 0;
		private var count:Number = 0;
		
		public function FunBits() 
		{
			
			super();
		
			layer0 = new FlxLayer();
			layer1 = new FlxLayer();
			layer2 = new FlxLayer();
			layer3 = new FlxLayer();
			layerHUD = new FlxLayer();

			//FlxG.fade(0xff000000, 1, gotoComplete, true );
			bgColor = 0xffC7C9D9;
			
			FlxG.flash(0xff000000,0.8);
			
			FlxG.play(SndBits);
			
			tmp= new FlxSprite(-320, -30);
			tmp.loadGraphic(ImgTitle, true, true, 320, 240);
			//tmp.addAnimation("normal", [0], 8);
			//tmp.play("normal");
			//tmp.scale.x = tmp.scale.y = 0.8;
			tmp.antialiasing = false
			tmp.velocity.x = 650;
			layer1.add(tmp);		
			
			_fun_bits = new FlxSprite(60, 103);
			_fun_bits.loadGraphic(Img, true, true, 200, 200);
			_fun_bits.addAnimation("normal", [0, 1, 2, 3], 8);
			_fun_bits.facing = 1;
			_fun_bits.play("normal");
			_fun_bits.scale.x = _fun_bits.scale.y = 0.5;
			_fun_bits.antialiasing = false
			layer1.add(_fun_bits);			
			
			this.add(layer0);  //Since this is the first layer it will be in the background
			this.add(layer1);  //Since this is the second layer it goes in the middle
			this.add(layer2);  //The is layer which is the foreground effects
			this.add(layer3);  //The is the final layer which is the VERY foreground
			this.add(layerHUD);  //The is the final layer which is the VERY foreground
		}
		
		override public function update():void
		{
			
			//if ( tmp.velocity.x > 0)
			//{
				
			//}
			
			if ( go == 0)
			{
				tmp.velocity.x -= FlxG.elapsed * 560;
				
			}
			
			if ( tmp.velocity.x < -240 || go != 0 )
			{
				tmp.velocity.x = 0;
				
				go = 1;
				count += FlxG.elapsed;
			}			
			
			if ( count > 2.1)
			{
				FlxG.fade(0xff000000, 0.5, gotoComplete );
			}
			

			
			super.update();
			
		}
		
		private function gotoComplete():void
		{
			//FlxG.switchState(FunBits);
			FlxG.switchState(MenuState);		
		}
		
		
	}
	
}