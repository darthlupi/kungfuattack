package com.KungFu
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
    import org.flixel.*;
    import flash.geom.Point;
  
	
	
    public class Master extends FlxSprite
    {
		[Embed(source = "../../data/Master.png")] private var Img:Class;
		
		private var _rect:Rectangle;
		private var _num_of_pieces:int = 0;
		private var _piece_height:int = 1;
		public var shimmer:Number = 40;
		
		
		
		public function Master(X:Number,Y:Number):void
		{

			super(X, Y, null);
			width = 200;
			height = 160;
			x = X;
			y = Y;
			loadGraphic(Img, true, false, 200, 160);
			
			addAnimation("normal", [4, 0, 1, 3, 0, 4, 1, 2, 3, 4, 5, 4, 3], 8);
			addAnimation("normal2", [4,0, 1, 3, 0, 4, 1, 2, 3, 4, 5, 4, 3], 16);
			addAnimation("silent", [5], 8);
			play("normal");
			
			//Selection rectangle
			_rect = new Rectangle(0, 0, width, _piece_height);
			//How many pieces the image will be divide into based on the image height
			_num_of_pieces = height / _piece_height;
			//alpha = 0.5;

			//With copyPixels you are basically setting
			//The TargetBitmapData is what you are going to draw on
			//SourceBitmapData is what you are drawing from - your pallette
			//Next you have to specify your selection rectangle
			//Finallaly setup the location to paste to on the TargetBitmapData
			
			//TargetBitmapData.copyPixels(SourceBitmapData, SelectionRectange, PastLocation ,null,null,true );
			
			

		}
		
		override public function update():void
		{
			super.update();
			
			//Count down the shimmer
			if (shimmer > 0)
			{
				shimmer -= FlxG.elapsed * 20;
				//alpha += FlxG.elapsed;
			}
		}
		
		override public function render():void
		{
			if(!visible)
				return;
			if (shimmer > 0)
			{
			    getScreenXY(_p);
				//Reset the selection rectangle's starting y coordinate
				_rect.y = 0;
				//Loop through the sprite's main bitmap data based on the number of pieces
				//and create a fake little shimmer by moving sections of image around
				for (var i:int = 0; i < _num_of_pieces; i++)
				{
					_rect.y = i * +_piece_height;
					//Copy a sliver (defined by _piece_height) of the image to the main buffer
					FlxG.buffer.copyPixels(_framePixels, _rect, new Point(_p.x + (Math.random() * shimmer) + (Math.random() * -shimmer),_p.y + (i * _piece_height) ), null, null, true );
				}	
			}
			else
			{
				super.render();
			}
			

		}		
		
		
		
	}
	
}