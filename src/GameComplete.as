package com.KungFu 
{
	import flash.geom.Point;
	import org.flixel.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;		

	public class GameComplete extends FlxState
	{
		
		
		//Fonts
		[Embed(source = "../../data/BitmapFont2.png")] private var ImgBitmapFont:Class;
		[Embed(source = "../../data/BitmapFont.png")] private var ImgBigBitmapFont:Class;
		[Embed(source = "../../data/Sounds/fail.mp3")] private var SndFail:Class;
		[Embed(source = "../../data/Sounds/success.mp3")] private var SndSuccess:Class;		
		[Embed(source = "../../data/Sounds/End.mp3")] private var SndEnd:Class;	
		[Embed(source = "../../data/Sounds/Victory.mp3")] private var SndVictory:Class;
		[Embed(source = "../../data/CreditsBG.png")] private var ImgBG:Class;
		
		[Embed(source = "../../data/PlayerFall.png")] private var ImgPlayerFall:Class;
		
		[Embed(source = "../../data/CreditsFGFalling.png")] private var ImgFGFall:Class;
		[Embed(source = "../../data/CreditsBGFalling.png")] private var ImgBGFall:Class;
		[Embed(source = "../../data/Draffut.png")] private var ImgDraffut:Class;
		
		[Embed(source = "../../data/SponsorSmall.png")] private var ImgSponsor:Class;	
		[Embed(source = "../../data/SponsorSmall2.png")] private var ImgSponsor2:Class;
		
		[Embed(source = "../../data/ExitButton2.png")] private var ImgExit2:Class;
		[Embed(source = "../../data/ExitButton.png")] private var ImgExit:Class;
		
		private var _button_sponsor:FlxButton;
		private var _button_sponsor_sprite1:FlxSprite;
		private var _button_sponsor_sprite2:FlxSprite;		
		
		private var _button_exit:FlxButton;
		private var _button_exit_sprite1:FlxSprite;
		private var _button_exit_sprite2:FlxSprite;				
		
		private var _master:Master;
		public static var layer0:FlxLayer;		
		public static var layer1:FlxLayer;
		public static var layer2:FlxLayer;		
		public static var layer3:FlxLayer;
		public static var layerHUD:FlxLayer;
		

		
		
		private var _level_complete:BFont;
		private var _line1:BFont;
		private var _line2:BFont;
		private var _line3:BFont;
		private var _line4:BFont;
		private var _score:BFont;
		
		private var _state:int  = 0;
		
		private var _timer2:Number = 0;
		private var _timer:Number = 0.5;
		
		private var _which_awards:Array = new Array;
		private var _how_many_awards:int = 0;
		private var _award_count:int = 0;
		
		//Texts
		private var _mean_sayings:Array = new Array;
		private var _nice_sayings:Array = new Array;
		
		//End of game effect
		private var _bg_array:Array = new Array();
		private var _bg_falling_array:Array = new Array();
		private var _fg_falling_array:Array = new Array();
		private var _roll_credits:int = 0;
		
		private var _player_fall:FlxSprite;
		
		private var _which_credit:int = 0;
		
		private var _draffut:FlxSprite;
		private var _draffut_count:Number = 0;
		
		private var _big_black_square:FlxSprite;
		
		public function GameComplete() 
		{
			
			super();
			
			
			_mean_sayings.push("If only your skills\n were as potent as\n as your terrible smell.");
			_mean_sayings.push("Did your mommy teach you Kung Fu?");
			_mean_sayings.push("In a past life you were a loser.\n Just like now!");
			_mean_sayings.push("Did you not pay attention \nto any of my instructions?");
			_mean_sayings.push("For some the world is their oyster.\nFor you it is rotten fish.");
			_mean_sayings.push("I will never cease to be amazed\nat your incompetence."); //6
			_mean_sayings.push("Hell would not have you.");
			_mean_sayings.push("Women faint when they see you.\nOut of shame!");
			_mean_sayings.push("I would like to kick you.");
			
			_nice_sayings.push("Your abilities are\nmost impressive!");
			_nice_sayings.push("Your Kung FU\n is strong!");
			_nice_sayings.push("Power like yours is\nindeed a wonder to behold!");
			_nice_sayings.push("Done with amazing\nskill, oh pupil of mine.");
			_nice_sayings.push("Almost as good\nas I would have done!");
			_nice_sayings.push("Truly you are a Kung Fu\Master!");
			_nice_sayings.push("A bannana is as yellow\n as you are gifted.");
			_nice_sayings.push("Amazement is mine!");
			_nice_sayings.push("Like a flower blooming\nyour skills increase!");
			
			FlxG.playMusic(SndVictory);
			
			
			layer0 = new FlxLayer();
			layer1 = new FlxLayer();
			layer2 = new FlxLayer();
			layer3 = new FlxLayer();
			layerHUD = new FlxLayer();
			
			_big_black_square = new FlxSprite(0, 0);
			_big_black_square.createGraphic(320, 240, 0xff000000);
			_big_black_square.alpha = 0;
			layerHUD.add(_big_black_square);
			
			//Build the array to store which awards were available for the level
			if (Globals.global_coins_goal[Globals.global_level] > 0)
				_which_awards.push(0)
			if (Globals.global_combo_goal[Globals.global_level] > 0)
				_which_awards.push(1)
			if (Globals.global_kills_goal[Globals.global_level] > 0)
				_which_awards.push(2)
			if (Globals.global_knock_outs_goal[Globals.global_level] > 0)
				_which_awards.push(3)
			if (Globals.global_timer_goal[Globals.global_level] > 0)
				_which_awards.push(4)	
			if (Globals.global_score_goal[Globals.global_level] > 0) //Score must be last after all other achievements
				_which_awards.push(5)
			
			FlxG.flash(0xff73F17C, 2);
			//Create the bg  image
			var flood:FlxSprite;
			for ( var i:int = 0; i < 10; i++)
			{
				flood = new FlxSprite( (32*i), 0 );
				flood.loadGraphic(ImgBG, true, true, 32, 1280);
				_bg_array.push(layer0.add(flood));
			}		
			
			//Bg sprites
			for ( var ii:int = 0; ii < 10; ii++)
			{
				flood = new FlxSprite( Math.random() * 320, -50 - Math.random() * 600 );
				flood.loadGraphic(ImgBGFall, true, true, 32, 26);
				flood.addAnimation("1", [0]);
				flood.addAnimation("2", [1]);
				flood.addAnimation("3", [2]);
				flood.addAnimation("4", [3]);
				
				var poo:int = Math.round(Math.random() * 12 )
				flood.scale.x  = flood.scale.y = Math.random() * 0.5 + 0.5;
				flood.angle += (FlxG.elapsed * 100 * Math.random() * 100)				
				if ( poo < 2)
					flood.play("1");
				if (  poo >= 2 && poo < 4)
					flood.play("2");
				if (  poo >= 4 && poo < 8)
					flood.play("3");
				if (  poo >= 8 && poo <= 12)
					flood.play("4");
				flood.velocity.y = 100 - Math.random() * 50;
				_bg_falling_array.push( layer0.add(flood) );
			}			
			
			//FG sprites
			for ( ii = 0; ii < 5; ii++)
			{
				flood = new FlxSprite( Math.random() * 320, -50 - Math.random() * 600 );
				flood.loadGraphic(ImgFGFall, true, true, 33, 33 );
				flood.addAnimation("1", [0]);
				flood.addAnimation("2", [1]);
				flood.addAnimation("3", [2]);
				flood.addAnimation("4", [3]);
				
				poo = Math.round(Math.random() * 12 )
				flood.scale.x  = flood.scale.y = Math.random() * 0.5 + 1;
				flood.angle += (FlxG.elapsed * 100 * Math.random() * 100)				
				if ( poo < 2)
					flood.play("1");
				if (  poo >= 2 && poo < 4)
					flood.play("2");
				if (  poo >= 4 && poo < 8)
					flood.play("3");
				if (  poo >= 8 && poo <= 12)
					flood.play("4");
				flood.velocity.y = 300 - Math.random() * 180;
				_fg_falling_array.push( layer2.add(flood) );
			}				
			
			//Enable the mouse
			FlxG.showCursor();
			
			
			//Add the master
			_master = new Master(68, 14)
			layer2.add(_master);	
			_master.play("silent");
			_master.alpha = 0.5
			
			
			_level_complete = new BFont(-120, 0, "LEVEL COMPLETE!", ImgBigBitmapFont, 16, 16, 33, 0, 0,"center");
			layerHUD.add(_level_complete);
			
			_score = new BFont(10, -50, "SCORE:" + Globals.global_score.toString(), ImgBigBitmapFont, 16, 16, 33, 0, 0);
			layerHUD.add(_score);
			
			
			_line1 = new BFont(160, 180, " x",ImgBitmapFont, 9, 12, 33, 0, 0,"center")
			layerHUD.add(_line1);
			_line1.alpha = 0;
			
			_line2 = new BFont(160, 220, _which_awards[0],ImgBitmapFont, 9, 12, 33, 0, 0,"center")
			layerHUD.add(_line2);
			_line2.alpha = 0;
			
			this.add(layer0);  //Since this is the first layer it will be in the background
			this.add(layer1);  //Since this is the second layer it goes in the middle
			this.add(layer2);  //The is layer which is the foreground effects
			this.add(layer3);  //The is the final layer which is the VERY foreground
			this.add(layerHUD);  //The is the final layer which is the VERY foreground
			
			bgColor = 0xff000000;
			
			//Sponsor
			_button_sponsor_sprite1 = new FlxSprite(0, 0);
			_button_sponsor_sprite1.loadGraphic(ImgSponsor, true, true, 64, 32);
			_button_sponsor_sprite2 = new FlxSprite(0, 0);
			_button_sponsor_sprite2.loadGraphic(ImgSponsor2, true, true, 64, 32 );
			_button_sponsor = new FlxButton( 246 , 205, gotoSponsor ).loadGraphic( _button_sponsor_sprite1, _button_sponsor_sprite2 )
			layerHUD.add( _button_sponsor);	
			_button_sponsor.visible = false;

			//Sprites for the exit button
			_button_exit_sprite1 = new FlxSprite(0, 0);
			_button_exit_sprite1.loadGraphic(ImgExit, true, true, 64, 32);
			_button_exit_sprite2 = new FlxSprite(0, 0);
			_button_exit_sprite2.loadGraphic(ImgExit2, true, true, 64, 32);
			_button_exit = new FlxButton( 246 , 165 , gotoMenu ).loadGraphic( _button_exit_sprite1, _button_exit_sprite2 )
			layerHUD.add( _button_exit );	
			_button_exit.visible = false;

			
		
			
		}
		
		private function gotoSponsor():void
		{
			navigateToURL(new URLRequest("http://lupigames.com"));
		}		
		
		private function gotoMenu():void
		{
			FlxG.switchState(Transition3);
		}				
		
		private function endCredits():void
		{
			
			_draffut = new FlxSprite(-80, 162);
			_draffut.loadGraphic(ImgDraffut, true, true, 64, 64);
			_draffut.addAnimation("normal", [0, 1, 2, 3, 4], 12);
			_draffut.addAnimation("flying", [2], 12);			
			_draffut.facing = 1;
			_draffut.play("flying");
			layer1.add(_draffut);				
			
			//Do this once and only once the stats for level are displayed....
			_player_fall = new FlxSprite(156, -38  );
			_player_fall.loadGraphic(ImgPlayerFall, true, true, 38, 38);
			_player_fall.addAnimation("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 10);
			_player_fall.addAnimation("saved", [8], 0);
			_player_fall.play("normal");

			_player_fall.velocity.y = 100;
			layer1.add(_player_fall);
			_line1.y = 360;
			FlxG.playMusic(SndEnd);
			
		

			
		}
		
		private function returnToMenu():void
		{
			FlxG.switchState(MenuState);
		}
		
		private function finalCredits():void
		{
			if (_player_fall.velocity.y > 0)
				_player_fall.velocity.y -= FlxG.elapsed * 35;
			if (_player_fall.velocity.y < 0)
				_player_fall.velocity.y = 0;

			_level_complete.alpha = 1;
			_line1.alpha = 1;
			//Draw credits
			if ( _level_complete.y < -100 )
			{
				_button_sponsor.visible = true;
				_button_exit.visible = true;
				
				if (_which_credit != 7)
				{
					_level_complete.y = 330;
					_level_complete.velocity.y = -60;
					_line1.velocity.y = -60;
					_line1.y = 360;
				}
				if (_which_credit == 0)
				{
					_level_complete.update_text("Congrats");
					_line1.update_text("The Goblins are defeated...\n...you are a legend.");
				}
			if (_which_credit == 1)
				{
					_level_complete.update_text("Code and Design");
					_line1.update_text("Robert Lupinek");
				}	
			if (_which_credit == 2)
				{
					_level_complete.update_text("Music By");
					_line1.update_text("Kristian Caldwell\nAKA Bunnymajs");
				}	
			if (_which_credit == 3)
				{
					_level_complete.update_text("Tools Used");
					_line1.update_text("Flan Map Editor\nby Martin Sebastian Wain\n\nFlixel Framework by\nAdam Saltsman\n\nSFXR by\n Thomas Pettersson");
		
				}
			if (_which_credit == 4)
				{
					_level_complete.update_text("Beta Testers");
					_line1.update_text("Justin Leingang\n\nRyan Malm\n\nChris Casebeer");
		
				}
			if (_which_credit == 5)
				{
					_level_complete.update_text("Dedicated to");
					_line1.update_text("My Dog\nDraffut");
				}
			if (_which_credit == 6)
				{
					_level_complete.update_text("Thanks for playing!");
					_line1.update_text("Your Kung Fu is strong!");
					
				}
			//Draffut to the rescue!
			if (_which_credit == 7)
				{
					_draffut.velocity.x = 400;		
					_draffut.velocity.y = -150;
					_draffut_count += FlxG.elapsed;
					if (_draffut_count > 0.55)
					{
						_player_fall.velocity.x = 400;		
						_player_fall.velocity.y = -150;	
						_player_fall.play("saved");	
						_player_fall.scale.y = -1;
						FlxG.music.volume -= 0.01;
						_big_black_square.alpha += 0.01;
						_line1.y = 120;
						_line1.update_text("The End...");
					}
					if (_draffut_count > 8)
						FlxG.fade(0xffFFFFFF, 1,returnToMenu);
				}
			if (_which_credit != 7)
				_which_credit += 1;
			}				
		}
		
		override public function update():void
		{
			
			super.update();
			
			
			
			//Falling debris
			//Bg sprites
			for ( var i:int = 0; i < _bg_falling_array.length; i++)
			{
				_bg_falling_array[i].angle += (FlxG.elapsed * ( 10 * Math.random() * 100 ) )
				if (_bg_falling_array[i].y > 340)
				{
					_bg_falling_array[i].scale.x = _bg_falling_array[i].scale.y = Math.random() * 0.5 + 0.5;
					_bg_falling_array[i].x = Math.random() * 320;
					_bg_falling_array[i].y = -50 - Math.random() * 600
					var poo:int = Math.round(Math.random() * 12 )
					if ( poo < 2)
						_bg_falling_array[i].play("1");
					if (  poo >= 2 && poo < 4)
						_bg_falling_array[i].play("2");
					if (  poo >= 4 && poo < 8)
						_bg_falling_array[i].play("3");
					if (  poo >= 8 && poo <= 12)
						_bg_falling_array[i].play("4");
				}
			}		
			//Fg sprites
			for ( i = 0; i < _fg_falling_array.length; i++)
			{
				_fg_falling_array[i].angle += (FlxG.elapsed * ( 10 * Math.random() * 50 ) )
				if (_fg_falling_array[i].y > 340)
				{
					_fg_falling_array[i].scale.x = _fg_falling_array[i].scale.y = Math.random() * 0.5 + 1;
					_fg_falling_array[i].x = Math.random() * 320;
					_fg_falling_array[i].y = -50 - Math.random() * 600
					poo = Math.round(Math.random() * 12 )
					if ( poo < 2)
						_fg_falling_array[i].play("1");
					if (  poo >= 2 && poo < 4)
						_fg_falling_array[i].play("2");
					if (  poo >= 4 && poo < 8)
						_fg_falling_array[i].play("3");
					if (  poo >= 8 && poo <= 12)
						_fg_falling_array[i].play("4");
				}
			}				
			
			
			
			
			if (_roll_credits)
			{
				finalCredits();
			}
			
			
			if ( _timer > 0)
			{
				_timer -= FlxG.elapsed;
				
			}
			else
			{
				//Text moves across screen
				if ( _state == 0 )
				{
					_level_complete.velocity.x = 400;
					_state = 1;
				}
			}
			
			//Text moves stops and begins awards state
			if ( _state == 1 )
			{
				if ( _level_complete.x >= 160 )
				{
					_level_complete.velocity.x = 0;

					_state = 2;
				}
			}
			
			//Drop down the score text
			if ( _state == 2 )
			{			
				//Wait to move level complete and display score
				if (_timer2 < 2)
				{
					_timer2 += FlxG.elapsed;
				}
				else //Display score - remove level complete
				{
					//Get rid of level complete text
					_level_complete.velocity.x = 400;
					//Move the score text down
					_score.velocity.y = 100;
					//Change state when score is in position and set initial achievement
					if (_score.y >= 0)
					{
						//Change the state
						_state = 3;
						//Stop the score text
						_score.velocity.y = 0;
						//Check the first achievement
						check_achievements();
						_timer2 = 0;						
					}
				}
			}
			
			//Loop through achievements
			if ( _state == 3)
			{
				if (_timer2 < 5)
					_timer2 += FlxG.elapsed;
				_line1.alpha = _timer2;
				_line2.alpha = _timer2;
				_master.play("normal");
				if (_timer2 >= 0.1 )
				{
					if (FlxG.keys.justPressed("X")  || _timer2 >= 5)
					{
						_award_count += 1; //Next award in the array please
						//Check awards
						if (_award_count < _which_awards.length)
							check_achievements();
						//Reset the timer
						_timer2 = 0;
						
					}
				}
				//When we reach the end of awards change to the next phase
				if ( _award_count >= _which_awards.length )
				{
					_state = 4
					_timer2 = 0;
					_score.update_text( "SCORE:" + Globals.global_score.toString() );
				}
			}
			
			//Fade text out
			if ( _state == 4)
			{
				if (_timer2 < 1)
				{
					_timer2 += FlxG.elapsed;
					_line1.alpha = 1 - _timer2;
					_line2.alpha = 1 - _timer2;
					_master.play("silent");
				}
				else
				{
					_state = 5;
					_timer2 = 0;
				}
				
			}
			
			//Beat High score or not
			if ( _state == 5)
			{
				if (_timer2 == 0)
				{
					
					_line2.y -= 8;
					_master.play("normal");
					
					if ( Globals.global_score > Globals.global_level_score[Globals.global_level] )
					{
						_line1.update_text("NEW HIGH SCORE FOR LEVEL!");
						_line2.update_text( "New High Score:" + Globals.global_score.toString() + "\n" + "Old High Score:" + Globals.global_level_score[Globals.global_level] ) 
						Globals.global_level_score[Globals.global_level] = Globals.global_score;
					}
					else
					{
						_line1.update_text("You did not beat\n the old high score of:");
						_line2.update_text( Globals.global_level_score[Globals.global_level] );
					}
					
				}
				
				
				//Exit Level
				
				if (_timer2 < 5)
					_timer2 += FlxG.elapsed;
				_line1.alpha = _timer2;
				_line2.alpha = _timer2;
				
				if (_timer2 >= 0.1 )
				{
					if (FlxG.keys.justPressed("X")  || _timer2 >= 5)
					{
						_master.play("silent");
						_state = 6;
						_timer2 = 0;
					}
				}
			}
			
			
			//Fade text out
			if ( _state == 6 )
			{
				if (_timer2 < 1)
				{
					_timer2 += FlxG.elapsed;
					_line1.alpha = 1 - _timer2;
					_line2.alpha = 1 - _timer2;
					_master.shimmer += FlxG.elapsed * 60;
					_master.alpha = 1 - _timer2;
					_master.play("silent");
				}
				else
				{
					_state = 7;
					_timer2 = 0;
					_level_complete.alpha = 0;
					_level_complete.velocity.x = 0;
					_level_complete.x = 160;
					_level_complete.y = 30;
					
					//Unlock the next level
					if (Globals.global_level == Globals.global_level_unlocked && Globals.global_level < 8 )
						Globals.global_level_unlocked += 1;
						
				   
					
					Globals.saveGame();
					_level_complete.update_text("Game Saved...");
					_level_complete.y += 200;
				}
			}			
			
			
			
			//Start Credits rolling!
			if (_state == 7 )
			{
				if (_timer2 < 5)
					_timer2 += FlxG.elapsed;
				_level_complete.alpha = _timer2;

				if ( _timer2 > 0.1 && _roll_credits == 0 )
				{
					endCredits();
					//Rolllllling credits
					_roll_credits = 1;
					for (var c:int = 0; c < _bg_array.length; c++ )
					{
						_level_complete.velocity.y = -100;
						_bg_array[c].velocity.y = -10;
						_score.velocity.y = -100;
					}
				}
			}
			
			
		}
		
		private function check_achievements():void
		{		
			
			var _tmp_debug_info:String = " ";
			switch (_which_awards[_award_count]) 
			{
				
				case 0:
					_tmp_debug_info = "Coins:" + Globals.global_coins.toString() + " GOAL:" + Globals.global_coins_goal[Globals.global_level] + "\n";
					if ( Globals.global_coins >= Globals.global_coins_goal[Globals.global_level] )
					{
						FlxG.play(SndSuccess);
						_line1.update_text(_nice_sayings[Math.floor( Math.random() * 8 )])
						_how_many_awards += 1; 
						//Set globals
						Globals.global_level_coins[Globals.global_level] = Globals.global_coins;

						Globals.global_score += 1000;
						_score.update_text( "SCORE:" + Globals.global_score.toString() + " +1000" );

					}
					else
					{
						FlxG.play(SndFail);
						_tmp_debug_info = "_" + _tmp_debug_info;
						_line1.update_text(_mean_sayings[Math.floor( Math.random() * 8 )])
						_score.update_text( "SCORE:" + Globals.global_score.toString() );
					}
					break;
				case 1:				
					_tmp_debug_info = "Max Combo:" + Globals.global_combo_count.toString() + " GOAL:" + Globals.global_combo_goal[Globals.global_level] +"\n";
					if ( Globals.global_combo_count >= Globals.global_combo_goal[Globals.global_level] )
					{
						FlxG.play(SndSuccess);
						//Set globals
						Globals.global_level_combo[Globals.global_level] = Globals.global_combo_count;
						_tmp_debug_info = "^" + _tmp_debug_info;
						_line1.update_text(_nice_sayings[Math.floor( Math.random() * 8 )])
						_how_many_awards += 1; 
						
						Globals.global_score += 1000;
						_score.update_text( "SCORE:" + Globals.global_score.toString() + " +1000" );						
					}
					else
					{
						FlxG.play(SndFail);
						_tmp_debug_info = "_" + _tmp_debug_info;
						_line1.update_text(_mean_sayings[Math.floor( Math.random() * 8 )])
						_score.update_text( "SCORE:" + Globals.global_score.toString() );
					}
					break;
				case 2:		
					_tmp_debug_info = "Kills:" + Globals.global_kills.toString()  + " GOAL:" + Globals.global_kills_goal[Globals.global_level] +"\n";
					if ( Globals.global_kills >= Globals.global_kills_goal[Globals.global_level] )
					{
						FlxG.play(SndSuccess);
						//Set globals
						Globals.global_level_kills[Globals.global_level] = Globals.global_kills;
						_tmp_debug_info = "^" + _tmp_debug_info;
						_line1.update_text(_nice_sayings[Math.floor( Math.random() * 8 )])
						_how_many_awards += 1; 
						
						Globals.global_score += 1000;
						_score.update_text( "SCORE:" + Globals.global_score.toString() + " +1000" );						
					}
					else
					{
						FlxG.play(SndFail);
						_tmp_debug_info = "_" + _tmp_debug_info;
						_line1.update_text(_mean_sayings[Math.floor( Math.random() * 8 )])
						_score.update_text( "SCORE:" + Globals.global_score.toString() );
					}
					break;
				case 3:				
					_tmp_debug_info = "Knock Downs:" + Globals.global_knock_outs.toString()  + " GOAL:" + Globals.global_knock_outs_goal[Globals.global_level] +"\n";
					if ( Globals.global_knock_outs <= Globals.global_knock_outs_goal[Globals.global_level] )
					{
						FlxG.play(SndSuccess);
						//Set globals
						Globals.global_level_knock_outs[Globals.global_level] = Globals.global_knock_outs;
						_tmp_debug_info = "^" + _tmp_debug_info;
						_line1.update_text(_nice_sayings[Math.floor( Math.random() * 8 )])
						_how_many_awards += 1; 
						
						Globals.global_score += 1000;
						_score.update_text( "SCORE:" + Globals.global_score.toString() + " +1000" );						
					}
					else
					{
						FlxG.play(SndFail);
						_tmp_debug_info = "_" + _tmp_debug_info;
						_line1.update_text(_mean_sayings[Math.floor( Math.random() * 8 )])
						_score.update_text( "SCORE:" + Globals.global_score.toString() );
					}
					break;
				case 4:		
					var p1:Array = new Array;
					p1 = getTime(Globals.global_timer);
					var p2:Array = new Array;
					p2 = getTime(Globals.global_timer_goal[Globals.global_level]);
					_tmp_debug_info = "Speed:" + p1[0] + ":" + p1[1]  + " GOAL:" + p2[0] + ":" + p2[1] +"\n";
					if ( Globals.global_timer <= Globals.global_timer_goal[Globals.global_level] )
					{
						FlxG.play(SndSuccess);
						//Set globals
						Globals.global_level_timer[Globals.global_level] = Globals.global_timer;
						_tmp_debug_info = "^" + _tmp_debug_info;
						_line1.update_text(_nice_sayings[Math.floor( Math.random() * 8 )])
						_how_many_awards += 1; 
						
						Globals.global_score += 1000;
						_score.update_text( "SCORE:" + Globals.global_score.toString() + " +1000" );						
					}
					else
					{
						FlxG.play(SndFail);
						_tmp_debug_info = "_" + _tmp_debug_info;
						_line1.update_text(_mean_sayings[Math.floor( Math.random() * 8 )])
						_score.update_text( "SCORE:" + Globals.global_score.toString() );
					}
					break;		
				case 5:
					_tmp_debug_info = "Score:" + Globals.global_score.toString()  + " GOAL:" + Globals.global_score_goal[Globals.global_level] +"\n";
					if ( Globals.global_score >= Globals.global_score_goal[Globals.global_level] )
					{
						FlxG.play(SndSuccess);
						//Set globals
						Globals.global_score += 1000;
						_tmp_debug_info = "^" + _tmp_debug_info;
						_line1.update_text(_nice_sayings[Math.floor( Math.random() * 8 )])
						_how_many_awards += 1; 
						
						
						_score.update_text( "SCORE:" + Globals.global_score.toString() + " +1000" );						
					}
					else
					{
						FlxG.play(SndFail);
						_tmp_debug_info = "_" + _tmp_debug_info;
						_line1.update_text(_mean_sayings[Math.floor( Math.random() * 8 )])
						_score.update_text( "SCORE:" + Globals.global_score.toString() );
					}
					break;	
			}
			
			//Update info on award
			_line2.update_text(_tmp_debug_info)
			//Add to how many awards you received?
			
			return;
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