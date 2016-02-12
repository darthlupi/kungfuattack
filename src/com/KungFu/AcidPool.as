package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
  
	
	
    public class AcidPool extends FlxSprite
    {
		[Embed(source = "../../data/AcidPool2.png")] private var Img:Class;
		[Embed(source = "../../data/AcidSplash.png")] private var ImgSplash:Class;
		
		public var glow:FlxSprite;
		public var acid_splash:FlxEmitter;
		private var _count_down:Number = 1;
		
		public function AcidPool(X:Number,Y:Number):void
		{

			super(X, Y, null);
			width = 384;
			height = 300;
			x = X;
			y = Y;
			//loadGraphic(null, true, false, 384, 400);
			createGraphic(width, height, 0xFFc4ff24);

			
			glow = new FlxSprite(0, y-50, Img);
			PlayState.layer3.add(glow);
			glow.loadGraphic(Img, true,false, 384, 50);
			glow.addAnimation("normal", [0, 1, 2, 3], 8);
			glow.play("normal");

			visible = true;
			addAnimation("normal", [0]);
			
			acid_splash = new FlxEmitter(x, y + 16, -0.5);
			acid_splash.createSprites(ImgSplash,20,true,PlayState.layer3);
			acid_splash.setXVelocity(-20,20);
			acid_splash.setYVelocity( -180, -100);
			acid_splash.gravity = 500;
			//_acid_splash.setRotation( -720, -720);
			PlayState.layer3.add(acid_splash);
			
			if (PlayState.acidpool_on)
			{
				velocity.y = -20;
				glow.velocity.y = velocity.y;
			}
			else 
			{
				velocity.y = 0;
				y += 100;
				visible = false;
				acid_splash.visible = false;
				glow.visible = false;
			}
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (_count_down > 0  )
			{
				_count_down -= FlxG.elapsed;
			}
			else if (PlayState.acidpool_on)
			{
				_count_down = 0.5;
				acid_splash.x = Math.random() * 384;
				acid_splash.setXVelocity(-20,20);
				acid_splash.setYVelocity( -180, -100);
				acid_splash.y = y + 16;
				for (var iii:int = 0; iii < 5;iii+=1)
					PlayState.acidpool.acid_splash.emit();
				
			}
			
		}
		
	}
	
}