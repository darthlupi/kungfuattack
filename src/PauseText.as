package com.KungFu 
{
	import com.KungFu.BFont;
	import com.KungFu.Master2;
	import org.flixel.*;

	/**
	 * This is the default flixel pause screen.
	 * It can be overridden with your own <code>FlxLayer</code> object.
	 */
	public class PauseText extends FlxLayer
	{

		[Embed(source = "../../data/BitmapFont4.png")] private var Img_Font:Class;
		[Embed(source = "../../data/BitmapFont3.png")] private var Img_Font2:Class;
		[Embed(source = "../../data/Sounds/success.mp3")] private var SndSuccess:Class;
		public var line1:BFont;
		public var line2:BFont;
		private var _square:FlxSprite;
		private var _master:Master2;
		public var timer:Number = 2;
		public var _state:int = 0;
		public var overlay:FlxSprite;

		/**
		 * Constructor.
		 */
		public function PauseText()
		{
			super();
			scrollFactor.x = 0;
			scrollFactor.y = 100;
			var w:uint = FlxG.width-w;
			var h:uint = 80;
			x = 0;
			y = 0;
			
			_square = new FlxSprite()
			_square.createGraphic(340, 40, 0x88000000, true);		
			_square.scrollFactor.x = 0; _square.scrollFactor.y = 0;
			_square.x = 0
			_square.y = 60
			add(_square);
			_master = new Master2(68, 0);
			_master.scrollFactor.x = 0; _master.scrollFactor.y = 0;
			_master.alpha = 0.5;
			_master.play("normal2");
			add(_master);
			
			line1 = new BFont(160, 60, "You have successfully penetrated\n the goblin's Slime Tower!\n", Img_Font, 9, 12, 33, 0, 0, "center")
			line1.scrollFactor.x = 0; line1.scrollFactor.y = 0;
			line1.alpha = 0.1;
			add(line1);
			
			line2 = new BFont(230, 165, "Press X to continue", Img_Font2, 9, 12, 33, 0, 0, "center")
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
			if (visible)
			{
			if (_master.shimmer > 0)
			{
				_master.shimmer -= FlxG.elapsed * 100;
				//alpha += FlxG.elapsed;
			}			

			//Move player back from slime pit
			if (PlayState.pause_state < 7 && PlayState.player.x > 184 )
			{
				PlayState.player.velocity.x = -400;
				PlayState._safety_master.visible = true;
				PlayState._safety_master.y = PlayState.player.y -50
				PlayState._safety_master.alpha = 1;
			}
			
			PlayState._safety_master.alpha -= FlxG.elapsed * 2;
			
			if ( timer > 0)
			{
				timer -= FlxG.elapsed * 8;
				line1.alpha += FlxG.elapsed * 8
				line2.alpha += FlxG.elapsed * 8
			}			
			
			if ( ( FlxG.keys.LEFT || FlxG.keys.RIGHT ) && PlayState.pause_state == 0 )
			{
				_state = 1;
			}
			
			if ( ( ( FlxG.keys.justPressed("C") || FlxG.keys.justPressed("K") )   ) && PlayState.pause_state == 1 )
			{
				_state = 1;
			}
			
			if ( ( ( FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") )  && FlxG.keys.DOWN  ) && PlayState.pause_state == 2 )
			{
				_state = 1;
			}	
			
			//if ( ( ( FlxG.keys.justPressed("C") || FlxG.keys.justPressed("K") )   ) && PlayState.pause_state == 3 )
			//{
			//	_state = 1;
			//}
			
			
			if ( PlayState.pause_state == 6 && PlayState.player.wall_jump == 1 )
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
				visible = false;
				PlayState.pause_state += 1;
				PlayState.pause_state_go = 0;
			}
			
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