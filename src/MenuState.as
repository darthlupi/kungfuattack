package com.KungFu 
{
	import org.flixel.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;		

	public class MenuState extends FlxState
	{
		
		
		//Fonts
		[Embed(source = "../../data/BitmapFont2.png")] private var ImgBitmapFont2:Class;
		
		//Sprites
		[Embed(source = "../../data/Player_Riding.png")] private var ImgRiding:Class;
		[Embed(source = "../../data/Draffut.png")] private var ImgDraffut:Class;
		[Embed(source = "../../data/TitleFG.png")] private var ImgFG:Class;
		[Embed(source = "../../data/TitleBG.png")] private var ImgBG:Class;	
		[Embed(source = "../../data/TitleBG2.png")] private var ImgBG2:Class;				
		[Embed(source = "../../data/TitleTower.png")] private var ImgTower:Class;
		[Embed(source = "../../data/TitleMouth.png")] private var ImgMouth:Class;
		[Embed(source = "../../data/TitleAttack.png")] private var ImgAttack:Class;		
		
		//Sounds
		[Embed(source = "../../data/Sounds/Intro theme.mp3")] private var SndTechno:Class;
		[Embed(source = "../../data/Sounds/dissapate.mp3")] private var SndAttack:Class;
		[Embed(source = "../../data/Sounds/enemy_swing.mp3")] private var SndSwing:Class;
		[Embed(source = "../../data/Sounds/highya.mp3")] private var SndJump:Class;
		[Embed(source = "../../data/Sounds/success.mp3")] private var SndSuccess:Class;
		//Buttons
		[Embed(source = "../../data/StartButton.png")] private var ImgButton:Class;
		[Embed(source = "../../data/StartButton2.png")] private var ImgButton2:Class;
		[Embed(source = "../../data/ContinueButton.png")] private var ImgContinue:Class;
		[Embed(source = "../../data/ContinueButton2.png")] private var ImgContinue2:Class;		
		
		[Embed(source = "../../data/SponsorBig.png")] private var ImgSponsor:Class;	
		[Embed(source = "../../data/SponsorBig2.png")] private var ImgSponsor2:Class;	
		
		[Embed(source = "../../data/NoButton.png")] private var ImgNo:Class;
		[Embed(source = "../../data/NoButton2.png")] private var ImgNo2:Class;
		[Embed(source = "../../data/YesButton.png")] private var ImgYes:Class;
		[Embed(source = "../../data/YesButton2.png")] private var ImgYes2:Class;			
		
		private var _draffut:FlxSprite;
		private var _mouth:FlxSprite;
		private var _attack:FlxSprite;
		private var _title_tower:FlxSprite;
		private var _player:FlxSprite;
		private var _fg1:FlxSprite;
		private var _fg2:FlxSprite;
		
		private var _bg1:FlxSprite;
		private var _bg2:FlxSprite;	
		
		private var _bg3:FlxSprite;
		private var _bg4:FlxSprite;			
		
		public static var layer0:FlxLayer;		
		public static var layer1:FlxLayer;
		public static var layer2:FlxLayer;		
		public static var layer3:FlxLayer;
		public static var layerHUD:FlxLayer;
		public static var blur_layer:MotionEffectLayer;
				
		private var _line1:BFont;
		private var _line2:BFont;
		private var _line3:BFont;
		private var _line4:BFont;
		private var _timer:Number = 1.6;
		
		private var _title_title:TitleTitle;
		
		
		private var _state:int = 0;
		
		private var _start_button:FlxButton;
		private var _sb1:FlxSprite;
		private var _sb2:FlxSprite;	
		private var _start_game:int = 0;
		
		
		private var _button_continue:FlxButton;
		private var _button_continue_sprite1:FlxSprite;
		private var _button_continue_sprite2:FlxSprite;		
		
		private var _button_yes:FlxButton;
		private var _button_yes_sprite1:FlxSprite;
		private var _button_yes_sprite2:FlxSprite;	
		
		private var _button_no:FlxButton;
		private var _button_no_sprite1:FlxSprite;
		private var _button_no_sprite2:FlxSprite;
		
		private var _button_sponsor:FlxButton;
		private var _button_sponsor_sprite1:FlxSprite;
		private var _button_sponsor_sprite2:FlxSprite;		
		
		private var _yesno_text:BFont;
		
		
		public function MenuState() 
		{
			
			super();
			
			
			
			layer0 = new FlxLayer();
			layer1 = new FlxLayer();
			layer2 = new FlxLayer();
			layer3 = new FlxLayer();
			layerHUD = new FlxLayer();
			blur_layer = new MotionEffectLayer();
			
			//Load sprites
			
			
			//FG
			_fg1 = new FlxSprite(0, 193);
			_fg1.loadGraphic(ImgFG, true, true, 320, 64);
			layer3.add(_fg1);
			_fg1.velocity.x = 180;
			
			_fg2 = new FlxSprite(-319, 193);
			_fg2.loadGraphic(ImgFG, true, true, 320, 64);
			layer3.add(_fg2);	
			_fg2.velocity.x = 180;
			
			_draffut = new FlxSprite(160, 162);
			_draffut.loadGraphic(ImgDraffut, true, true, 64, 64);
			_draffut.addAnimation("normal", [0, 1, 2, 3, 4], 12);
			_draffut.addAnimation("flying", [2], 12);			
			_draffut.facing = 0;
			_draffut.play("normal");
			layer3.add(_draffut);
			
			_player = new FlxSprite(156, 165);
			_player.loadGraphic(ImgRiding, true, true, 64, 64);
			_player.addAnimation("normal", [0, 1, 2, 3, 4], 12);
			_player.addAnimation("standing", [5, 6], 12);
			_player.addAnimation("flying", [7,8], 12);			
			_player.facing = 0;
			_player.play("normal");
			layer3.add(_player);			
			
			//BG
			
			_bg4 = new FlxSprite(0, 0);
			_bg4.loadGraphic(ImgBG2, true, true, 320, 240);
			layer0.add(_bg4);
			_bg4.velocity.x = 70;
			
			_bg3 = new FlxSprite(-319, 0);
			_bg3.loadGraphic(ImgBG2, true, true, 320, 240);
			layer0.add(_bg3);	
			_bg3.velocity.x = 70;				
			
			_bg1 = new FlxSprite(0, 0);
			_bg1.loadGraphic(ImgBG, true, true, 320, 240);
			layer0.add(_bg1);
			_bg1.velocity.x = 100;
			
			_bg2 = new FlxSprite(-319, 0);
			_bg2.loadGraphic(ImgBG, true, true, 320, 240);
			layer0.add(_bg2);	
			_bg2.velocity.x = 100;	
			
			_mouth = new FlxSprite(320, 0);
			_mouth.loadGraphic(ImgMouth, true, true, 68, 240);
			layerHUD.add(_mouth);	
			_mouth.visible = false;				
			
			
			//The word attack
			_attack = new FlxSprite(-296, 34);
			_attack.loadGraphic(ImgAttack, true, true, 96, 32);
			_attack.velocity.x = 314;
			blur_layer.add(_attack);	
					
	
			
			//The title tower
			_title_tower = new FlxSprite(110, 23);
			_title_tower.loadGraphic(ImgTower, true, true, 100, 210);
			_title_tower.addAnimation("normal", [0, 1, 2, 3, 4], 3);
			_title_tower.facing = 1;
			_title_tower.play("normal");
			layer1.add(_title_tower);
			//Title text
			_title_title = new TitleTitle(0, 0)
			layerHUD.add(_title_title);
			FlxG.play(SndSwing);			
			
			//Buttons
			//Sprites for the button
			_sb1 = new FlxSprite(0, 0);
			_sb1.loadGraphic(ImgButton, true, true, 96, 27);
			_sb2 = new FlxSprite(0, 0);
			_sb2.loadGraphic(ImgButton2, true, true, 96, 27);
			//The button that contains the sprites
			if (Globals.global_save_so.data.game_saved )
				_start_button = new FlxButton(202, 100, resetOrNot );
			else
				_start_button = new FlxButton(202, 70, startGame);
			_start_button.loadGraphic( _sb1, _sb2);
			blur_layer.add(_start_button);
			
			//Sprites for the continue button
			if (Globals.global_save_so.data.game_saved )
			{
				_button_continue_sprite1 = new FlxSprite(0, 0);
				_button_continue_sprite1.loadGraphic(ImgContinue, true, true, 96, 27);
				_button_continue_sprite2 = new FlxSprite(0, 0);
				_button_continue_sprite2.loadGraphic(ImgContinue2, true, true, 96, 27);
				_button_continue = new FlxButton( 202, 70 , fadeMenu ).loadGraphic( _button_continue_sprite1, _button_continue_sprite2 )
				blur_layer.add( _button_continue );	
			}

			_button_yes_sprite1 = new FlxSprite(0, 0);
			_button_yes_sprite1.loadGraphic(ImgYes, true, true, 40, 27);
			_button_yes_sprite2 = new FlxSprite(0, 0);
			_button_yes_sprite2.loadGraphic(ImgYes2, true, true, 40, 27);
			_button_yes = new FlxButton( 110, 180 , resetStats ).loadGraphic( _button_yes_sprite1, _button_yes_sprite2 )
			blur_layer.add( _button_yes );	
			_button_yes.visible = false;
			
			_button_no_sprite1 = new FlxSprite(0, 0);
			_button_no_sprite1.loadGraphic(ImgNo, true, true, 40, 27);
			_button_no_sprite2 = new FlxSprite(0, 0);
			_button_no_sprite2.loadGraphic(ImgNo2, true, true, 40, 27);
			_button_no = new FlxButton( 180, 180 , noMeansNo ).loadGraphic( _button_no_sprite1, _button_no_sprite2 )
			blur_layer.add( _button_no);	
			_button_no.visible = false;
			
			//Sponsor
			_button_sponsor_sprite1 = new FlxSprite(0, 0);
			_button_sponsor_sprite1.loadGraphic(ImgSponsor, true, true, 96, 27 );
			_button_sponsor_sprite2 = new FlxSprite(0, 0);
			_button_sponsor_sprite2.loadGraphic(ImgSponsor2, true, true, 96, 27 );
			_button_sponsor = new FlxButton( 202, 130, gotoSponsor ).loadGraphic( _button_sponsor_sprite1, _button_sponsor_sprite2 )
			blur_layer.add( _button_sponsor);	
			_button_sponsor.visible = true;			

			_yesno_text = new BFont(160, 70, "Click yes to erase\n all saved data!\n\n\n\nAre you sure\n you want to?", ImgBitmapFont2,  9, 12, 33, 0, 0,"center")
			blur_layer.add(_yesno_text);	
			_yesno_text.visible = false;

			FlxG.flash(0xff000000, 1);


			//_line1 = new BFont(160, 200, "Hello there.\nHow\nI hope", ImgBitmapFont, 9, 12, 33, 0, 0,"center")
			//layerHUD.add(_line1);
			//_line1.update_text("Your SUCK-FU is strong!\n\nPress X to continue");
			//_line1.alpha = 0;
			
			this.add(layer0);  //Since this is the first layer it will be in the background
			this.add(layer1);  //Since this is the second layer it goes in the middle
			this.add(layer2);  //The is layer which is the foreground effects
			this.add(layer3);  //The is the final layer which is the VERY foreground
			this.add(layerHUD);  //The is the final layer which is the VERY foreground
			this.add(blur_layer);  //The is the final layer which is the VERY foreground
			
			
			//Play music
			FlxG.playMusic(SndTechno, 1);
			
			//Enable the mouse
			FlxG.showCursor();
			
		}
		
		private function gotoSponsor():void
		{
			navigateToURL(new URLRequest("http://lupigames.com"));
		}
		
		
		//Bring up the text and option to reset game
		private function resetOrNot():void
		{
			_button_yes.visible = true;
			_button_no.visible = true;
			_button_continue.visible = false;
			_button_sponsor.visible = false;
			_start_button.visible = false;
			_yesno_text.visible = true;
		}
		//Reset stats after selecting yes
		private function resetStats():void
		{
			
			Globals.setStartStats(true);
			_button_yes.visible = false;
			_button_no.visible = false;
			_yesno_text.visible = false;
			startGame();
		}
		//Say no to new games!
		private function noMeansNo():void
		{
			_button_continue.visible = true;
			_button_sponsor.visible = true;
			_start_button.visible = true;
			_button_yes.visible = false;
			_button_no.visible = false;
			_yesno_text.visible = false;
		}
		
		override public function update():void
		{
			
			if ( _timer > 0)
			{
				_timer -= FlxG.elapsed;
				//_line1.alpha += FlxG.elapsed * 0.5
			}			

			
			if (_state < 2)
			{
				if (_fg1.x >= 318)
					_fg1.x = _fg2.x -317;
				if (_fg2.x >= 318)
					_fg2.x = _fg1.x -317;	
				
				if (_bg1.x >= 318)
					_bg1.x = _bg2.x -317;
				if (_bg2.x >= 318)
					_bg2.x = _bg1.x -317;					
			
				if (_bg3.x >= 318)
					_bg3.x = _bg4.x -317;
				if (_bg4.x >= 318)
					_bg4.x = _bg3.x -317;					
			}
			
			
			
			if (_state == 0 )
			{
				
				if (_timer <= 0 && _attack.velocity.x != 0 )
				{
					_attack.velocity.x = 0;
					FlxG.play(SndAttack);
				}
				
				//Trigger intro pressed or selected
				if ( (( FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") ) || _start_game == 1 )&& _timer <= 0 )
				{
					FlxG.play(SndSuccess);
					//Make player run off screen
					_player.velocity.x = -200;
					_draffut.velocity.x = -200;
					_timer = 9.5;
					//Get rid of the attack text
					_attack.velocity.x = 300;
					_start_button.visible = false;
					_button_sponsor.visible = false;
					if (Globals.global_save_so.data.game_saved )
						_button_continue.visible = false;
				}
				//Fizzle out the main text
				if (_timer > 8)
				{
					_title_title.shimmer += FlxG.elapsed * 40;
					_title_title.alpha -= FlxG.elapsed * 2;
				}
				
				//Make the player run back on screen
				if (_timer > 7 && _timer < 8)
				{	
				
							_player.scale.x = _player.scale.y = 0.2;
							_draffut.scale.x = _draffut.scale.y = 0.2;
							_player.velocity.x = 100;
							_draffut.velocity.x = 100;
							_player.x += 4;
							_player.y += 10;
							_draffut.y +=12;	
							_player.facing = 1;
							_draffut.facing = 1;
					
							//Destroy the title and attack text
							_title_title.kill();
							_attack.kill();
							//Switch state and set timer
							_state = 1;
							_timer = 1.7;

				}
			}
			//Make the mini player and draffut jump
			if (_state == 1)
			{
				
				 
				if (_timer <= 0)
				{
					_player.velocity.y = -100;
					_draffut.velocity.y = -100;
					_timer = 8.5;
				}
				
				if (_timer > 7 && _timer < 8)
				{
					_state = 2
					
					
				}
				
			}
			
			//Set up the zoomed in jump scene
			if (_state == 2)
			{
				_title_tower.kill();
				_bg1.kill();
				_bg2.kill();
				_bg3.kill();
				_bg4.kill();
				_fg1.kill();
				_fg2.kill();
				
				bgColor = 0xff4D538D;
				_player.velocity.x = 100;
				_draffut.velocity.x = 100;		
				_player.velocity.y = -80;
				_draffut.velocity.y = -80;					
				_player.x = 0;
				_player.y = 220;
				_draffut.y = 224;	
				_draffut.x = 0;	
				_player.play("standing");
				_draffut.play("flying");
				_player.scale.x = _player.scale.y = 1;
				_draffut.scale.x = _draffut.scale.y = 1;
				
				var tmp:FlxSprite;
				for ( var i:int = 0; i < 50; i++)
				{
					tmp = new FlxSprite(Math.random() * 820, Math.random() * 240);
					tmp.createGraphic(3 + Math.random() * 10, 2, 0xFFFFFFFF);
					tmp.alpha = 0.2;
					blur_layer.add(tmp);
					tmp.velocity.x = -280;
				}
				
				
				_mouth.velocity.x = -65;
				_mouth.visible = true;
				
				_timer = 1;
				_state = 3;
				
				
			}
			//Finish off with a flying kick into the tower!
			if ( _state == 3)
			{
				if (_timer <= 0)
				{
					_player.play("flying");
					_player.velocity.x = 300;
					FlxG.play(SndJump);
					_player.acceleration.y = 50;
					_mouth.velocity.x = 0;
					_draffut.acceleration.y = 250;
					_timer = 9;
				}
				
				if (_timer > 7 && _timer < 8)
				{
					_state = 4;
				}
				
			}
			
			if (_state == 4)
			{
				FlxG.fade(0xFF000000, 0.5,nextState);
			}
			
			
			super.update();
			
		}
		
		private function nextState():void
		{
			FlxG.switchState(PlayState);
		}
		
		private function gotoSelect():void
		{
			FlxG.switchState(SelectState);
		}		
		
		public function fadeMenu():void
		{
			FlxG.fade(0xFF000000, 0.5,gotoMenuState);
		}
		
		//If you already have a save game
		private function gotoMenuState():void
		{
			FlxG.switchState(SelectState);
		}
		
		private function startGame():void
		{
			_start_game = 1;
		}

		
		
	}
	
}