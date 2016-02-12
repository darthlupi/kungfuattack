package org.flixel.data
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import org.flixel.FlxG;

	/**
	 * This class handles the 8-bit style preloader.
	 */
	public class FlxFactory extends MovieClip
	{
		[Embed(source = "enemy_bit.png")] private var ImgBar:Class;
		[Embed(source="player_bit0.png")] private var ImgBit0:Class;
		[Embed(source="player_bit1.png")] private var ImgBit1:Class;
		[Embed(source="player_bit2.png")] private var ImgBit2:Class;
		[Embed(source="player_bit3.png")] private var ImgBit3:Class;
		[Embed(source="player_bit4.png")] private var ImgBit4:Class;
		[Embed(source="player_bit.png")] private var ImgBit:Class;
		
		/**
		 * @private
		 */
		protected var _buffer:Sprite;
		/**
		 * @private
		 */
		protected var _bmpBar:Bitmap;
		/**
		 * @private
		 */
		protected var _bits:Array;
		
		/**
		 * This should always be the name of your main project/document class (e.g. GravityHook).
		 */
		public var className:String;
		/**
		 * Set this to your game's URL to use built-in site-locking.
		 */
		public var myURL:String;
		
		//Test variables for loading the preloader 
		private var _fake_loaded:Number = 0;
		private var _fake_total:Number = 220;
		
		private var _txt2:TextField = new TextField();
		
		/**
		 * Constructor
		 */
		public function FlxFactory()
		{
			stop();
            stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//Check if we are on debug or release mode and set _DEBUG accordingly
            try
            {
                throw new Error("Setting global debug flag...");
            }
            catch(e:Error)
            {
                var re:RegExp = /\[.*:[0-9]+\]/;
                FlxG.debug = re.test(e.getStackTrace());
            }
			
			var tmp:Bitmap;
			
			if(!FlxG.debug && (myURL != null) && (myURL.length > 0) && myURL && (root.loaderInfo.url.indexOf(myURL) < 0) && (root.loaderInfo.url.indexOf("localhost") < 0)  )
			{
				tmp = new Bitmap(new BitmapData(stage.stageWidth,stage.stageHeight,true,0xFFFFFFFF));
				addChild(tmp);
				
				var fmt:TextFormat = new TextFormat();
				fmt.color = 0x000000;
				fmt.size = 16;
				fmt.align = "center";
				fmt.bold = true;
				
				var txt:TextField = new TextField();
				txt.width = tmp.width-16;
				txt.height = tmp.height-16;
				txt.y = 8;
				txt.multiline = true;
				txt.wordWrap = true;
				txt.defaultTextFormat = fmt;
				txt.text = "Oh LORDY!  Someone copied the game.\nClick to play it where\it SHOULD be.\n\n"+myURL+"\n\nThanks, and have fun!";
				addChild(txt);
				
				txt.addEventListener(MouseEvent.CLICK,goToMyURL);
				tmp.addEventListener(MouseEvent.CLICK,goToMyURL);
				return;
			}
			

			//Setup the images and text for the preloader :)
			_buffer = new Sprite();
            _buffer.scaleX = 2;
            _buffer.scaleY = 2;
            addChild(_buffer);
			_bmpBar = new ImgBar();
			_bmpBar.x = (stage.stageWidth/_buffer.scaleX-_bmpBar.width)/2 ;
			_bmpBar.y = (stage.stageHeight/_buffer.scaleY-_bmpBar.height)/2 - 40;
			_buffer.addChild(_bmpBar);
			_bits = new Array();
			for(var i:uint = 0; i < 59; i++)
			{
				if ( i < 8 )
					tmp = new ImgBit0();
				if ( i >= 8 && i < 15)
					tmp = new ImgBit1();
				if ( i >= 15 && i < 24)
					tmp = new ImgBit2();
				if ( i >= 24 && i < 35)
					tmp = new ImgBit3();
				if ( i >= 35 && i < 50)
					tmp = new ImgBit4();
				if ( i >= 50 )
					tmp = new ImgBit();					
				tmp.visible = false;
				tmp.x = _bmpBar.x+2+i*2 + 20;
				tmp.y = _bmpBar.y + 149;
				if ( i >= 35 && i < 50)
					tmp.y -= 4
				if ( i >= 50 )
					tmp.y -= 8
				_bits.push(tmp);
				_buffer.addChild(tmp);
			}
			
			
			var fmt2:TextFormat = new TextFormat();
			fmt2.color = 0xFFFFFFF;
			fmt2.size = 10;
			fmt2.align = "center";
			fmt2.bold = true;
			
			_txt2.width = 100;
			_txt2.height = 100;
			_txt2.x = (stage.stageWidth / _buffer.scaleX - _bmpBar.width) / 2 + 62;
			_txt2.y = 165;
			_txt2.multiline = true;
			_txt2.wordWrap = true;
			_txt2.defaultTextFormat = fmt2;
			_txt2.text = "0%";
			_buffer.addChild(_txt2);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function goToMyURL(event:MouseEvent=null):void
		{
			navigateToURL(new URLRequest("http://"+myURL));
		}
		
		private function onEnterFrame(event:Event):void
        {
        	var i:int;
            graphics.clear();
			
			//Uncomment in prod
            if(framesLoaded == totalFrames)
			//Comment in prod
			//if ( _fake_loaded >= _fake_total )
            {
                removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                nextFrame();
                var mainClass:Class = Class(getDefinitionByName(className));
	            if(mainClass)
	            {
	                var app:Object = new mainClass();
	                addChild(app as DisplayObject);
	            }
	            for(i = _bits.length-1; i >= 0; i--)
					_bits.pop();
                removeChild(_buffer);
            }
            else
            {
				//Uncomment for prod
            	var limit:uint = (root.loaderInfo.bytesLoaded/root.loaderInfo.bytesTotal)*60;
				
				//Comment for prod
				//_fake_loaded += 1;
				//var limit:uint = (_fake_loaded / _fake_total) * 60;
				
				for (i = 0; (i < limit) && (i < _bits.length); i++)
				{
					_bits[i].alpha -= 0.025;
					
					if ( i == limit - 1 )
						_bits[i].alpha = 1;
				}
				for(i = 0; (i < limit) && (i < _bits.length); i++)
					_bits[i].visible = true;	
				_txt2.text = "LOADED: " + Math.round( (root.loaderInfo.bytesLoaded/root.loaderInfo.bytesTotal) * 100 ) + "%";
            }
        }
	}
}