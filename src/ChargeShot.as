package com.KungFu
{
	import flash.filters.BlurFilter;
    import org.flixel.*;
    import flash.geom.Point;

    public class ChargeShot extends FlxSprite
    {
		[Embed(source = "../../data/ChargeShot.png")] private var Img:Class;
		public function ChargeShot(X:Number, Y:Number):void 
		{
			super(X,Y,Img);
			loadGraphic(Img, true, true, 280, 32);
			addAnimation("normal", [1,0, 1, 2,3,4], 18);
			play("normal");
		}
		
        //All of the game action goes here
        override public function update():void
        {
            
			if (dead)
			{
				
				if(finished) exists = false;
                else
                    super.update();
                return;
            }
			
			if (finished)
			{
				kill();
			}
			
			super.update();
		}
		
	}

}