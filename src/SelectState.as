package com.KungFu 
{
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;			
	

	public class SelectState extends FlxState
	{
		
		
		//Fonts
		[Embed(source = "../../data/BitmapFont.png")] private var ImgBitmapFont:Class;
		[Embed(source = "../../data/BitmapFont2.png")] private var ImgBitmapFont2:Class;
		//Sprites
		[Embed(source = "../../data/TitleFG.png")] private var ImgFG:Class;
		[Embed(source = "../../data/TitleBG.png")] private var ImgBG:Class;	
		[Embed(source = "../../data/TitleBG2.png")] private var ImgBG2:Class;				
		[Embed(source = "../../data/TitleTower.png")] private var ImgTower:Class;
		//Sounds
		[Embed(source = "../../data/Sounds/Intro theme.mp3")] private var SndTechno:Class;
		[Embed(source = "../../data/Sounds/dissapate.mp3")] private var SndAttack:Class;
		[Embed(source = "../../data/Sounds/enemy_swing.mp3")] private var SndSwing:Class;
		[Embed(source = "../../data/Sounds/highya.mp3")] private var SndJump:Class;
		[Embed(source = "../../data/Sounds/success.mp3")] private var SndSuccess:Class;

		//Buttons
		[Embed(source = "../../data/LevelButton1.png")] private var ImgButton1:Class;
		[Embed(source = "../../data/LevelButton2.png")] private var ImgButton2:Class;
		[Embed(source = "../../data/LevelButton3.png")] private var ImgButton3:Class;

		[Embed(source = "../../data/PlayButton2.png")] private var ImgPlay2:Class;
		[Embed(source = "../../data/PlayButton.png")] private var ImgPlay:Class;
		
		[Embed(source = "../../data/ExitButton2.png")] private var ImgExit2:Class;
		[Embed(source = "../../data/ExitButton.png")] private var ImgExit:Class;		
		
		[Embed(source = "../../data/LevelStats.png")] private var ImgStats:Class;
		
		[Embed(source = "../../data/Upgrades1.png")] private var ImgUButtons1:Class;
		[Embed(source = "../../data/Upgrades2.png")] private var ImgUButtons2:Class;
		[Embed(source = "../../data/Upgrades3.png")] private var ImgUButtons3:Class;
		[Embed(source = "../../data/Upgrades4.png")] private var ImgUButtons4:Class;
		[Embed(source = "../../data/Upgrades5.png")] private var ImgUButtons5:Class;
		[Embed(source = "../../data/Upgrades6.png")] private var ImgUButtons6:Class;
		
		[Embed(source = "../../data/Upgrades12.png")] private var ImgUButtons12:Class;
		[Embed(source = "../../data/Upgrades22.png")] private var ImgUButtons22:Class;
		[Embed(source = "../../data/Upgrades32.png")] private var ImgUButtons32:Class;
		[Embed(source = "../../data/Upgrades42.png")] private var ImgUButtons42:Class;
		[Embed(source = "../../data/Upgrades52.png")] private var ImgUButtons52:Class;
		
		[Embed(source = "../../data/SponsorSmall.png")] private var ImgSponsor:Class;	
		[Embed(source = "../../data/SponsorSmall2.png")] private var ImgSponsor2:Class;	

		private var _title_tower:FlxSprite;
		private var _fg1:FlxSprite;
		private var _fg2:FlxSprite;
		
		private var _bg1:FlxSprite;
		private var _bg2:FlxSprite;	
		
		private var _bg3:FlxSprite;
		private var _bg4:FlxSprite;	
		
		private var _stats_sprite:FlxSprite;
		
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
		private var _upgrade_text1:BFont;
		private var _timer:Number = 1.6;
		
		private var _stats_font_title:BFont;
		private var _stats_font_score:BFont;		
		
		private var _state:int = 0;
		
		private var _button_array:Array = new Array;
		private var _img_1_array:Array = new Array;
		private var _img_2_array:Array = new Array;
		
		
		private var _start_button:FlxButton;
		
		private var _points_to_spend:int;
		private var _points_spent:int;
		
		private var _sb1:FlxSprite;
		private var _sb2:FlxSprite;	
		private var _start_game:int = 0; //To start the game or not
		private var _selected_level:int = 0; //Which level is selected
		
		private var _button_font:Array = new Array;
		private var _button:Array = new Array;
		
		private var _u_button1:UpgradeButton;
		private var _u_button2:UpgradeButton;
		private var _u_button3:UpgradeButton;
		private var _u_button4:UpgradeButton;
		private var _u_button5:UpgradeButton;
		private var _u_button6:UpgradeButton;
		
		private var _u_button1_sprite:FlxSprite;
		private var _u_button2_sprite:FlxSprite;
		private var _u_button3_sprite:FlxSprite;
		private var _u_button4_sprite:FlxSprite;
		private var _u_button5_sprite:FlxSprite;
		private var _u_button6_sprite:FlxSprite;	
		private var _u_button62_sprite:FlxSprite;
		private var _u_button63_sprite:FlxSprite;
		private var _u_button64_sprite:FlxSprite;
		private var _u_button65_sprite:FlxSprite;		
		
		private var _button_play:FlxButton;
		private var _button_play_sprite1:FlxSprite;
		private var _button_play_sprite2:FlxSprite;
		
		private var _button_exit:FlxButton;
		private var _button_exit_sprite1:FlxSprite;
		private var _button_exit_sprite2:FlxSprite;		
		
		private var _pcost:Array = new Array;
		
		private var _button_sponsor:FlxButton;
		private var _button_sponsor_sprite1:FlxSprite;
		private var _button_sponsor_sprite2:FlxSprite;		
		
		public function SelectState() 
		{
			
			super();
			layer0 = new FlxLayer();
			layer1 = new FlxLayer();
			layer2 = new FlxLayer();
			layer3 = new FlxLayer();
			layerHUD = new FlxLayer();
			blur_layer = new MotionEffectLayer();
			
			//Load cost of power ups
			_pcost.push(3);
			_pcost.push(4);
			_pcost.push(8);
			_pcost.push(5);
			_pcost.push(4);
			
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
			
			
			

			//The title tower
			_title_tower = new FlxSprite(110, 23);
			_title_tower.loadGraphic(ImgTower, true, true, 100, 210);
			_title_tower.addAnimation("normal", [0, 1, 2, 3, 4], 3);
			_title_tower.facing = 1;
			_title_tower.play("normal");
			layer1.add(_title_tower);
			

			
			//Buttons
			
			//Sprites for the play button
			_button_play_sprite1 = new FlxSprite(0, 0);
			_button_play_sprite1.loadGraphic(ImgPlay, true, true, 64, 32);
			_button_play_sprite2 = new FlxSprite(0, 0);
			_button_play_sprite2.loadGraphic(ImgPlay2, true, true, 64, 32);
			_button_play = new FlxButton( 29 , 143 , reallyStartGame ).loadGraphic( _button_play_sprite1, _button_play_sprite2 )
			blur_layer.add( _button_play );

			//Sprites for the exit button
			_button_exit_sprite1 = new FlxSprite(0, 0);
			_button_exit_sprite1.loadGraphic(ImgExit, true, true, 64, 32);
			_button_exit_sprite2 = new FlxSprite(0, 0);
			_button_exit_sprite2.loadGraphic(ImgExit2, true, true, 64, 32);
			_button_exit = new FlxButton( 29 , 174 , gotoMenu ).loadGraphic( _button_exit_sprite1, _button_exit_sprite2 )
			blur_layer.add( _button_exit );		
			
			//Sponsor
			_button_sponsor_sprite1 = new FlxSprite(0, 0);
			_button_sponsor_sprite1.loadGraphic(ImgSponsor, true, true, 64, 32);
			_button_sponsor_sprite2 = new FlxSprite(0, 0);
			_button_sponsor_sprite2.loadGraphic(ImgSponsor2, true, true, 64, 32 );
			_button_sponsor = new FlxButton( 29 , 206, gotoSponsor ).loadGraphic( _button_sponsor_sprite1, _button_sponsor_sprite2 )
			blur_layer.add( _button_sponsor);	
			_button_sponsor.visible = true;				
			
			
			//Upgrade buttons
			_u_button6_sprite = new FlxSprite(0, 0);
			_u_button6_sprite.loadGraphic(ImgUButtons12, true, true, 16, 16);
			_u_button62_sprite = new FlxSprite(0, 0);
			_u_button62_sprite.loadGraphic(ImgUButtons22, true, true, 16, 16);
			_u_button63_sprite = new FlxSprite(0, 0);
			_u_button63_sprite.loadGraphic(ImgUButtons32, true, true, 16, 16);		
			_u_button64_sprite = new FlxSprite(0, 0);
			_u_button64_sprite.loadGraphic(ImgUButtons42, true, true, 16, 16);	
			_u_button65_sprite = new FlxSprite(0, 0);
			_u_button65_sprite.loadGraphic(ImgUButtons52, true, true, 16, 16);				
			
			var ubx:Number = 150;
			var uby:Number = 190;
			
			_u_button1_sprite = new FlxSprite(0, 0);
			_u_button1_sprite.loadGraphic(ImgUButtons1, true, true, 16, 16);
			_u_button1 = new UpgradeButton( ubx + 18, uby -8,calc_points,redraw,0 ).loadGraphic( _u_button1_sprite, _u_button6_sprite )
			_u_button2_sprite = new FlxSprite(0, 0);
			_u_button2_sprite.loadGraphic(ImgUButtons2, true, true, 16, 16);
			_u_button2 = new UpgradeButton( ubx + 38, uby -8,calc_points,redraw,1  ).loadGraphic( _u_button2_sprite, _u_button62_sprite )
			_u_button3_sprite = new FlxSprite(0, 0);
			_u_button3_sprite.loadGraphic(ImgUButtons3, true, true, 16, 16);
			_u_button3 = new UpgradeButton( ubx + 59, uby -8,calc_points,redraw,2).loadGraphic( _u_button3_sprite, _u_button63_sprite )			
			_u_button4_sprite = new FlxSprite(0, 0);
			_u_button4_sprite.loadGraphic(ImgUButtons4, true, true, 16, 16);
			_u_button4 = new UpgradeButton( ubx + 79, uby -8,calc_points ,redraw,3 ).loadGraphic( _u_button4_sprite, _u_button64_sprite )
			_u_button5_sprite = new FlxSprite(0, 0);
			_u_button5_sprite.loadGraphic(ImgUButtons5, true, true, 16, 16);
			_u_button5 = new UpgradeButton( ubx + 99, uby -8,calc_points,redraw,4 ).loadGraphic( _u_button5_sprite, _u_button65_sprite )
			
			//Turn upgrade buttons off if the upgrade is off...
			if (Globals.global_power[0] == 0 )
				_u_button1.switchOn()
			if (Globals.global_power[1] == 0 )
				_u_button2.switchOn()				
			if (Globals.global_power[2] == 0 )
				_u_button3.switchOn()
			if (Globals.global_power[3] == 0 )
				_u_button4.switchOn()
			if (Globals.global_power[4] == 0 )
				_u_button5.switchOn()				
			
			
			blur_layer.add(_u_button1);
			blur_layer.add(_u_button2);
			blur_layer.add(_u_button3);
			blur_layer.add(_u_button4);
			blur_layer.add(_u_button5);

			_upgrade_text1 = new BFont(ubx -20, uby - 50, "Total Goal Points:" + String(calc_points()), ImgBitmapFont2,  9, 12, 33, 0, 0,"left")
			blur_layer.add(_upgrade_text1);
			redraw(-1);
			
			
			
			//Sprites for the select buttons
			for (var im:int = 0; im < 9; im += 1)
			{
				_img_1_array.push( new FlxSprite(0, 0).loadGraphic(ImgButton1, true, true, 32, 32) );
				_img_2_array.push( new FlxSprite(0, 0).loadGraphic(ImgButton2, true, true, 32, 32) );
			}
			//Place the buttons			
			for (var btn:int = 0; btn < _img_1_array.length; btn += 1)
			{
				//Number of rows
				var rownum:int = 3;
				//Starting positions
				var startx:int = 11; var starty:int = 32;
				//How much to move the buttons by
				var xchange:int = 35; var ychange:int = 35;
				//Amount to change y by. Based off of rows of three starting at Y 36
				var ny:int = ychange * Math.floor(btn / rownum ) + starty;
				var nx:int = ( startx + ( xchange * btn ) ) - ( Math.floor(btn / rownum ) *  ( xchange * rownum) );
				
				//Create level select buttons IF the button being drawn is greater or = the level unlocked var
				if (Globals.global_level_unlocked >= btn )
				{
					_button.push( new FlxButton( nx , ny , startGame, btn ).loadGraphic( _img_2_array[btn], _img_1_array[btn]) );
					blur_layer.add( _button[btn] );
					//Add text
					_button_font.push( new BFont(nx + 16, ny + 5, "Lvl\n" + (btn + 1).toString() , ImgBitmapFont2, 9, 12, 33, 0, 0, "center") )
					blur_layer.add( _button_font[btn] );
				}
				else //If the level is not unlocked draw the locked sprite
				{
					var tmp_sprite:FlxSprite = new FlxSprite(nx, ny).loadGraphic(ImgButton3);
					blur_layer.add( tmp_sprite );
				}
			}
			
			//Fix for when you unlock more than the number of levels available
			if (Globals.global_level_unlocked > 8)
				Globals.global_level_unlocked = 8;
			
			//Auto select the greatest level opened
			_button[Globals.global_level_unlocked].switchOn();

			_selected_level = Globals.global_level_unlocked;
			
			//Flash the screen on
			FlxG.flash(0xff000000, 1);
			
			//Stats Layout
			
			//Background sprite
			_stats_sprite = new FlxSprite(1, 0);
			_stats_sprite.loadGraphic(ImgStats, true, true, 318, 240);
			layer3.add(_stats_sprite);	
			//Level select text
			_stats_font_title = new BFont(252, 34, ( _selected_level + 1 ).toString(), ImgBitmapFont,  16, 16, 33, 0, 0,"center")
			layerHUD.add(_stats_font_title);
			
			_stats_font_score = new BFont(130, 52, "Level " + ( _selected_level + 1 ).toString() , ImgBitmapFont2,  9, 12, 33, 0, 0)
			layerHUD.add(_stats_font_score);
			
			drawStats(_selected_level);



			//_line1 = new BFont(160, 5, "Select Level", ImgBitmapFont,  16, 16, 33, 0, 0,"center")
			// layerHUD.add(_line1);
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
		
		override public function update():void
		{
			
			if ( _timer > 0)
			{
				_timer -= FlxG.elapsed;
				//_line1.alpha += FlxG.elapsed * 0.5
			}		

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
				
			redraw( -1);
			
			
			if ( FlxG.keys.pressed("C") || FlxG.keys.pressed("X") || FlxG.keys.pressed("J") || FlxG.keys.pressed("K") )
			{
				reallyStartGame();
			}
			
				
			super.update();
			
		}
		
		private function redraw(U:int):void
		{
			
			var total_score:int = 0;
			for ( var i:int = 0; i < 10;i+=1 )
				total_score += Globals.global_level_score[i]; 
			
			var the_text:String = "Total Score:" + total_score.toString() + "\n" + "Total Goal Points:" + String(calc_points() );
			
			the_text += "\n\n\n"
			
			if ( U == 0)
				the_text += "\nDouble Jump\nJump Mid air" 
			if ( U == 1)
				the_text += "\nShadow Kick\nDown+Attack" 
			if ( U == 2)
				the_text += "\nChi Beam\nHold Attack" 
			if ( U == 3)
				the_text += "\nFlip Kick\nJump+Up+Attack" 
			if ( U == 4)
				the_text += "\nDrill Attack\nJump+Down+Attack" 				
			
			
			if (U != -1 && Globals.global_power[U] != 1 )
				the_text += "\nUpgrade Cost:" + String(_pcost[U])
			
			if (U != -1 && Globals.global_power[U] == 1 )
				the_text += "\nPoints Returned:" + String(_pcost[U])	
				
			_upgrade_text1.update_text(the_text );
			
			
			
			return;
		}
		
		private function calc_points(U:int=-1):int
		{
			var P:int = 0;
			var pressed:int = 0;
			for (var i:int = 0; i < 10; i += 1)
			{
				if ( Globals.global_coins_goal[i] > 0 && Globals.global_coins_goal[i] <= Globals.global_level_coins[i] )
				{
					P += 1;
				}
				if ( Globals.global_kills_goal[i] > 0 && Globals.global_kills_goal[i] <= Globals.global_level_kills[i] )
				{
					P += 1;
				}
				if ( Globals.global_knock_outs_goal[i] > 0 && Globals.global_knock_outs_goal[i] >= Globals.global_level_knock_outs[i] )
				{
					P += 1;
				}
				if ( Globals.global_timer_goal[i] > 0 && Globals.global_timer_goal[i] >= Globals. global_level_timer[i] )
				{
					P += 1;
				}				
				if ( Globals.global_combo_goal[i] > 0 && Globals.global_combo_goal[i] <= Globals.global_level_combo[i] )
				{
					P += 1;
				}
				if ( Globals.global_score_goal[i] > 0 && Globals.global_score_goal[i] <= Globals.global_level_score[i] )
				{
					P += 1;
				}				
			}
			
	
			
			//Calculate Points based off of which powers remain on
			if (Globals.global_power[0] == 1) ////Double jump ;
				P -= _pcost[0];
			if (Globals.global_power[1] == 1) ////Slide Kick;
				P -= _pcost[1];
			if (Globals.global_power[2] == 1) ////Power Punch;
				P -= _pcost[2];				
			if (Globals.global_power[3] == 1) ////Flip Kick;
				P -= _pcost[3];
			if (Globals.global_power[4] == 1) ////Eagle Dive;
				P -= _pcost[4];			
			
			
			//Turn off powers and add Points back
			if (U == 0 && Globals.global_power[0] == 1)
			{
				Globals.global_power[0] = 0;
				P += _pcost[0];
				_u_button1.switchOn();
				pressed = 1;
			}
			if (U == 1 && Globals.global_power[1] == 1)
			{
				Globals.global_power[1] = 0;
				P += _pcost[1];
				_u_button2.switchOn();
				pressed = 1;
			}			
			if (U == 2 && Globals.global_power[2] == 1)
			{
				Globals.global_power[2] = 0;
				P += _pcost[2];
				_u_button3.switchOn();
				pressed = 1;
			}				
			if (U == 3 && Globals.global_power[3] == 1)
			{
				Globals.global_power[3] = 0;
				P += _pcost[3];
				_u_button4.switchOn();
				pressed = 1;
			}
			if (U == 4 && Globals.global_power[4] == 1)
			{
				Globals.global_power[4] = 0;
				P += _pcost[4];
				_u_button5.switchOn();
				pressed = 1;
			}	

			//Turn on powers and resubtract points
			if (U == 0 && Globals.global_power[0] == 0 && pressed == 0 && P - _pcost[0] >= 0 )
			{
				Globals.global_power[0] = 1;
				P -= _pcost[0];
				_u_button1.switchOff();
			}
			if (U == 1 && Globals.global_power[1] == 0 && pressed == 0 && P - _pcost[1] >= 0)
			{
				Globals.global_power[1] = 1;
				P -= _pcost[1];
				_u_button2.switchOff();
			}			
			if (U == 2 && Globals.global_power[2] == 0 && pressed == 0 && P - _pcost[2] >= 0)
			{
				Globals.global_power[2] = 1;
				P -= _pcost[2];
				_u_button3.switchOff();
			}				
			if (U == 3 && Globals.global_power[3] == 0 && pressed == 0 && P - _pcost[3] >= 0)
			{
				Globals.global_power[3] = 1;
				P -= _pcost[3];
				_u_button4.switchOff();
			}
			if (U == 4 && Globals.global_power[4] == 0 && pressed == 0 && P - _pcost[4] >= 0)
			{
				Globals.global_power[4] = 1;
				P -= _pcost[4];
				_u_button5.switchOff();
			}				

			return(P);
		}
		

		
		private function drawStats(WhichLevel:int=0):void
		{
			var the_text:String = "\n";
			var check:String = "^";
			var points:int = 0;

			if ( Globals.global_coins_goal[WhichLevel] )
			{
				if ( Globals.global_coins_goal[WhichLevel] <= Globals.global_level_coins[WhichLevel] )
				{
					check = "^";
					points += 1;
				}
				else
				{
					check = " ";
				}
				the_text +=  "\n" + check +  " Coins: " + Globals.global_coins_goal[WhichLevel].toString();
			}
			if ( Globals.global_kills_goal[WhichLevel] )
			{
				if ( Globals.global_kills_goal[WhichLevel] <= Globals.global_level_kills[WhichLevel] )
				{
					check = "^";
					points += 1;
				}
				else
				{
					check = " ";
				}				
				the_text += "\n" + check +  " Kills: " + Globals.global_kills_goal[WhichLevel].toString() ;
			}
			if ( Globals.global_knock_outs_goal[WhichLevel] )
			{
				if ( Globals.global_knock_outs_goal[WhichLevel] >= Globals.global_level_knock_outs[WhichLevel] )
				{
					check = "^";
					points += 1;
				}
				else
				{
					check = " ";
				}				
				the_text += "\n" + check +  " Falls: " + Globals.global_knock_outs_goal[WhichLevel].toString();
			}
			if ( Globals.global_timer_goal[WhichLevel] )
			{
				if ( Globals.global_timer_goal[WhichLevel] >= Globals. global_level_timer[WhichLevel] )
				{
					check = "^";
					points += 1;
				}
				else
				{
					check = " ";
				}				
				var time:Array = getTime(Globals.global_timer_goal[WhichLevel])
				the_text += "\n" + check +  " Speed: " + time[0] + ":" + time[1];
			}
			if ( Globals.global_combo_goal[WhichLevel] )
			{
				if ( Globals.global_combo_goal[WhichLevel] <= Globals.global_level_combo[WhichLevel] )
				{
					check = "^";
					points += 1;
				}
				else
				{
					check = " ";
				}				
				the_text += "\n" + check +  " Combo: " + Globals.global_combo_goal[WhichLevel].toString() ;
			}
			if ( Globals.global_score_goal[WhichLevel] )
			{
				if ( Globals.global_score_goal[WhichLevel] <= Globals.global_level_score[WhichLevel] )
				{
					check = "^";
					points += 1;
				}
				else
				{
					check = " ";
				}				
				the_text += "\n" + check + " Score: " + Globals.global_score_goal[WhichLevel].toString() ;
			}
			
			//Put high score for level here:
			the_text += "\n"
			the_text += "Goal Points:" + points + "/3" + "\nLevel Score:" + Globals.global_level_score[WhichLevel].toString();
			_stats_font_score.update_text(the_text);
			
			_stats_font_title.update_text( ( WhichLevel + 1 ).toString()  );
		}
		
		
		private function startGame(WhichLevel:int):void
		{
			_start_game = 1;
			_selected_level = WhichLevel;
			//Reset all buttons and turn on selected
			for ( var btn:int = 0; btn < _button.length; btn++)
				_button[btn].switchOff();	
			_button[WhichLevel].switchOn();
			//Refresh stats pane
			drawStats(WhichLevel);	
		}
		
		private function reallyStartGame():void
		{
			Globals.global_level = _selected_level;
			FlxG.switchState(Transition2);
		}
		
		private function gotoMenu():void
		{
			FlxG.switchState(Transition3);
		}		
		
		private function getTime(Seconds:int):Array 
		{
			var seconds:Number = 0;
			var minutes:Number = Math.floor(Seconds / 60);
			seconds = Seconds - minutes * 60;
			var seconds_string:String = seconds.toString();		
			var minutes_string:String = minutes.toString();
			if (minutes < 10)
				minutes_string = "0" + minutes.toString();
			if (seconds < 10)
				seconds_string = "0" + seconds.toString();
			var p:Array = new Array(minutes_string,seconds_string);
			return p;
		}		

	}
	
}