package com.KungFu
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	import org.flixel.data.FlxPause;

	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;	

	public class PlayState extends FlxState
	{
		//Load the MP3 to be played as the song loop.
		[Embed(source = "../../data/Sounds/kungfu.mp3")] private var SndLoop1:Class;
		[Embed(source = "../../data/Sounds/Song2.mp3")] private var SndLoop2:Class;
		[Embed(source = "../../data/Sounds/Song3.mp3")] private var SndLoop3:Class;
		[Embed(source = "../../data/Sounds/SlimeFlow.mp3")] private var SndSlime:Class;
		[Embed(source = "../../data/Sounds/Boss.mp3")] private var SndBossFight:Class;
		
		//Hit sounds
		[Embed(source = "../../data/Sounds/hit1.mp3")] private var SndHit1:Class;
		[Embed(source="../../data/Sounds/hit2.mp3")] private var SndHit2:Class;		
		[Embed(source = "../../data/Sounds/hit3.mp3")] private var SndHit3:Class;
		[Embed(source = "../../data/Sounds/bighit1.mp3")] private var SndBigHit:Class;		
		[Embed(source = "../../data/Sounds/highya.mp3")] private var SndHighYa:Class;
		[Embed(source = "../../data/Sounds/explosion2.mp3")] private var SndExplode:Class;	
		
		[Embed(source = "../../data/Sounds/fail.mp3")] private var SndFail:Class;
		[Embed(source = "../../data/Sounds/success.mp3")] private var SndSuccess:Class;

		[Embed(source = "../../data/16.png")] private var ImgTiles16:Class;
		[Embed(source = "../../data/32.png")] private var ImgTiles32:Class;	
		[Embed(source = "../../data/32FG.png")] private var ImgTiles32Fg:Class;	
		[Embed(source = "../../data/BG_Parallax.png")] private var ImgBgParallax:Class;

		//Effects
		[Embed(source = "../../data/Blood.png")] private var ImgSparks:Class;
		
		[Embed(source = "../../data/DownArrow.png")] private var ImgDownArrow:Class;
		
		[Embed(source = "../../data/Master3.png")] private var ImgSafetyMaster:Class;
		
		[Embed(source = "../../data/BreakBlock.png")] private var ImgBreakBlock:Class;
		
		//Fonts
		[Embed(source = "../../data/BitmapFont.png")] private var ImgBitmapFont:Class;
		[Embed(source = "../../data/BitmapFont2.png")] private var ImgLittleFont:Class;
		
		//Last Battle Extras
		[Embed(source = "../../data/FGLast.png")] private var ImgFGLast:Class;
		[Embed(source = "../../data/FGLast2.png")] private var ImgFGLast2:Class;

		
		
		//Pause screens
		private var _one_boom:int = 0;
		private var _pause_normal:FlxLayer = new FlxPause();
		private var _pause_text:PauseText = new PauseText();
		public static var pause_state:int = 0;
		public static var pause_state_go:int = 0;
		
		//Last Fight Variables
		private var _lastFG:FlxSprite;
		private var _lastFG2:FlxSprite;
		//Game Objects
		
		//Level transistion for sounds
		public static var stop_sounds:int = 0;
		
		//Exit door
		public static var exit_door:PlayerDoor;
		public static var rollcredits:int = 0;
		//The variable to store the player's id
		public static var player:Player;
		public static var acidpool:AcidPool
		//Flixel Array (basically a Flash array + some extra functions)
		//This is going to store the block objects
		private var _blocks:Array = new Array; 
		//This Array is going to store the ninja stars!
		private var _p_attacks:Array; 
		//This Array is going to store the enemy ninja stars!
		private var _enemy_p_attacks:Array; 	
		//This is to create the enemy ninjas
		private var _enemy_ninjas:Array;
		
		private var _obstacles:Array = new Array;
		private var _coins:Array = new Array;
		//Acid Pool variables
		public static var acidpool_on:Boolean = false;
		
		//To play a sound only once a cycle - kinda
		private var _sound_go:int = 0;
		public static var explode_sound:FlxSound = new FlxSound;
		public static var jump_sound:FlxSound = new FlxSound;
		public static var die_sound:FlxSound = new FlxSound;
		public static var exp2_snd:FlxSound = new FlxSound;
		
		//Boss fight
		public static var boss_head:FlxSprite;
		

		
		//TILEMAP
		private var _tilemapParallax:FlxTilemap;
		private var _tilemapParallax2:FlxTilemap;
		private var _tilemap32FG:FlxTilemap;
		private var _tilemap32:FlxTilemap;
		public static var _tilemapObjects:FlxTilemap;
		public static var state_width:Number = 0;
		
		//Block array
		private var _block_blocks:Array = new Array;
		private var _bouncy_blocks:Array = new Array;
		private var _jumper_blocks:Array = new Array;
		
				
		//Effects images
		public static var blur_layer:MotionEffectLayer;
		//Effects sprite
		public static var helper:FlxSprite;		
		
		//COUNTERS
		private var _second:Number = 0;
		private var _timer:Number = 0;
		private var _goal_timer:Number;
		private var _timer_done:int = 0;
		
		//SETTINGS
		private var _game_over:Boolean = false;
		
		//The Score and other Displays properties
		public static var bonus:int = 10;
		private var _score_text:BFont;
		
		//TEXT
		//Debug
		private var _debug_text:BFont;
		private var _timer_text:BFont;
		private var _tmp_debug_info:String = "";

		//Combos
		private var _combo_timer:Number = 0;
		private var _combo_text:BFont;
		private var _combo_text2:BFont;
		private var _combo_target:Enemy;
		
		//GAME LAYERS - The order they are added to the determines their draw order
		public static var layerparalax:FlxLayer;
		public static var layer0:FlxLayer;		
		public static var layer1:FlxLayer;
		public static var layer2:FlxLayer;		
		public static var layer3:FlxLayer;
		public static var layerFX:FlxLayer;
		public static var layerHUD:FlxLayer;
		
		//Final boss
		private var _boss:BigBoss;
		
		//Tutorial?
		private var _down_arrow:FlxSprite;	
		public static var _safety_master:FlxSprite;	
		
		function PlayState():void
		{
			
			super();
			
			//FlxG.showCursor();
			
    		//////////////////
			//RESET STATS
			//////////////////
			
			stop_sounds = 0;
			
			pause_state_go = 0;
			pause_state = 0;
			
			Globals.global_coins = 0;
			Globals.global_combo_count = 0;
			Globals.global_kills = 0;
			Globals.global_knock_outs = 0;
			Globals.global_score = 0;
			

			//Initialize the layers player
			layerparalax = new FlxLayer();
			layer0 = new FlxLayer();
			layer1 = new FlxLayer();
			layer2 = new FlxLayer();
			layerFX = new FlxLayer();
			layer3 = new FlxLayer();
			layerHUD = new FlxLayer();
			blur_layer = new MotionEffectLayer();
			
			////////////////////
			//Add the tilemaps
			////////////////////
			
			//Parallax tiles
			_tilemapParallax = new FlxTilemap();
			_tilemapParallax.drawIndex = 1;
			_tilemapParallax.loadMap(new Globals.global_tm_32px[Globals.global_level], ImgBgParallax, 64);
			_tilemapParallax.scrollFactor.y = 0.8;
			layerparalax.add(_tilemapParallax);	
			
			_tilemapParallax2 = new FlxTilemap();
			_tilemapParallax2.drawIndex = 1;
			_tilemapParallax2.loadMap(new Globals.global_tm_32px2[Globals.global_level], ImgBgParallax, 64);
			_tilemapParallax2.scrollFactor.y = 0.9;
			layer0.add(_tilemapParallax2);
			
			//Main
			_tilemap32 = new FlxTilemap();
			layer0.add(_tilemap32);	
			_tilemap32.collideIndex = 0;
			_tilemap32.auto = FlxTilemap.AUTO;
			_tilemap32.loadMap(new Globals.global_tm_32bg[Globals.global_level], ImgTiles32, 32);	

			_tilemap32FG = new FlxTilemap();
			layer0.add(_tilemap32FG);		
			_tilemap32FG.collideIndex = 1;
			_tilemap32FG.loadMap(new Globals.global_tm_32fg[Globals.global_level], ImgTiles32Fg, 32);



			//Create the array for the player attacks and enemy attacks
			_p_attacks = new Array;
			//Just creating a little loop to precreate some ninja stars
			for (var n:int = 0; n < 40; n += 1)
			{
				_p_attacks.push(layer1.add(new PlayerAttack(0,0,0,0)));
			}
			_enemy_p_attacks = new Array;		
			//Just creating a little loop to precreate some ninja stars
			for (var en:int = 0; en < 40; en += 1)
			{
				_enemy_p_attacks.push(layer1.add(new EnemyAttack()));
			}
			//Create array for enemies
			_enemy_ninjas = new Array;

			//Load the level
			loadLevel();
			

			
			//Add the layers to this state  -- Feel free to add more if you need
			this.add(layerparalax);  //Since this is the first layer it will be in the background
			this.add(layer0);  //Since this is the first layer it will be in the background
			this.add(layer1);  //Since this is the second layer it goes in the middle
			this.add(blur_layer);  //Motion Blur Layer
			this.add(layer2);  //The is layer which is the foreground effects
			this.add(layerFX);  //The is layer is for special effects effects
			this.add(layer3);  //The is the final layer which is the VERY foreground
			this.add(layerHUD);  //The is the final layer which is the VERY foreground
			this.add(_pause_text);
			_pause_text.visible = false;
			

			//Setup the player camera
			FlxG.follow(player,2.5);
			FlxG.followAdjust(0.0, 0.5);
			FlxG.followBounds(0,0,_tilemap32.width,_tilemap32.height);			
			//Set the width of the state kinda -- can't recall what hte flixel var is :)
			state_width = _tilemap32.width;
			

			
			//Reset timer
			_timer = Globals.global_timer_goal[Globals.global_level];
			Globals.global_timer = 0;

			//Debug info
			var tmp_debug_info:String = " ";
			_debug_text = new BFont(10, 10, tmp_debug_info, ImgLittleFont, 9, 12,33, 0, 0)
			_debug_text.visible = true;
			_debug_text.scrollFactor.x = 0;
			_debug_text.scrollFactor.y = 0;
			_debug_text.x = 15;
			_debug_text.y = 150;
			layerHUD.add(_debug_text);	
			
			//Timer
					var seconds:Number = 0;
					var minutes:Number = Math.floor(_timer / 60);
					seconds = _timer - minutes * 60;
					
					var seconds_string:String = seconds.toString();		
					var minutes_string:String = minutes.toString();
					
					if (minutes < 10)
						minutes_string = "0" + minutes.toString();
					if (seconds < 10)
						seconds_string = "0" + seconds.toString();			
			_timer_text = new BFont(220, 220, minutes_string + ":" + seconds_string, ImgBitmapFont, 16, 16, 33, 0, 0); 
			layerHUD.add(_timer_text);
			_timer_text.scrollFactor.x = _timer_text.scrollFactor.y = 0;
			if (_timer <= 0 )
				_timer_text.visible = false;
			
			//Score
			_score_text = new BFont(10, 10, "SCORE:" + Globals.global_score.toString(), ImgBitmapFont, 16, 16,33, 0, 0)
			_score_text.visible = true;
			_score_text.scrollFactor.x = _score_text.scrollFactor.y = 0;
			_score_text.x = 15;
			_score_text.y = 0;
			layerHUD.add(_score_text);

			//Combo names
			_combo_text2 = new BFont(10, 20, "COMBO:", ImgBitmapFont, 16, 16,33, 0, 0)
			_combo_text2.visible = true;
			_combo_text2.scrollFactor.x = 0;
			_combo_text2.scrollFactor.y = 0;
			_combo_text2.x = 15;
			_combo_text2.y = 15;				
			layerHUD.add(_combo_text2);
			
			_down_arrow = new FlxSprite(146, 200);
			_down_arrow.loadGraphic(ImgDownArrow, true, true, 32, 32);
			_down_arrow.addAnimation("down", [0, 1], 10);
			_down_arrow.addAnimation("up", [2, 3], 10);
			_down_arrow.scrollFactor.x = 0;
			_down_arrow.scrollFactor.y = 0;			
			_down_arrow.play("down");
			layerHUD.add(_down_arrow);	
			_down_arrow.visible = false;
			
			_safety_master = new FlxSprite(195,1084);
			_safety_master.loadGraphic(ImgSafetyMaster, true, true, 132, 160);
			layerHUD.add(_safety_master);	
			_safety_master.visible = false;
			_safety_master.alpha = 0.7;

			
		}
		//All of the game action goes here
		override public function update():void
		{
			
			

			
			//Set the old score to what the score is BEFORE any collisions happen that change it.
			//We use this to see if the score changes so we can change the text.
			//The text could constantly be updated, but that could get costly on how fast the game runs maybe?
			var old_score:uint = Globals.global_score;
			//Call the update function of the FlxState class that we are extending
			//This will update drawing and postion of the sprite --Notice super being called to 
			//call the package we are extending.
			var old_combo:int = Globals.global_combo;
			var old_combo_name:String = Globals.global_combo_name;
			
			var old_combo_count:int = Globals.global_combo_count;
			var old_kills:int = Globals.global_kills;
			var old_knock_outs:int = Globals.global_knock_outs;
			var old_coins:int = Globals.global_coins;
			
			super.update();
			
			//Reset the sound go varaible one sound at a time
			_sound_go = 0;
			//Globals.global_power += 1;
			//trace(Globals.global_power);
			//Create enemy counter  --This is just a little hack to randomly place a enemy in one place or another
			

			
			//DEATH!!!!
			if (player.health <= 0 && _game_over == false)
			{
				//Found out to the color FFFFFF for the time of 2 and call gameOver function
				FlxG.fade(0xffFFFFFF, 2, gameOver);  
				_game_over = true;
			}
			
			if (FlxG.keys.justPressed("N") )
			{
				levelComplete();
			}
	
			player.wall_jump = 0; //For the playstate tutorial
			
			//Solid blocks
			FlxG.collideArray(_block_blocks, player);
			

			
			//For jump throughs
			//FlxG.collideArray(_blocks, player);
			FlxG.collideArray(_blocks, player);
			FlxG.collideArrays(_blocks, _enemy_ninjas);
			
			//That's a wrap game complete!
			if ( rollcredits == 1)
			{
				rollcredits = 0;
				FlxG.music.fadeOut(1);
				FlxG.music2.stop();
				stop_sounds = 1;
				FlxG.fade(0xff73F17C,0.5,rollTheCredits);
			}
			
			
			//Player Door
			if ( exit_door.overlaps(player) )
			{
				if (FlxG.keys.UP && player.status == 0)
					levelComplete();
			}
			
			//Player attacks hit enemy attacks.
			FlxG.overlapArrays(_p_attacks, _enemy_p_attacks, ColAttackHitsAttack);
			//Sprite enemy attacks hit player
			FlxG.overlapArray(_enemy_p_attacks, player, ColAttackHitsPlayer);	
			
			//Sprite enemy attacks hit player
			FlxG.overlapArray(_coins, player, ColPlayerGetsCoins);			
			
			//Player hit boss
			FlxG.overlapArray(_p_attacks,boss_head,ColAttackHitsHead);
			
			//Enemies touch player
			FlxG.overlapArray(_enemy_ninjas, player, ColEnemyHitsPlayer);	
			
			//Obstacles
			FlxG.overlapArray(_obstacles, player, ColObstacleHitsPlayer);			
			
			
			//Player attacks hit enemies.
			FlxG.overlapArrays(_p_attacks, _enemy_ninjas, ColStarHitsEnemy);	
				
			//Enemies hit enemies
			FlxG.overlapArrays(_enemy_ninjas, _enemy_ninjas, ColEnemyHitsEnemy);	
			
			/////////////////////////
			//Tile Map Collisions!!!
			/////////////////////////
			//Use the tilemaps single sprite collision if not dealing with arrays
			_tilemap32.collide(player);	
			
			//When you want to check against a Array use the bellow function.
			_tilemap32.collideArray(_enemy_ninjas);
			
		
			
			for (var te:int = 0; te < _enemy_ninjas.length;++te) 
			{
				_tilemap32.collide(_enemy_ninjas[te]);	
			}
			
			FlxG.overlapArrays(_obstacles, _enemy_ninjas, ColObstacleHitsEnemy);
			
			//Obstacles
			_tilemap32.collideArray(_obstacles);
			_tilemap32.collideArray(_bouncy_blocks);	
			
			//Enemy jumper blocks
			FlxG.overlapArrays(_jumper_blocks, _enemy_ninjas, collideJumper);
			
			//Bouncy blocks
			FlxG.overlapArray(_bouncy_blocks, player,collideBouncy);
			FlxG.overlapArrays(_bouncy_blocks, _enemy_ninjas,collideBouncy);
			



			//COMBOS!
			//Update the combo and timer
			if(old_combo != Globals.global_combo)
			{
				_combo_timer = 1.2; //Set how long combos are displayed
				
				//Set current max combos
				if (Globals.global_combo > Globals.global_combo_count)
				{
					Globals.global_combo_count = Globals.global_combo;
				}
				
				//Update text here
				if (Globals.global_combo > 0)
				{
						var tmp2:String = Globals.global_combo_name + " " + bonus.toString() + "x" + Globals.global_combo.toString();
						_combo_text2.update_text(tmp2);
						_combo_text2.visible = true;	
						_combo_text2.alpha = 1.2;
						_combo_text2.scale.x = _combo_text2.scale.y = 1.2;
				}
			}		
			
			if (_combo_timer > 0)
			{
				_combo_timer -= FlxG.elapsed;
				//Alpha seems to be broken with BFont ????  Perhaps the way the sprite is rendered?
				//_combo_text2.alpha -= FlxG.elapsed;
				if (_combo_text2.scale.x > 1)
				{
					_combo_text2.scale.x -= FlxG.elapsed;
					_combo_text2.scale.y -= FlxG.elapsed;
				}
			}
			else
			{
				//Set combo text to not be visible and reset combo count
				_combo_text2.visible = false;
				Globals.global_combo = 0;
			}
		
			//Update the score IF it has changed
			if(old_score != Globals.global_score)
			{
				var score_temp:String = "SCORE:" + Globals.global_score.toString();
				_score_text.update_text(score_temp);
				
			}			
			
			if ( _timer_done == 1 || ( Globals.global_coins != old_coins &&  Globals.global_coins_goal[Globals.global_level] != 0 ) || ( Globals.global_combo_count != old_combo_count && Globals.global_combo_goal[Globals.global_level] != 0 )|| ( Globals.global_kills != old_kills && Globals.global_kills_goal[Globals.global_level] != 0 )|| ( Globals.global_knock_outs != old_knock_outs && Globals.global_knock_outs_goal[Globals.global_level] != 0 ) )
			{
				_tmp_debug_info = "";
				_debug_text.velocity.y = 0;
				
				if (_timer_done == 1)
				{
					_tmp_debug_info += "_ SPEED GOAL FAILED!\n";
					_timer_done = 0;
				}
				
				if (Globals.global_coins != old_coins)
				{
					_tmp_debug_info += "Coins:" + Globals.global_coins.toString() + " GOAL:" + Globals.global_coins_goal[Globals.global_level] + "\n";
					if ( Globals.global_coins == Globals.global_coins_goal[Globals.global_level] )
						FlxG.play(SndSuccess);
					if ( Globals.global_coins >= Globals.global_coins_goal[Globals.global_level] )
						_tmp_debug_info = "^" + _tmp_debug_info;
					//else	
						//_tmp_debug_info = "_" + _tmp_debug_info;
				}
				if (Globals.global_combo_count != old_combo_count)
				{
					_tmp_debug_info += "Max Combo:" + Globals.global_combo_count.toString() + " GOAL:" + Globals.global_combo_goal[Globals.global_level] +"\n";
					if ( Globals.global_combo_count == Globals.global_combo_goal[Globals.global_level] )
						FlxG.play(SndSuccess);
					if ( Globals.global_combo_count >= Globals.global_combo_goal[Globals.global_level] )
						_tmp_debug_info = "^" + _tmp_debug_info;
				}
				if (Globals.global_kills != old_kills)
				{
					_tmp_debug_info += "Kills:" + Globals.global_kills.toString()  + " GOAL:" + Globals.global_kills_goal[Globals.global_level] +"\n";
					if ( Globals.global_kills == Globals.global_kills_goal[Globals.global_level] )
						FlxG.play(SndSuccess);
					if ( Globals.global_kills >= Globals.global_kills_goal[Globals.global_level] )
						_tmp_debug_info = "^" + _tmp_debug_info;
				}
				if (Globals.global_knock_outs != old_knock_outs)
				{
					_tmp_debug_info += "Falls:" + Globals.global_knock_outs.toString()  + " GOAL:" + Globals.global_knock_outs_goal[Globals.global_level] +"\n";
					if ( Globals.global_knock_outs == Globals.global_knock_outs_goal[Globals.global_level] + 1 )
						FlxG.play(SndFail);
					if ( Globals.global_knock_outs >= Globals.global_knock_outs_goal[Globals.global_level] + 1 )
						_tmp_debug_info = "_" + _tmp_debug_info;
				}
				_debug_text.update_text(_tmp_debug_info);
				_debug_text.y = FlxG.height - _debug_text.height + 5;
				_goal_timer = 2;
			}
			
			if ( _goal_timer > 0 )
			{
				_goal_timer -= FlxG.elapsed;
				if ( _goal_timer <= 0 )
				{
					//_tmp_debug_info = "";
					_debug_text.velocity.y = 40;
				}
			}
			
			
			/////////////////////
			//Count down clock
			///////////////////////
			_second += FlxG.elapsed;
			
			if (_second >= 1)
			{
				//Add a second to the global clock timer for calculating achievement
				Globals.global_timer += 1;
				if (_timer)
				{
					_timer -= 1;
					
					//Create clock display in minutes and seconds
					var seconds:Number = 0;
					var minutes:Number = Math.floor(_timer / 60);
					seconds = _timer - minutes * 60;
					
					var seconds_string:String = seconds.toString();		
					var minutes_string:String = minutes.toString();
					
					if (minutes < 10)
						minutes_string = "0" + minutes.toString();
					if (seconds < 10)
						seconds_string = "0" + seconds.toString();
						
					_timer_text.update_text(minutes_string + ":" + seconds_string );
				}
				
				if (_timer == 0 && Globals.global_timer_goal[Globals.global_level] > 0 )
				{
					FlxG.play(SndFail);
					_timer_done = 1;
					_timer_text.velocity.y = 30;

				}
				
				_second = 0;
			}
			
			//Fire off any level specific conditions
			levelConditions();
			
			//Check for slime closeness effects
			if (!stop_sounds)
				slimeClose();

			

		}
		
		//Roll the credits
		private function rollTheCredits():void 
		{
			FlxG.switchState(GameComplete);
		}
		
		private function levelComplete():void
		{
			FlxG.music.fadeOut(1);
			FlxG.music2.stop();
			stop_sounds = 1;
			FlxG.switchState(Transition);
		}
		private function collideJumper(colJump:EnemyJumper, colTest:Enemy):void
		{
			if ( colTest.e_status == 0 && colTest.on_the_ground == 1 )
			{
				colTest.velocity.y = -190;
				colTest.velocity.x += colTest.velocity.x * 0.05;
			}
		}

		private function collideBouncy(colBounce:BouncyBlock, colTest:FlxSprite):void
		{
			colBounce.fixed = true;
			colTest.collideY(colBounce);
			colBounce.fixed = false;

			if (colBounce.velocity.y < 0 && colTest.y + colTest.height - 1 < colBounce.y ) 
			{
				colTest.y = colBounce.y - colTest.height;
			}

		}
		
		private function ColEnemyHitsEnemy(colEnemy:Enemy, colEnemy2:Enemy):void
		{
			//Enemies collide!
			var vel:Number = 50;
			if (colEnemy.e_status == 1 && colEnemy2.e_status == 0 && ( colEnemy.velocity.x > vel || colEnemy.velocity.x < -vel ) )
			{
				//Combo!!
				Globals.global_combo += 1;
				_combo_target = colEnemy2;
			
				//Add to the score
				bonus = 10;
				Globals.global_score  += bonus * Globals.global_combo;

				//_sound_go = 1
				//FlxG.play(SndHighYa);
				
				//Set the combo name
				Globals.global_combo_name = "Smash";
				colEnemy2.e_status = 1;
				colEnemy2.y -= 1;
				colEnemy2.velocity.y = -80;
				colEnemy2.hurt_counter = 0;
				colEnemy2.velocity.x = colEnemy.velocity.x;				
				colEnemy2.hurt(2);
				//colEnemy.velocity.x = -colEnemy.velocity.x;
				//colEnemy.velocity.x = 0;
			}
			else if (colEnemy.e_status == 0 && colEnemy2.e_status == 1 && ( colEnemy2.velocity.x > vel || colEnemy2.velocity.x < -vel ) )
			{
				//Combo!!
				Globals.global_combo += 1;
				_combo_target = colEnemy;

				//Add to the score
				bonus = 10;
				Globals.global_score  += bonus * Globals.global_combo;
				
				
				//_sound_go = 1
				//FlxG.play(SndHighYa);
				
				//Set the combo name
				Globals.global_combo_name = "Smash";
				
				colEnemy.e_status = 1;
				colEnemy.y -= 1;
				colEnemy.velocity.y = -80;
				colEnemy.hurt_counter = 0;
				colEnemy.velocity.x = colEnemy.velocity.x;				
				colEnemy.hurt(2);
				//colEnemy2.velocity.x = -colEnemy2.velocity.x;
				//colEnemy2.velocity.x = 0;
			}
		}		
		
		
		private function ColAttackHitsHead(colAttack:PlayerAttack, colHead:FlxSprite):void
		{
			if ( _boss )
			{
				if (_boss.hurt_counter <= 0)
				{
					FlxG.play(SndBigHit);
					_boss.hurt_counter = 0.5;
					Globals.global_combo += 1;
					_boss.health -= 1;
					bonus = 20;
					Globals.global_combo_name = "Boss Smack";	
					Globals.global_score  += bonus * Globals.global_combo;	
				
					if ( _boss.health < _boss.health_max * 0.8 )
						boss_head.color = 0xffFFAAAA;
					if ( _boss.health < _boss.health_max * 0.6 )
						boss_head.color = 0xffFF7777;
					if ( _boss.health < _boss.health_max * 0.4 )
						boss_head.color = 0xffFF4444;	
					if ( _boss.health < _boss.health_max * 0.2 )
						boss_head.color = 0xffFF0000;					
			
					if (  ( ( Globals.global_power[4] == 1 && Player.attack == 6 ) || ( Globals.global_power[1] == 1 && Player.attack == 2 ) || ( Globals.global_power[3] == 1 && Player.attack == 5 ) )  && player._attack_counter > 0.2)
					{
						//Do nothing					
					}
					else
					{
						colAttack.hit = 1;
						colAttack.kill();
					}
				}	
			}
		}
		
	
		//This is the function that is when a collision occurs against enemy and player
		private function ColEnemyHitsPlayer(colEnemy:Enemy, colPlayer:Player):void
		{
			if (colEnemy.hurt_counter > 0)
			{
			    //trace("CAN THROW!!!");
				if (colPlayer._throw_counter <= 0 && Player.jump == 0 && ( FlxG.keys.justPressed("C") || FlxG.keys.justPressed("K") )   && (FlxG.keys.LEFT || FlxG.keys.RIGHT ) )
				{
					//Combo!!
					Globals.global_combo += 1;
					_combo_target = colEnemy;

					//Add to the score
					bonus = 10;
					Globals.global_score  += bonus * Globals.global_combo;					
					
					//Set the combo name
					Globals.global_combo_name = "Hip Toss";				
					
					//if (_sound_go == 0)
					//{
						_sound_go = 1
						FlxG.play(SndHighYa);
					//}
					colEnemy.x = colPlayer.x;
					colEnemy.y = colPlayer.y;
					colPlayer.velocity.x = 0;
					colPlayer._attack_counter = 1.5;
					colPlayer._throw_counter = 1.5;
					colPlayer._animate_counter = 1.5;
					colEnemy.e_status = 1;
					colEnemy.velocity.y = -80;
					colEnemy.hurt_counter = 0;
					colPlayer.play("attack_t");
					if (player.facing == true)
						colEnemy.velocity.x = -200 ;
					else
						colEnemy.velocity.x = 200 ;				
					colEnemy.hurt(2 );
					Player.attack = -1; //Disable player attack while throwing
				}
			}
			
		}
		//This is the function that is when a collision occurs against ninja stars and enemies
		private function ColStarHitsEnemy(colStar:PlayerAttack, colEnemy:Enemy):void
		{
			//Kill the star - colStar HOLD the value of the collided stars id - passed through when the function is called
			colStar.hit = 1;
			
			if (  ( ( Globals.global_power[4] == 1 && Player.attack == 6 ) || ( Globals.global_power[1] == 1 && Player.attack == 2 ) || ( Globals.global_power[3] == 1 && Player.attack == 5 ) )  && player._attack_counter > 0.2)
			{
				for (var n:int = 0; n < colStar.the_enemy.length; n += 1)
				{
					if (colEnemy == colStar.the_enemy[n])
					{
						return;
					}
				}
				//Last collision = the current enemy hit...
				colStar.the_enemy.push(colEnemy);				
			}
			else
			{
				colStar.kill();
			}



			//Set the combo name
			Globals.global_combo_name = "Hit";
			
			
			//Add to the score :)
			//FlxG.score += 10;
			//Punch
			if (Player.attack == 0)
			{
				colEnemy.velocity.y = -20;
				colEnemy.velocity.x = 0;
				colEnemy.hurt_counter = 2;
				
				//Combo!!
				Globals.global_combo += 1;
				_combo_target = colEnemy;
				bonus = 10;
				Globals.global_combo_name = "Punch";

				//If the haymaker is thrown
				if (colStar.punch_count >= 2)
				{
					
					//Combo Names!
					Globals.global_combo_name = "Power Punch";
					if ( !FlxG.keys.LEFT && !FlxG.keys.RIGHT)
					{
						Globals.global_combo_name = "Triple Punch";
						bonus = 20;
					}
					
					if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 1)
					{
						Globals.global_combo_name = "Power Smash";
						bonus = 15;
					}
					if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 0)
					{
						Globals.global_combo_name = "High Five";	
						bonus = 30;
					}
					
					

					
					if (_sound_go == 0)
					{
						_sound_go = 1
						FlxG.play(SndBigHit);
					}
					
					
					
					if (colEnemy.e_status == 0)
					{
						if (player.facing == true)
							colEnemy.velocity.x = 40 ;
						else
							colEnemy.velocity.x = -40 ;	
					}
					else
					{
						if (player.facing == true)
							colEnemy.velocity.x = 180 ;
						else
							colEnemy.velocity.x = -180 ;
					}
					
					colEnemy.hurt(4 );
					colEnemy.hurt_counter = 0;
					colEnemy.e_status = 1;
					colEnemy.velocity.y = -20;
					

				}
				else //Normal Punch
				{
					if (_sound_go == 0)
					{
						_sound_go = 1;
						FlxG.play(SndHit1);
					}
					colEnemy.hurt(2 );
					
					//Uncomment to allow punches to combo up to big smacker
					//Punch count is reset when it reaches 2 and the BIG punch is thrown above
					Player.punch_count += 1;
					Player.punch_count_timer = 0.6;		
					
				}
			}
			//Jump kick
			if (Player.attack == 1)
			{
				//Combo!!
				Globals.global_combo += 1;
				_combo_target = colEnemy;
				bonus = 10;
				Globals.global_combo_name = "Jump Kick";
				
				//Combo Names!
				if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 1)
				{
					Globals.global_combo_name = "Shuffle Kick";
					bonus = 20;
				}
				if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 0)
				{
					Globals.global_combo_name = "Air Rocket";	
					bonus = 25;
				}
				
				if (_sound_go == 0)
				{
					_sound_go = 1
					FlxG.play(SndHit2);
				}
				
				if (colEnemy.e_status == 0)
				{
					if (player.facing == true)
						colEnemy.velocity.x = 40 ;
					else
						colEnemy.velocity.x = -40 ;	
				}
				else
				{
					if (player.facing == true)
						colEnemy.velocity.x = 180 ;
					else
						colEnemy.velocity.x = -180 ;
				}
				
				colEnemy.e_status = 1;
				colEnemy.velocity.y = -20;
				colEnemy.hurt_counter = 0;

				if (player.facing == true)
					player.velocity.x = -250 ;
				else
					player.velocity.x = 250 ;
					
				player.velocity.y = -160;
				
			
				colEnemy.hurt(2 );
			}
			//Slide Kick
			if (Player.attack == 2)
			{
				//Combo!!
				Globals.global_combo += 1;
				_combo_target = colEnemy;
				bonus = 10;
				//Change combo for shadow kick!
				if (Globals.global_power[1] == 1)
					Globals.global_combo_name = "Shadow Kick";
				else
					Globals.global_combo_name = "Slide Kick";
				
				if (_sound_go == 0)
				{
					_sound_go = 1;
					FlxG.play(SndHit1);
				}
				colEnemy.e_status = 0;
				colEnemy.velocity.y = -5;
				colEnemy.hurt_counter = 4;
				if (player.facing == true)
					colEnemy.velocity.x = 10;
				else
					colEnemy.velocity.x = -10;
				
				//Double damage if shadow kick!
				if (Globals.global_power[1] == 1)
					colEnemy.hurt(2);
				else
					colEnemy.hurt(1);
			}		
			//Round house
			if (Player.attack == 3)
			{
				//Combo!!
				_combo_target = colEnemy;
				Globals.global_combo += 1;
				bonus = 10;
				Globals.global_combo_name = "Round House";

				
				//Combo Names!
				//if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 1)
				//{
				//	Globals.global_combo_name = "Shuffle Kick! ";
				//}
				if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 0)
				{
					Globals.global_combo_name = "Hackey Sack";		
					bonus = 30;
				}
				
				
				if (_sound_go == 0)
				{
					_sound_go = 1
					FlxG.play(SndHit3);
				}
				
				colEnemy.e_status = 1;
				colEnemy.y -= 1;
				colEnemy.velocity.y = -190;
				if (player.facing == true)
					colEnemy.velocity.x = 5;
				else
					colEnemy.velocity.x = -5;
				colEnemy.hurt_counter = 0;
				colEnemy.hurt(3 );
			}		
			
			//Beam Attack
			if (Player.attack == 4)
			{
				//Combo!!
				_combo_target = colEnemy;
				Globals.global_combo += 1;
				bonus = 10;
				Globals.global_combo_name = "Chi Blast";

				
				//Combo Names!
				//if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 1)
				//{
				//	Globals.global_combo_name = "Shuffle Kick! ";
				//}
				if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 0)
				{
					Globals.global_combo_name = "Chi Bounce";		
					bonus = 10;
				}
				
				
				if (_sound_go == 0)
				{
					_sound_go = 1
					FlxG.play(SndHit3);
				}
				
				colEnemy.e_status = 1;
				colEnemy.y -= 1;
				colEnemy.velocity.y = -100 - Math.random() * 50;
				if (player.facing == true)
					colEnemy.velocity.x = 150 + Math.random() * 50;
				else
					colEnemy.velocity.x = -150 - Math.random() * 50;
				colEnemy.hurt_counter = 0;
				colEnemy.hurt(4 );
			}					

			//Flip Kick
			if (Player.attack == 5)
			{
				//Combo!!
				_combo_target = colEnemy;
				Globals.global_combo += 1;
				bonus = 10;
				Globals.global_combo_name = "Flip Kick";

				if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 0)
				{
					Globals.global_combo_name = "Cycle Pop";		
					bonus = 30;
				}
				
				
				if (_sound_go == 0)
				{
					_sound_go = 1
					FlxG.play(SndHit3);
				}
				
				colEnemy.e_status = 1;
				colEnemy.y -= 1;
				colEnemy.velocity.y = -190;
				colEnemy.hurt_counter = 0;
				colEnemy.hurt(5 );
			}
			
			//Screw Attack
			if (Player.attack == 6)
			{
				//Combo!!
				_combo_target = colEnemy;
				Globals.global_combo += 1;
				bonus = 10;
				Globals.global_combo_name = "Screw Kick";

				
				//Combo Names!
				//if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 1)
				//{
				//	Globals.global_combo_name = "Shuffle Kick! ";
				//}
				if ( colEnemy.e_status > 0 && colEnemy.on_the_ground == 0)
				{
					Globals.global_combo_name = "Twist Smash";		
					bonus = 30;
				}
				
				
				if (_sound_go == 0)
				{
					_sound_go = 1
					FlxG.play(SndHit3);
				}
				
				colEnemy.e_status = 1;
				colEnemy.y -= 1;
				colEnemy.velocity.y = 100 - Math.random() * 50;
				if (colEnemy.x >= player.x)
					colEnemy.velocity.x = 150 + Math.random() * 50;
				else
					colEnemy.velocity.x = -150 - Math.random() * 50;
				colEnemy.hurt_counter = 0;
				colEnemy.hurt(4 );
			}						
			
			//Add the bonus to the score
			Globals.global_score  += bonus * Globals.global_combo;	
			
		}
		

		
		private function ColObstacleHitsEnemy(colObstacle:Obstacle,colEnemy:Enemy):void
		{	
			if (colEnemy.e_status > 0 || colEnemy.hurt_counter > 0)
			{
				
				//Add to the number of kills bonus
				Globals.global_kills += 1;				
				//Combo!!
				_combo_target = colEnemy;
				Globals.global_combo += 1;
				bonus = 30;
				Globals.global_combo_name = "Big Splat";	
				Globals.global_score  += bonus * Globals.global_combo;	
			}			
			colEnemy.kill();
			colEnemy.e_status = 2;
			colEnemy.health = 0;
			//Do effects
			if (colEnemy.onScreen())
			{
				FlxG.quake(0.01, 0.2);
				explode_sound.stop();
				explode_sound = FlxG.play(SndExplode);
				for (var i:int = 0; i < 5;i+=1)
					colEnemy.createSmoke(colEnemy.x + 16, colEnemy.y + 16, Math.random() * 50 + Math.random() * -50, Math.random() * 50 + Math.random() * -50);
			}
			colEnemy.exists = false;

		}
		
		//This is the function that is when a collision occurs against obstacle and player
		private function ColObstacleHitsPlayer(colObstacle:Obstacle,colPlayer:Player):void
		{		

			if (!colPlayer.flickering() && colPlayer.status == 0 )
			{
				//Update knock downs
				Globals.global_knock_outs += 1;
				
				colPlayer.status = 1;
				colPlayer.velocity.y = -100;
				FlxG.play(SndBigHit);
				if (colObstacle.x + colObstacle.width / 2 < colPlayer.x + colPlayer.width / 2 )
					colPlayer.velocity.x = 100;
				else 
					colPlayer.velocity.x = -100;
				colPlayer.y -= 2;
				colObstacle.collision_particle.x = colPlayer.x + colPlayer.width / 2;
				colObstacle.collision_particle.y = colPlayer.y + colPlayer.height / 2;
				colObstacle.collision_particle.restart();
				
			}

		}		
		
		//This is the function that is when a collision occurs against enemy ninja stars and player		
		private function ColAttackHitsAttack(colPAttack:PlayerAttack,colEAttack:EnemyAttack):void
		{		
			//Kill the attack if it is type 1 ( the Axe )
			if (colEAttack.type == 1 && colEAttack.hit == 0)
			{
				colEAttack.acceleration.y = 200;
				colEAttack.velocity.x = -colEAttack.velocity.x;
				colEAttack.hit = 1;
			}  
		}
		
		
		//This is the function that is when a collision occurs against enemy ninja stars and player		
		private function ColAttackHitsPlayer(colAttack:EnemyAttack, colPlayer:Player):void
		{
			//If the player is not flickering and the attack hasn't hit yet
			if (!colPlayer.flickering() && colPlayer.status == 0 && colAttack.hit == 0 )
			{
				//Update knock downs
				Globals.global_knock_outs += 1;				
				colPlayer.status = 1;
				colPlayer.velocity.y = -100;
				FlxG.play(SndBigHit);
				if (colAttack.facing == 1)
					colPlayer.velocity.x = 100;
				else 
					colPlayer.velocity.x = -100;
				colPlayer.y -= 2;
				
				colAttack.collision_particle.x = colPlayer.x + colPlayer.width / 2;
				colAttack.collision_particle.y = colPlayer.y + colPlayer.height / 2;
				colAttack.collision_particle.restart();
				
			}
			//Kill the attack if it is not type 1 ( the Axe )
			if (colAttack.type != 1)
				colAttack.kill();
			else
			{
				colAttack.acceleration.y = 200;
				colAttack.velocity.x = -colAttack.velocity.x;
			}  
		}	
		
		//Player collides with coin!  YEAH!
		private function ColPlayerGetsCoins(colCoin:Coin, colPlayer:Player):void	
		{
			//Add 1 to the array that represents coins for the level
			Globals.global_coins += 1;
			
			if ( pause_state == 7 )
				_pause_text._state = 1;
			
			//Destroy the coin
			colCoin.kill();
		}
		
		public static function GiveCombo(Bonus:int,Name:String):void
		{
				Globals.global_combo += 1;
				bonus = Bonus;
				Globals.global_combo_name = Name;	
				Globals.global_score  += bonus * Globals.global_combo;	
		}		
		
		
		//Game over Mario Twin!!!  No Ice Cream for you!!!
		private function gameOver():void
		{
			//Update the high score if you got it
			if(FlxG.score > FlxG.scores[0])
				FlxG.scores[0] = FlxG.score;
			//Reset score back to zero chump				
			FlxG.score = 0;  
			//FlxG.switchState(MenuState);
		}
		
		private function playMusic(Song:Class):void
		{
			//Play the song for the background music as a loop
			FlxG.playMusic(Song, 1);
		}
		private function playMusic2(Song:Class):void
		{
			//Play the song for the background music as a loop
			FlxG.playMusic2(Song, 1);
		}		
		
		private function slimeClose():void
		{
			var close:Number = ( (acidpool.y - player.y) * 0.01 ) / 4;
			if ( close > 1)
				close = 1;
			if (close < 0)
				close = 1;
				
			if (Globals.global_level == 8 )
			{
				
				if ( FlxG.music.volume < 1)
					FlxG.music.volume += FlxG.elapsed;
				if ( FlxG.music2.volume > 0.3)
					FlxG.music2.volume -= FlxG.elapsed;
			}
			else
			{
				FlxG.music.volume = close + 0.4;
				FlxG.music2.volume = 1 - close;
			
				if (close < 1)
					FlxG.quake( (1 - close) * 0.007 , 0.1);
			}
		}
		
		
		private function loadLevel():void
		{
		
			
			/////////////////////////
			//LOAD TILE MAPPED OBJECTS	
			////////////////////////
			var MapData:String = new Globals.global_tm_objects[Globals.global_level];
			var widthInTiles:int = 0;
			var heightInTiles:int = 0;
			var c:uint;
			var r:uint;
			var cols:Array;
			var rows:Array = MapData.split("\n"); 
			var objectsArray:Array = new Array;
			//How many rows of tiles or height of tiles can be modified here
			heightInTiles = rows.length;
			//Now loop through the tiles by the number of rows
			for(r = 0; r < heightInTiles; r++)
			{
				//Split at the coma to get individual values and the commas
				cols = rows[r].split(",");
				//If you only have 1 character or less it is the end of the row just a comma
				//Go to next row
				if(cols.length <= 1)
				{
					heightInTiles--;
					continue;
				}
				//Now populate the array for enemies
				objectsArray.push(new Array());

				//New loop through the tiles width wise
				if(widthInTiles == 0)
					widthInTiles = cols.length;
				for(c = 0; c < widthInTiles; c++)
				{
					//Add to the array the true value of the object!
					objectsArray[r].push(uint(cols[c]));
				}
			}
			
			//Load player from tilemap
			for ( var ry1:int = 0; ry1 < objectsArray.length; ry1++)
			{
				for (var cx1:int = 0; cx1 < objectsArray[cx1].length; cx1++)
				{
					if (objectsArray[ry1][cx1] == 1)
					{
						player = new Player( cx1 * 32, ry1 * 32,_p_attacks) as Player;
						layer2.add(player);		
					}
				}
			}	
			//Load objects from tileset
			var tmp_block:FlxBlock;
			for ( var ry:int = 0; ry < objectsArray.length; ry++)
			{
				for (var cx:int = 0; cx < objectsArray[cx].length; cx++)
				{
					if (objectsArray[ry][cx] == 16)
					{
						_jumper_blocks.push( layer0.add(new EnemyJumper(cx * 32, ry * 32) ) );
						
					}					
					if (objectsArray[ry][cx] == 15)
					{
						_bouncy_blocks.push( layer0.add(new BouncyBlock(cx * 32, ry * 32) ) );
						
					}
					if (objectsArray[ry][cx] == 14)
					{
						tmp_block = new FlxBlock(cx * 32, ry * 32 -1, 32, 34 );
						tmp_block.loadGraphic(ImgBreakBlock);
						_block_blocks.push( layer0.add(tmp_block ) );		
					}
					if (objectsArray[ry][cx] == 13)
						_coins.push( layer2.add(new Coin(cx * 32, ry * 32 ) ) );					
					if (objectsArray[ry][cx] == 12)
						_obstacles.push( layer2.add(new Obstacle(cx * 32, ry * 32 -32, 4 ) ) );					
					if (objectsArray[ry][cx] == 11)
						_obstacles.push( layer2.add(new Obstacle(cx * 32, ry * 32 -32, 3 ) ) );						
					if (objectsArray[ry][cx] == 10)
						_obstacles.push( layer2.add(new Obstacle(cx * 32, ry * 32 -32, 2 ) ) );					
					if (objectsArray[ry][cx] == 9)
						_obstacles.push( layer2.add(new Obstacle(cx * 32, ry * 32 -32, 1 ) ) );					
					if (objectsArray[ry][cx] == 8)
						_obstacles.push( layer2.add(new Obstacle(cx * 32, ry * 32 -32, 0 ) ) );
					if (objectsArray[ry][cx] == 7)
					{
						exit_door = new PlayerDoor(cx * 32, ry * 32 -32);
						layer0.add( exit_door );					
					}
					if (objectsArray[ry][cx] == 6)
						layer0.add(new EnemyDoor3(cx * 32, ry * 32 -32, _enemy_ninjas,_enemy_p_attacks,player) );					
					if (objectsArray[ry][cx] == 5)
						layer0.add(new EnemyDoor2(cx * 32, ry * 32 -32, _enemy_ninjas,_enemy_p_attacks,player) );					
					if (objectsArray[ry][cx] == 4)
						layer0.add(new EnemyDoor(cx * 32, ry * 32 -32, _enemy_ninjas,_enemy_p_attacks,player) );
					if (objectsArray[ry][cx] == 3)
						_blocks.push( layer0.add(new FlxBlockJumpThrough(cx * 32, ry * 32, 32, 32) ) );
					if (objectsArray[ry][cx] == 2)
						_enemy_ninjas.push( layer1.add(new EnemySword(cx * 32, ry * 32, _enemy_p_attacks, player)));
				}
			}			
			//End load object tilemap		
			
			//Acid pool settings!
			acidpool_on = true;
			if (Globals.global_level == 0)
			{
				player.velocity.x = 200;
			}
			//CREATE THE ACID POOL
			acidpool = new AcidPool(0, _tilemap32.height + 200);
			layer3.add(acidpool);
			
			
			playMusic2(SndSlime);
			//Play the appropriate song
			if (Globals.global_level == 0 )
			{
				playMusic(SndLoop1);
			}
			if (Globals.global_level == 1 )
			{
				playMusic(SndLoop1);
				acidpool.velocity.y = -10;
				acidpool.glow.velocity.y = acidpool.velocity.y;				
			}				
			if (Globals.global_level == 2 )
			{
				playMusic(SndLoop2);
				acidpool.velocity.y = -10;
				acidpool.glow.velocity.y = acidpool.velocity.y;				
			}				
			if (Globals.global_level == 3 )
			{
				playMusic(SndLoop2);
				acidpool.velocity.y = -15;
				acidpool.glow.velocity.y = acidpool.velocity.y;				
			}				
			if (Globals.global_level == 4 )
			{
				playMusic(SndLoop2);
				acidpool.velocity.y = -15;
				acidpool.glow.velocity.y = acidpool.velocity.y;				
			}			
			if (Globals.global_level == 5 )
			{
				playMusic(SndLoop3);
				acidpool.velocity.y = -15;
				acidpool.glow.velocity.y = acidpool.velocity.y;	
			}
			if (Globals.global_level == 6 )
			{
				playMusic(SndLoop3);
				acidpool.velocity.y = -15;
				acidpool.glow.velocity.y = acidpool.velocity.y;	
			}				
			if (Globals.global_level == 7 )
			{
				playMusic(SndLoop3);	
				acidpool.velocity.y = -15;
				acidpool.glow.velocity.y = acidpool.velocity.y;	
			}				
			if (Globals.global_level == 8 )
			{
				playMusic(SndBossFight);
			}				
			if (Globals.global_level == 9 )
			{
				playMusic(SndLoop1);	
			}				
			if (Globals.global_level == 10 )
			{
				playMusic(SndLoop1);	
			}
			
			if (Globals.global_level == 0 )
			{
				acidpool.y = 1200;
				acidpool.velocity.y = 0;
				acidpool.glow.velocity.y = 0;
				acidpool.glow.y = 1132
			}
			//LAST BOSS FIGHT
			if (Globals.global_level == 8 )
			{
				acidpool.x += 45;
				acidpool.y = 340;
				acidpool.velocity.y = 0;
				acidpool.glow.velocity.y = 0;
				acidpool.glow.y -= 244
				acidpool.glow.x += 40
				
				_lastFG = new FlxSprite(7, 295);
				_lastFG.loadGraphic(ImgFGLast, false, false, 377, 90);
				layer3.add(_lastFG);
				_lastFG2 = new FlxSprite(22, 220);
				_lastFG2.loadGraphic(ImgFGLast2, false, false, 377, 129 );
				_lastFG2.addAnimation("normal", [0, 1, 2, 3], 8);
				_lastFG2.play("normal");
				layerparalax.add(_lastFG2);	
				
				player.velocity.y = -600;
				
				//Create the boss
				_boss = new BigBoss(80, 120, _bouncy_blocks, player,_enemy_ninjas,_enemy_p_attacks,_obstacles)
				layerparalax.add( _boss);
				
		
				
			}			
			
			
			
		}
		
		private function levelConditions():void
		{
			//Place special level cosiderations here....
			if (Globals.global_level == 0)
			{
				if ( pause_state == 0 && pause_state_go == 0)
				{
					//Swap out pause screen - it auto swaps back in FlxGame in the unpause function
					_pause_text.line1.update_text("You have penetrated the \nGOBLIN's slime tower!\nUse @ and ? or A and W to move.");
					_pause_text.line2.update_text(" ");
					_pause_text.reset(0, 300);
					_pause_text.visible = true;
					pause_state_go = 1;
					_down_arrow.visible = true;
					
				}
				if ( pause_state == 1  && pause_state_go == 0)
				{
					//Swap out pause screen - it auto swaps back in FlxGame in the unpause function
					_pause_text.line1.update_text("Press C or K to attack.\nTry new moves for big combos!\nUse direction keys + attack!");
					_pause_text.reset(0, 30);
					_pause_text.visible = true;
					pause_state_go = 1;
				}
				if ( pause_state == 2  && pause_state_go == 0)
				{
					//Swap out pause screen - it auto swaps back in FlxGame in the unpause function
					_pause_text.line1.update_text("Press X or J to Jump.\nPress $ and X or D and J\nto jump down.");
					_pause_text.reset(0, 30);
					_pause_text.visible = true;
					pause_state_go = 1;
				}
				if ( pause_state <= 3 && player.y >= 900)
				{
					if ( ( pause_state_go == 1 && pause_state < 3) || ( pause_state_go == 0 && pause_state == 3 ) )
					{
						//Swap out pause screen - it auto swaps back in FlxGame in the unpause function
						_pause_text.line1.update_text("Goblins can only knock you down.\nPress C or K to attack!\nTry to score big combos!");
						_pause_text.reset(0, 30);
						_pause_text.visible = true;
						pause_state = 3 
						pause_state_go = 1
					}
				}						
				if ( pause_state <= 4 && player.y >= 1124 )
				{
					_down_arrow.visible = false;
					if ( ( pause_state_go == 1 && pause_state < 4) || ( pause_state_go == 0 && pause_state == 4 ) )
					{
						//Swap out pause screen - it auto swaps back in FlxGame in the unpause function
						_pause_text.line1.update_text("Push a goblin into the\n slime's belly to start\n the slime flood!");
						_pause_text.reset(0, 30);
						_pause_text.visible = true;
						pause_state = 5 
						pause_state_go = 1
					}
				}	
				
				if ( pause_state == 5)
				{
					for (var en:int = 0; en < _enemy_ninjas.length; en += 1)
					{
						if (_enemy_ninjas[en].y > 1148)
						{
							
							FlxG.quake(0.01, 1);
							_pause_text._state = 1;
							if ( _one_boom == 0 )
							{
								FlxG.play(SndExplode); //HERE HERE
								_one_boom = 1;
							}
							for (var bl:int = 0; bl < _block_blocks.length; bl += 1)
							{	
								var smoke1:DarkSmoke = new DarkSmoke(_block_blocks[bl].x + 16, _block_blocks[bl].y + 16, Math.random() * 50 + Math.random() * -50, Math.random() * 50 + Math.random() * -50 );
								layer1.add(smoke1);								
								var smoke:DarkSmoke = new DarkSmoke(_block_blocks[bl].x + 16, _block_blocks[bl].y + 16, Math.random() * 50 + Math.random() * -50, Math.random() * 50 + Math.random() * -50 );
								layer1.add(smoke);
								_block_blocks[bl].kill();
							}
							acidpool.velocity.y = -1;
							acidpool.glow.velocity.y = -1;
						}
					}
				}
				
				
				if ( pause_state == 6 && pause_state_go == 0)
				{
					//Swap out pause screen - it auto swaps back in FlxGame in the unpause function
					_pause_text.line1.update_text("Quickly jump kick up the wall!\nPress C or K while jumping\n against the wall! ");
					_pause_text.reset(0, 30);
					_pause_text.visible = true;
					pause_state_go = 1;
					_down_arrow.visible = true;
					_down_arrow.play("up");
				}
				//////////////////////////////////////////////////
				//FIX ME I SHOW UP WHEN PLAYER IS DEAD!!!!
				////////////////////////////////////////////////////
				
				if ( pause_state == 7 && player.y < 870 && player.dead == false && pause_state_go == 0 )
				{
					//Swap out pause screen - it auto swaps back in FlxGame in the unpause function
					_pause_text.line1.update_text("Gather the Goblin coins!\nI will give you many goals\nand these coins are one.");
					_pause_text.reset(0, 30);
					_pause_text.visible = true;
					pause_state_go = 1;
					_down_arrow.visible = false;
				}
				if ( pause_state >= 7 && player.y < 610 && player.x > 150  && player.dead == false )
				{
					if ( ( pause_state_go == 1 && pause_state < 8 ) || ( pause_state_go == 0 && pause_state == 8 ) )
					{
					//Swap out pause screen - it auto swaps back in FlxGame in the unpause function
						_pause_text.line1.update_text("Press # or W by the door to complete\nthe level of the tower,\nand I will judge your progress.");
						_pause_text.reset(0, 30);
						pause_state = 8;
						_pause_text.visible = true;
						pause_state_go = 1;
					}
				}			

			}
		}				
		


	}
}
