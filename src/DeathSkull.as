package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
  
	
	
    public class DeathSkull extends FlxSprite
    {
		[Embed(source = "../../data/DeathSkull.png")] private var Img:Class;
		[Embed(source = "../../data/Sounds/Death1.mp3")] private var SndDeath:Class;
		
		private var _glow:FlxSprite;
		public var acid_splash:FlxEmitter;
		private var _count_down:Number = 1;
		private var scale_speed:Number = 0;
		
		public function DeathSkull(X:Number,Y:Number):void
		{

			super(X, Y, null);
			width = 120;
			height = 120;
			x = X;
			y = Y;
			loadGraphic(Img, true, false, 120, 120);

			scrollFactor.x = scrollFactor.y = 0;
			origin.x = width / 2;
			origin.y = height / 2 + 10;
			
			FlxG.play(SndDeath);
			
			
			
			offset = origin;

			
		}
		
		override public function update():void
		{
			super.update();
			
			if (scale.x > 5 && ( FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") ))
			{
				FlxG.switchState(SelectState);
			}
			
			if (scale.x > 47)
				FlxG.switchState(LoserState);
			
			scale_speed += FlxG.elapsed * 18;
			scale.x += FlxG.elapsed * scale_speed;
			scale.y += FlxG.elapsed * scale_speed;
			
		}
		
	}
	
}