package org.flixel
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * This is a text display class which uses bitmap fonts.
	 */
	public class FlxBitmapText extends FlxCore
	{
		[Embed(source = "../../data/BitmapFont2.png")] private var imgDefaultFont:Class;
		/**
		 * The bitmap onto which the font is loaded
		 */
		protected var _fontPixels:BitmapData;
		/**
		 * The bitmap onto which the text is rendered
		 */
		protected var _pixels:BitmapData;
		/**
		 * The coordinates to which several things are copied
		 */
		protected var _p:Point;
		/**
		 * The height of the font in pixels
		 */
		protected var _fontHeight:uint;
		/**
		 * The bounding boxes of each character
		 */
		protected var _rects:Array;
		/**
		 * The bounding box of the internal bitmap
		 */
		protected var _rect:Rectangle;
		/**
		 * The text to render
		 */
		protected var _text:String;
		/**
		 * The amount of space between characters
		 */
		protected var _horizontalPadding:uint;
		/**
		 * The amount of space between lines
		 */
		protected var _verticalPadding:uint;
		/**
		 * The text alignment
		 */
		protected var _alignment:String;
		
		
		/**
		 * Creates a new <code>FlxBitmapText</code> object.
		 * 
		 * @param	X					The X position of the text
		 * @param	Y					The Y position of the text
		 * @param	Text				The default text to display
		 * @param	Alignment			"Left", "Center", or "Right"
		 * @param	Image				The image to use for the font
		 * @param	FontHeight			The height of the font in pixels
		 * @param	HorizontalPadding	Padding between characters
		 * @param	VerticalPadding		Padding between lines
		 */
		public function FlxBitmapText(X:int, Y:int, Text:String=" ", Alignment:String="left", Image:Class=null, FontHeight:uint=9, HorizontalPadding:uint=1, VerticalPadding:uint=5)
		{
			if (Image == null) // No font specified
				Image = imgDefaultFont; // Use the default
			_text = Text;
			_alignment = Alignment.toLowerCase();
			super();
			fixed = true;
			x = X;
			y = Y;
			loadFont(Image, FontHeight, HorizontalPadding, VerticalPadding); // Set the font
		}
		
		/**
		 * Sets the font face to use.
		 * 
		 * @param	Image				The font image to use
		 * @param	FontHeight			The height of the font
		 * @param	HorizontalPadding	Padding between characters
		 * @param	VerticalPadding		Padding between lines
		 */
		public function loadFont(Image:Class, FontHeight:uint, HorizontalPadding:uint=1, VerticalPadding:uint=5):void
		{
			_fontPixels = FlxG.addBitmap(Image);
			_fontHeight = FontHeight;
			_verticalPadding = VerticalPadding;
			_horizontalPadding = HorizontalPadding;
			_rects = new Array(); // Clear the rectangles array
			var _delimiter:uint = _fontPixels.getPixel(0, 0); // The pixel which marks the end of a character
			var yOffset:uint = 1; // Skip the first line since it just marks the delimiters
			var xOffset:uint = 0;
			var charCode:uint = 28; // A few ASCII codes before space
			for (var y:uint = 0; y < Math.floor(_fontPixels.height / _fontHeight); y++)
			{ // Each line in the font bitmap
				for (var x:uint = 0; x < _fontPixels.width; x++)
				{ // Each pixel in on the X axis
					if (_fontPixels.getPixel(x, yOffset - 1) == _delimiter)
					{ // Is this the end of a character?
						_rects[charCode] = new Rectangle(xOffset, yOffset, x - xOffset, _fontHeight); // The bounding box of the character
						charCode++;
						xOffset = x + 1; // Set the offset to the start of the next character
					}
				}
				yOffset += _fontHeight + 1;
				xOffset = 0;
			}
			//if (!_rects[97])
			//{ // There are no lower case letters
			///	_rects[97] = _rects[65]; // Fill the array in case a few characters aren't present
			//	_rects = _rects.concat(_rects.slice(66, 90)); // Copy the upper case letters in the lower case ones' place
			//}
			calcFrame(); // Update the bitmap
		}
		
		/**
		 * Updates the internal bitmap.
		 */
		public function calcFrame():void
		{
			width = 0;
			height = 0;
			var isKey:Boolean = false;
			var i:uint;
			var c:uint;
			var _lines:Array = _text.split("\n"); // An array of each line to render
			var _lineWidths:Array = new Array(); // An array of the widths of each line
			// We need to get the size of the bitmap, so we'll examine the text character-by-character
			for (i = 0; i < _lines.length; i++)
			{ // Loop through each line
				_lineWidths[i] = 0;
				for (c = 0; c < _lines[i].length; c++)
				{ // Each character in the line
					if (_lines[i].charAt(c) == "\t")
					{ // A tab marks the beginning of the key
						isKey = true;
						_lineWidths[i] += _rects[29].width;
					}
					if (_rects[_lines[i].charCodeAt(c)])
					{ // Does the character exist in the font?
						if ((_lines[i].charAt(c) == " ") && isKey)
						{ // Space marks the end of the key
							isKey = false;
							_lineWidths[i] += _rects[31].width;
						}
						else
							_lineWidths[i] += _rects[_lines[i].charCodeAt(c)].width + _horizontalPadding; // Add its width to the line width
					}
				}
				if (_lineWidths[i] > width) // Find out which line is the widest
					width = _lineWidths[i]; // Use that line as the bitmap's width
				height += _fontHeight + _verticalPadding; // Set the height to the font height times the number of lines
			}
			if (width == 0) // If there's nothing to render
				width = 1; // Just render a 1px wide bitmap
			_pixels = new BitmapData(width, height, true, 0x00000000); // Create a transparent bitmap
			var xOffset:uint;
			var yOffset:uint = 0;
			// Now we can start drawing on the bitmap
			for (i = 0; i < _lines.length; i++)
			{ // Loop through each line
				switch(_alignment)
				{
					case 'left':
						xOffset = 0;
					break;
					case 'center':
						xOffset = (width - _lineWidths[i]) / 2;
					break;
					case 'right':
						xOffset = width - _lineWidths[i];
					break;
				}
				for (c = 0; c < _lines[i].length; c++)
				{ // Each character in the line
					if ((_lines[i].charAt(c) == " ") && isKey)
					{ // The key graphic should no longer be displayed
						isKey = false;
						_p = new Point(xOffset - 1, yOffset);
						_pixels.copyPixels(_fontPixels, _rects[31], _p, null, null, true); // Draw the right part of the key
						xOffset += _rects[31].width;
					}
					if (_rects[_lines[i].charCodeAt(c)])
					{ // Make sure the character is in the font
						if (isKey)
						{ // Is this letter on a key?
							_p = new Point(xOffset, yOffset);
							_rect = _rects[30];
							_rect.width = _rects[_lines[i].charCodeAt(c)].width + _horizontalPadding; // Only draw as much as is needed
							_pixels.copyPixels(_fontPixels, _rect, _p, null, null, true); // Draw the key background
						}
						_p = new Point(xOffset, yOffset);
						_pixels.copyPixels(_fontPixels, _rects[_lines[i].charCodeAt(c)], _p, null, null, true); // Copy it to the bitmap
						xOffset += _rects[_lines[i].charCodeAt(c)].width + _horizontalPadding; // Add the width of the character
					}
					if (_lines[i].charAt(c) == "\t")
					{ // If the key is a tab...
						isKey = true; // ...set the next word to be on a key image
						_p = new Point(xOffset, yOffset);
						_pixels.copyPixels(_fontPixels, _rects[29], _p, null, null, true); // Draw the left part of the key
						xOffset += _rects[29].width;
					}
				}
				yOffset += _fontHeight + _verticalPadding;
			}
			switch(_alignment)
			{ // Adjust the render point based on alignment
				case 'center':
					x -= Math.floor(width / 2);
				break;
				case 'right':
					x -= width;
				break;
			}
			_rect = new Rectangle(0, 0, width, height); // Used when rendering
		}
		
		/**
		 * Draws the text to the screen.
		 */
		override public function render():void
		{
			super.render();
			getScreenXY(_p);
			FlxG.buffer.copyPixels(_pixels,_rect,_p,null,null,true);
		}
		
		/**
		 * Changes the text being displayed.
		 * 
		 * @param	Text	The new string you want to display
		 */
		public function set text(Text:String):void
		{
			_text = Text;
			calcFrame(); // Update the bitmap
		}
		
		/**
		 * Getter to retrieve the text being displayed.
		 * 
		 * @return	The text string being displayed.
		 */
		public function get text():String
		{
			return _text;
		}
		
		/**
		 * Sets the alignment of the text being displayed
		 * 
		 * @param	A string indicating the desired alignment - acceptable values are "left", "right" and "center"
		 */
		public function set alignment(Alignment:String):void
		{
			_alignment = Alignment.toLowerCase();
			calcFrame(); // Update the bitmap
		}
		
		/**
		 * Gets the alignment of the text being displayed
		 * 
		 * @return	A string indicating the current alignment.
		 */
		public function get alignment():String
		{
			return _alignment;
		}
	}
}