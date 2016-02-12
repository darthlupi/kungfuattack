package com.KungFu 
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*

	public class BFont extends FlxSprite
	{
	
		private var _image_count:int; //Store the count of total images in Font File
		private var _ani_array:Array = []; //The array for the animation of the text
		private var _width:int;
		private var _height:int;
		private var _state:FlxState;
		private var _layer:FlxLayer;
		private var _centered:int;
		private var _rect:Rectangle;
		
		private var _twidth:int;
		private var _theight:int;
		
		private var _text:String;
		private var _char_offset:int;
		

		public function BFont(X:int, Y:int, Text:String, TheFontImg:Class, Width:int, Height:int, CharOffset:int = 0, Hsep:int = 0, Vsep:int = 0,Centered:int = 0)
		{
		    super(X, Y, null);
			_twidth = Width;
			_theight = Height;
			_layer = Layer;
			_centered = Centered;
			_text = Text;
			_char_offset = CharOffset;
			
			_rect = new Rectangle(0, 0, _twidth, _theight);

			
			loadGraphic(TheFontImg, true, true)
			
			trace(width + "    " + height);
			trace(_text);
			trace(_text.charCodeAt(5) - CharOffset);
			
			//Get the image count based off the width and height of sprite's bitmap and frame dimensions
			_image_count = ( pixels.width / Width ) * ( height / Height );

			//Populate an array based off of the total image count of the bitmap sprite
			for (var ani:int = 0; ani < _image_count; ani ++)
				_ani_array.push(ani);

		}
		
		override public function render():void
		{
		
			//surface_sprite.offset.x = surface_sprite.width / 2;
			//Now draw on the display sprite with the sprites that represent the characters
			//of the string you passed
			for (var f:int = 0; f < _text.length; f ++)
			{
				if(!visible)
					return;				
				getScreenXY(_p);
				//Draw the appropiate frame for the ASCII character code
				//_brush_sprite.specificFrame(_text.charCodeAt(f) - _char_offset);					
				_rect.x = _rect.y = 0;
				//Calculate the x,y coordinates of the copy rectangle
				_rect.x = ( _text.charCodeAt(f) - _char_offset ) * _twidth;
				while (_rect.x > width)
				{
					_rect.y += _theight;
					_rect.x -= width;
				}
				FlxG.buffer.copyPixels(_pixels, _rect, new Point(_p.x + f * _twidth, _p.y) , null, null, true );
			}

			
		}

	}
}