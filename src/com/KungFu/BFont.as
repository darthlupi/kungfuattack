package com.KungFu 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*

	public class BFont extends FlxSprite
	{
		private var _width:int;
		private var _height:int;

		private var _alignment:String;
		private var _rect:Rectangle;
		
		private var _original_bitmap:BitmapData;
		
		private var _twidth:int;
		private var _theight:int;
		private var _orig_width:int;
		private var _orig_height:int;		
		
		private var _char_offset:int;

		public function BFont(X:int, Y:int, Text:String, TheFontImg:Class, Width:int, Height:int,CharOffset:int = 0, Hsep:int = 0, Vsep:int = 0,Alignment:String = "left")
		{
		    super(X, Y, null);
			_twidth = Width;
			_theight = Height;
			_alignment = Alignment;
			_char_offset = CharOffset;
			_rect = new Rectangle(0, 0, _twidth, _theight);

			loadGraphic(TheFontImg, false, false)
			
			//Create bitmap data to store original font sheet
			_original_bitmap = pixels;
			//Store the original sizes to allow sorting through the original font sheet
			_orig_width = width;
			_orig_height = height;
			
			update_text(Text);
			

		}
		
		
		
		
		public function update_text(Text:String):void
		{
		
			var height_plus:int = _theight;
			var new_width:int = 0;
			var cur_width:int = 0;
			
			var width_array:Array = new Array;
			
			//Calculate width and height of image
			//based off the number of newline characters and the
			//line with the greatest width
			for (var nl:int = 0; nl < Text.length; nl ++)
			{
				//Add one to the width of the line for every new character
				cur_width += 1;
				if (Text.charCodeAt(nl) - _char_offset == -23)
				{
					//Add to the height of the image since newline makes it taller
					height_plus += _theight;	
					//Subtract 1 from the width to compensate for the newline character
					cur_width -= 1;
					//Add the current width to the width_array.
					//This will be retrieved when drawing the array below.
					//Used to determine where to start drawing for alignment.
					width_array.push( cur_width );
					//Every time there is a new line check it's size
					//to see if it is the longest.  The longest is new width of the sprite.
					if (cur_width > new_width)
						new_width = cur_width;
					//Reset the cur_width now that we are going to a new line
					cur_width = 0;
				}
			}
			//Check to see if the LAST line ( or first if a single line ) is the longest.
			width_array.push( cur_width );
			if (cur_width > new_width)
				new_width = cur_width;
			

			//Set the sprite's bitmapdatas to a new bitmapdata of the proper size
			pixels = new BitmapData(_twidth * new_width, height_plus, true, 0x00000000);

			//Now draw on the display sprite with the sprites that represent the characters
			//of the string you passed
			
			var yposition:int = 0;
			var xposition:int = 0;
			var width_count:int = 0;
			
			//Center the text
			if (_alignment == "center" && width_array[width_count] != width )
				xposition += ( width - (_twidth * width_array[0] ) ) / 2;
			
			
			for (var f:int = 0; f < Text.length; f ++)
			{
				//Position the selection rectangle properly to select the proper
				//piece of the bitmap font image
				_rect.x = _rect.y = 0;
				
				//Calculate the x,y coordinates of the copy rectangle
				_rect.x = ( Text.charCodeAt(f) - _char_offset ) * _twidth;
				
				if (Text.charCodeAt(f) - _char_offset == -23)
				{
					//If newline is detected then move the y coord of where to draw on
					//the bitmapdata down one font height
					yposition += _theight;
					//Reset the x location of drawing on the bitmap
					xposition = 0;
					//Add 1 to the width count
					//This is used to pull back the width of the current line determined above
					//and stored in the width_array.
					//This is used for centering text.
					width_count += 1;					
					//Center the text
					if (_alignment == "center" && width_array[width_count] != width )
						xposition += ( width - (_twidth * width_array[width_count] ) ) / 2;					
				}
				else
				{
					//No newline detected.
					//If the selection rectangle is outside of bitmap for the fonts
					//move y down a font height and set the x in the right place.
					//This is how it scrolls through sprite sheets vs sprite strips
					while (_rect.x >= _orig_width)
					{
						_rect.y += _theight;
						_rect.x -= _orig_width;
					}
					//Copy the selected image from the sprite sheet to the _framePixels 
					_pixels.copyPixels(_original_bitmap, _rect, new Point(xposition, yposition) , null, null, true );
					
					//Set the X location of to draw the text
					xposition += _twidth;
				}
			}
			//Make sure all bitmaps match ie _pixels and _framePixels
			//Allows for calcFrame function to apply transforms etc
			pixels = _pixels;
			


			
			//Set origin if center
			if ( _alignment == "center" )
			{
				offset.x = width / 2;
			}
			else
			{
				offset.x = 0;
			}
			
		}
	}
}