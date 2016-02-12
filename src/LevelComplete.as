package com.KungFu 
{
	import flash.geom.Point;
	import org.flixel.*;
	

	public class LevelComplete extends FlxState
	{
		
		
		//Fonts
		[Embed(source = "../../data/BitmapFont2.png")] private var ImgBitmapFont:Class;
		[Embed(source = "../../data/BitmapFont.png")] private var ImgBigBitmapFont:Class;
		[Embed(source = "../../data/Sounds/fail.mp3")] private var SndFail:Class;
		[Embed(source = "../../data/Sounds/success.mp3")] private var SndSuccess:Class;	
		[Embed(source = "../../data/Sounds/Victory.mp3")] private var SndVictory:Class;
		
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
		
		public function LevelComplete() 
		{
			
			super();
			
			FlxG.playMusic(SndVictory);
			
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
			_nice_sayings.push("A banana is as yellow\n as you are gifted.");
			_nice_sayings.push("Amazement is mine!");
			_nice_sayings.push("Like a flower blooming\nyour skills increase!");
			
			
			layer0 = new FlxLayer();
			layer1 = new FlxLayer();
			layer2 = new FlxLayer();
			layer3 = new FlxLayer();
			layerHUD = new FlxLayer();
			
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
			
			FlxG.flash(0xff000000, 2);
			
			//Add the master
			_master = new Master(68, 14)
			layer0.add(_master);	
			_master.play("silent");
			
			
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
			
		}
		
		override public function update():void
		{
			
			super.update();
			
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
					if (( FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") )  || _timer2 >= 5)
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
					if (( FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") )  || _timer2 >= 5)
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
					_level_complete.update_text("Game Saved\nPress X or J\nto Continue...");
				}
			}			
			
			
			
			//Move to next state
			if (_state == 7 )
			{
				if (_timer2 < 5)
					_timer2 += FlxG.elapsed;
				_level_complete.alpha = _timer2;
				
				
				
				
				if (( FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") ) && _timer2 > 0.1 )
				{
					FlxG.switchState(SelectState)
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