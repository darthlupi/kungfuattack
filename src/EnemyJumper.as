package com.KungFu
{
	import org.flixel.*;

	public class EnemyJumper extends FlxSprite
	{
		[Embed(source = "../../data/BouncyBlock.png")] private var ImgBouncyBlock:Class;

		public function EnemyJumper(X:int, Y:int) :void
		{
			super( X, Y);
			loadGraphic(ImgBouncyBlock, true, true, 32, 32);
			visible = false;
		}
	}
}