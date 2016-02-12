package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
  
	
	
    public class Coin extends FlxSprite
    {
		[Embed(source = "../../data/Coin.png")] private var Img:Class;
		[Embed(source = "../../data/Sounds/coin.mp3")] private var Snd:Class;

		
		public function Coin(X:Number,Y:Number):void
		{
			super(X, Y, Img);
			
			loadGraphic(Img, true, false, 32, 32);
			
			offset.x = 6;
			offset.y = 4;
			height = 24;
			width = 20;
			
			addAnimation("normal", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19], 12);
			play("normal");
		}

		override public function kill():void
		{
			
			
			if (dead)
				return;
			FlxG.flash(0xffFFFFFF, 0.35);
			FlxG.play(Snd);
			super.kill()
				
				
		}

		
	}
	
}