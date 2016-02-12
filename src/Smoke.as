package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
   
   
	
	
    public class Smoke extends FlxSprite
    {
        [Embed(source = "../../data/GreenSmoke.png")] private var Img:Class;


		
        function Smoke(X:Number, Y:Number,XV:Number=0,YV:Number=0):void
        {
			super(X, Y, Img);
			loadGraphic(Img, true, true, 16, 16);
			x = X;
			y = Y;
			velocity.x = XV;
			velocity.y = YV;
			acceleration.y = -40;
			angle = Math.random() * 360;
			addAnimation("normal", [0, 1, 2, 3, 4, 5], 10)
			play("normal");
        }
           
        //All of the game action goes here
        override public function update():void
        {
			if (finished)
				kill();
			super.update();	
		}

		
		override public function kill():void 
		{
			if(dead)
				return;	
			super.kill();
		}
		
		public function resetObject(X:Number, Y:Number,XV:Number=0,YV:Number=0):void 
		{
			x = X;
			y = Y;
			velocity.x = XV;
			velocity.y = YV;
			dead = false;
			exists = true;
			visible = true;
			finished = false;
			play("normal"); //Play the animation
		}
		
	}

}