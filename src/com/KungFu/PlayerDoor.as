package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
  
	
	
    public class PlayerDoor extends FlxSprite
    {
		[Embed(source = "../../data/PlayerDoor.png")] private var Img:Class;
		
		private var _count_down:Number = 1;
		private var _count_down_reset:Number = 8;
		private var _enemy_ninjas:Array = new Array;
		private var _enemy_attacks:Array = new Array;
		private var _player:Player;
		
		public function PlayerDoor(X:Number,Y:Number):void
		{
			super(X, Y, Img);
			loadGraphic(Img, true, false, 64, 64);
			x = X + 16;
			y = Y + 16;				
			offset.x = 20
			offset.y = 16;
			width = 24;
			height = 32;
		
			
			visible = true;
			addAnimation("normal", [0,1], 2);
			play("normal");

			
			
		}
				
		
		
	}
	
}