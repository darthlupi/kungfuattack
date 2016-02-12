package com.KungFu
{
	import org.flixel.*;
	
	public class BouncyBlock extends FlxSprite
	{
		[Embed(source = "../../data/BouncyBlock.png")] private var ImgBouncyBlock:Class;
	
		private var _start_y:Number;
		private var _start_x:Number;	
		
		//Temp count down to jumping
		private var _count_down:Number = 0;
		
		public function BouncyBlock(X:Number, Y:Number):void
		{
			super( X, Y);
			loadGraphic(ImgBouncyBlock, true, true, 32, 32);
			height = 30; 
			_start_y = Y;
			_start_x = X;
			acceleration.y = 500;
			drag.x = drag.y = 0;
		}

	}

}