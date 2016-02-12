package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
   
   
	
	
    public class Smack extends FlxSprite
    {
        [Embed(source = "../../data/Smack.png")] private var Img:Class;


		
        function Smack(X:Number, Y:Number,XV:Number=0,YV:Number=0):void
        {
			super(X, Y, Img);
			loadGraphic(Img, true, true, 16, 16);
			x = X;
			y = Y;
			velocity.x = XV;
			velocity.y = YV;
			//acceleration.y = -40;
			//angle = Math.random() * 360;
			addAnimation("normal", [0, 1, 2, 3, 4], 20)
			
			addAnimation("normal2", [0, 5, 6, 7, 8], 20)
			
			addAnimation("normal3", [0, 9, 10, 11, 12], 20)
			
			var rand:int = Math.random() * 4;
			if (rand <= 1)
				play("normal3");
			else if (rand > 1 && rand <= 2)
				play("normal");
			else
				play("normal2");
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
			play("normal"); //Play the animation
		}
		
	}

}