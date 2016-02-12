package org.flixel.data
{
	import com.KungFu.BFont;
	import com.KungFu.Master2;
	import org.flixel.*;

	/**
	 * This is the default flixel pause screen.
	 * It can be overridden with your own <code>FlxLayer</code> object.
	 */
	public class FlxPause extends FlxLayer
	{

		[Embed(source = "../../../data/BitmapFont2.png")] private var Img_Font:Class;
		[Embed(source = "../../../data/BitmapFont3.png")] private var Img_Font2:Class;
		[Embed(source = "../../../data/Sounds/success.mp3")] private var SndSuccess:Class;
		public var line1:BFont;
		public var line2:BFont;
		private var _square:FlxSprite;
		private var _master:Master2;
		public var timer:Number = 2;
		private var _state:int = 0;
		public var overlay:FlxSprite;

		/**
		 * Constructor.
		 */
		public function FlxPause()
		{
			super();
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			var w:uint = FlxG.width-w;
			var h:uint = 180;
			x = 0;
			y = 30;
			
			_square = new FlxSprite()
			_square.createGraphic(w, h, 0xCC000000, true);		
			_square.scrollFactor.x = 0; _square.scrollFactor.y = 0;
			add(_square);
			_master = new Master2(68, 5);
			_master.scrollFactor.x = 0; _master.scrollFactor.y = 0;
			_master.alpha = 0.5;
			_master.play("normal2");
			add(_master);
			
			line1 = new BFont(160, 80, 'PAUSE FU!\n', Img_Font, 9, 12, 33, 0, 0, "center")
			line1.scrollFactor.x = 0; line1.scrollFactor.y = 0;
			line1.alpha = 0.1;
			add(line1);
			
			line2 = new BFont(200, 165, "Press P or Esc to continue", Img_Font2, 9, 12, 33, 0, 0, "center")
			line2.scrollFactor.x = 0; line2.scrollFactor.y = 0;
			line2.alpha = 0.1;
			add(line2);
			
			
			overlay = new FlxSprite()
			overlay.createGraphic(w, h, 0xFF000000, true);
			overlay.scrollFactor.x = 0; overlay.scrollFactor.y = 0;
			add(overlay);
			overlay.alpha = 0;
			
		}
		
		override public function update():void
		{
			if (_master.shimmer > 0)
			{
				_master.shimmer -= FlxG.elapsed * 100;
				//alpha += FlxG.elapsed;
			}			
			
			
			if ( timer > 0)
			{
				timer -= FlxG.elapsed * 8;
				line1.alpha += FlxG.elapsed * 8
				line2.alpha += FlxG.elapsed * 8
			}			
			
			if (FlxG.keys.justPressed("X") && timer <= 0)
			{
				_state = 1;
			}
			
			if (_state == 1)
			{
				_master.shimmer += FlxG.elapsed * 250;
				_master.alpha -= FlxG.elapsed * 2;
				line1.alpha -= FlxG.elapsed * 5;
				line2.alpha -= FlxG.elapsed * 5;
				
				if (line2.alpha <= 0)
				{
					_square.scale.y -= FlxG.elapsed * 5;
					_square.alpha -= FlxG.elapsed * 3;
					if (_square.scale.y <= 0.05)
					{
						_state = 3;
					}
					
					
				}
				
			}
			
			
			if (_state == 3)
			{
				FlxG.pause = false;
			}
			
			
			super.update();
		}
		
		override public function reset(X:Number,Y:Number):void
		{
			_master.shimmer = 40;
			timer = 2;
			line1.alpha = 0.1;
			line2.alpha = 0.1;
			_master.alpha = 0.5;
			_square.scale.y = 1;
			_square.alpha = 1;
			_state = 0;
			FlxG.play(SndSuccess);
		}
		
	}
}