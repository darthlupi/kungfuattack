package com.KungFu 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.net.SharedObject;
	import org.flixel.FlxG;
	import org.flixel.FlxLayer;


	public class Globals 
	{
		//Tilemaps
		//Level 0
		[Embed(source="../../data/Maps/MapCSV_Level0_Objects.txt",mimeType="application/octet-stream")] public static var  TileMapObjects_0:Class;
		[Embed(source="../../data/Maps/MapCSV_Level0_32.txt",mimeType="application/octet-stream")] public static var  TileMap32_0:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level0_Fg_32.txt", mimeType = "application/octet-stream")] public static var  TileMap32Fg_0:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level0_parallax.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax_0:Class;
		[Embed(source="../../data/Maps/MapCSV_Level0_parallax2.txt",mimeType="application/octet-stream")] public static var  TileMapParallax2_0:Class;
		//Level 1		
		[Embed(source="../../data/Maps/MapCSV_Level2_Objects.txt",mimeType="application/octet-stream")] public static var  TileMapObjects_1:Class;
		[Embed(source="../../data/Maps/MapCSV_Level2_32.txt",mimeType="application/octet-stream")] public static var  TileMap32_1:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level2_Fg_32.txt", mimeType = "application/octet-stream")] public static var  TileMap32Fg_1:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level2_parallax.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax_1:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level2_parallax2.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax2_1:Class;
		
		[Embed(source="../../data/Maps/MapCSV_Level3_Objects.txt",mimeType="application/octet-stream")] public static var  TileMapObjects_2:Class;
		[Embed(source="../../data/Maps/MapCSV_Level3_32.txt",mimeType="application/octet-stream")] public static var  TileMap32_2:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level3_Fg_32.txt", mimeType = "application/octet-stream")] public static var  TileMap32Fg_2:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level3_parallax.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax_2:Class;
		[Embed(source="../../data/Maps/MapCSV_Level3_parallax2.txt",mimeType="application/octet-stream")] public static var  TileMapParallax2_2:Class;
		
		[Embed(source="../../data/Maps/MapCSV_Level4_Objects.txt",mimeType="application/octet-stream")] public static var  TileMapObjects_3:Class;
		[Embed(source="../../data/Maps/MapCSV_Level4_32.txt",mimeType="application/octet-stream")] public static var  TileMap32_3:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level4_Fg_32.txt", mimeType = "application/octet-stream")] public static var  TileMap32Fg_3:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level4_parallax.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax_3:Class;
		[Embed(source="../../data/Maps/MapCSV_Level4_parallax2.txt",mimeType="application/octet-stream")] public static var  TileMapParallax2_3:Class;
		
		[Embed(source="../../data/Maps/MapCSV_Level5_Objects.txt",mimeType="application/octet-stream")] public static var  TileMapObjects_4:Class;
		[Embed(source="../../data/Maps/MapCSV_Level5_32.txt",mimeType="application/octet-stream")] public static var  TileMap32_4:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level5_Fg_32.txt", mimeType = "application/octet-stream")] public static var  TileMap32Fg_4:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level5_parallax.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax_4:Class;
		[Embed(source="../../data/Maps/MapCSV_Level5_parallax2.txt",mimeType="application/octet-stream")] public static var  TileMapParallax2_4:Class;
		
		[Embed(source="../../data/Maps/MapCSV_Level1_Objects.txt",mimeType="application/octet-stream")] public static var  TileMapObjects_5:Class;
		[Embed(source="../../data/Maps/MapCSV_Level1_32.txt",mimeType="application/octet-stream")] public static var  TileMap32_5:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level1_Fg_32.txt", mimeType = "application/octet-stream")] public static var  TileMap32Fg_5:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level1_parallax.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax_5:Class;
		[Embed(source="../../data/Maps/MapCSV_Level1_parallax2.txt",mimeType="application/octet-stream")] public static var  TileMapParallax2_5:Class;
				
		[Embed(source="../../data/Maps/MapCSV_Level6_Objects.txt",mimeType="application/octet-stream")] public static var  TileMapObjects_6:Class;
		[Embed(source="../../data/Maps/MapCSV_Level6_32.txt",mimeType="application/octet-stream")] public static var  TileMap32_6:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level6_Fg_32.txt", mimeType = "application/octet-stream")] public static var  TileMap32Fg_6:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level6_parallax.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax_6:Class;
		[Embed(source="../../data/Maps/MapCSV_Level6_parallax2.txt",mimeType="application/octet-stream")] public static var  TileMapParallax2_6:Class;				
		
		[Embed(source="../../data/Maps/MapCSV_Level7_Objects.txt",mimeType="application/octet-stream")] public static var  TileMapObjects_7:Class;
		[Embed(source="../../data/Maps/MapCSV_Level7_32.txt",mimeType="application/octet-stream")] public static var  TileMap32_7:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level7_Fg_32.txt", mimeType = "application/octet-stream")] public static var  TileMap32Fg_7:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level7_parallax.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax_7:Class;
		[Embed(source="../../data/Maps/MapCSV_Level7_parallax2.txt",mimeType="application/octet-stream")] public static var  TileMapParallax2_7:Class;				

		[Embed(source="../../data/Maps/MapCSV_Level8_Objects.txt",mimeType="application/octet-stream")] public static var  TileMapObjects_8:Class;
		[Embed(source="../../data/Maps/MapCSV_Level8_32.txt",mimeType="application/octet-stream")] public static var  TileMap32_8:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level8_Fg_32.txt", mimeType = "application/octet-stream")] public static var  TileMap32Fg_8:Class;
		[Embed(source = "../../data/Maps/MapCSV_Level8_parallax.txt", mimeType = "application/octet-stream")] public static var  TileMapParallax_8:Class;
		[Embed(source="../../data/Maps/MapCSV_Level8_parallax2.txt",mimeType="application/octet-stream")] public static var  TileMapParallax2_8:Class;			

		//Tilemaps 
		public static var global_tm_objects:Array = new Array;
		public static var global_tm_32bg:Array = new Array;
		public static var global_tm_32fg:Array = new Array;
		public static var global_tm_32px:Array = new Array;
		public static var global_tm_32px2:Array = new Array;
		
		public static var global_power:Array = new Array;
		public static var global_level:int = 0; // Current level -- Set to zero for prod
		public static var global_level_unlocked:int = 0; // Current levels unlocked
 
		//Number of kills
		public static var global_kills:int = 0;  //Number of kills
		public static var global_level_kills:Array = new Array; // Current high kills for the level		
		
		//Number of combos
		public static var global_combo:int = 0; //Current combo
		public static var global_combo_count:int = 0; //Current high combo
		public static var global_level_combo:Array = new Array; // Current high combo for the level
		
		//The score gathered on the level and scores per level
		public static var global_score:int = 0;  //Current Score for the level
		public static var global_level_score:Array = new Array; // Current high score for the level		
		
		//Number of coins collected per level
		public static var global_coins:int = 0;
		public static var global_level_coins:Array = new Array; //Array per level coins collected
		
		//Timer
		public static var global_timer:Number = 0;
		public static var global_level_timer:Array = new Array; //Array to track times
		
		//How many times the player is knocked down
		public static var global_knock_outs:int = 0; // Number of knock outs
		public static var global_level_knock_outs:Array = new Array; //Array to track knock outs per level
		
		public static var global_combo_name:String = " "; //Current combo name
		
		public static var global_tmp_buffer:BitmapData = new BitmapData(FlxG.width, FlxG.height);
		
		//Level Goals
		public static var global_coins_goal:Array = new Array;
		public static var global_kills_goal:Array = new Array;
		public static var global_knock_outs_goal:Array = new Array;
		public static var global_timer_goal:Array = new Array;
		public static var global_combo_goal:Array = new Array;
		public static var global_score_goal:Array = new Array;
		
		//Save data
		public static var global_save_so:SharedObject = SharedObject.getLocal("save_data");
		
		public function Globals() 
		{
						//Power levels...
			global_power = []; //RESET
			global_power.push(1) //Double jump;
			global_power.push(1) //Slide Kick;
			global_power.push(1) //Power Punch;
			global_power.push(1) //Flip Kick;
			global_power.push(1) //Eagle Dive;
		}
		
		
		public static function loadGame():void
		{
			global_level_coins = global_save_so.data.global_level_coins;
			global_level_score = global_save_so.data.global_level_score; //Save levels high scores
			global_level_combo = global_save_so.data.global_level_combo;
			global_level_kills = global_save_so.data.global_level_kills;
			global_level_knock_outs = global_save_so.data.global_level_knock_outs;
			global_level_timer = global_save_so.data.global_level_timer;
			global_level_unlocked = global_save_so.data.global_level_unlocked ;
			global_power = global_save_so.data.global_power;
			//global_save_so.flush();
		}
		
		public static function saveGame():void
		{
			global_save_so.data.global_level_coins = global_level_coins;
			global_save_so.data.global_level_score = global_level_score; //Save levels high scores
			global_save_so.data.global_level_combo = global_level_combo;
			global_save_so.data.global_level_kills = global_level_kills;
			global_save_so.data.global_level_knock_outs = global_level_knock_outs;
			global_save_so.data.global_level_timer = global_level_timer;
			global_save_so.data.global_level_unlocked = global_level_unlocked;
			global_save_so.data.global_power = global_power;
			global_save_so.data.game_saved = 1;
			global_save_so.flush();
		}
		
		
		public static function setStartStats(Reset:Boolean):void
		{
			//This is for public global variables :)
			
			
			//Reset the arrays for the stats
			if (Reset)
			{
				global_level_coins = [];
				global_level_score = [];
				global_level_combo = [];
				global_level_kills = [];
				global_level_knock_outs = [];
				global_level_timer = [];
				global_power = [];
			}
			
			
			//Fill the stats arrays for each level with 0's :)
			for (var c:int = 0; c < 10; c++)
			{
				//Zero out the stats arrays stored for levels
				global_level_coins.push(0);
				global_level_score.push(0);
				global_level_combo.push(0);
				global_level_kills.push(0);
				global_level_knock_outs.push(999);
				global_level_timer.push(9999);
				
				//Power levels...
				global_power.push(0);

				//////////////////////
				//LOAD LEVEL TILEMAPS
				//////////////////////
				//LEVEL 1
				global_tm_objects.push(TileMapObjects_0);
				global_tm_32bg.push(TileMap32_0);
				global_tm_32fg.push(TileMap32Fg_0);
				global_tm_32px.push(TileMapParallax_0);
				global_tm_32px2.push(TileMapParallax2_0);	
				//LEVEL 2
				global_tm_objects.push(TileMapObjects_1);
				global_tm_32bg.push(TileMap32_1);
				global_tm_32fg.push(TileMap32Fg_1);
				global_tm_32px.push(TileMapParallax_1);
				global_tm_32px2.push(TileMapParallax2_1);		
				//LEVEL 3
				global_tm_objects.push(TileMapObjects_2);
				global_tm_32bg.push(TileMap32_2);
				global_tm_32fg.push(TileMap32Fg_2);
				global_tm_32px.push(TileMapParallax_2);
				global_tm_32px2.push(TileMapParallax2_2);
				//LEVEL 4
				global_tm_objects.push(TileMapObjects_3);
				global_tm_32bg.push(TileMap32_3);
				global_tm_32fg.push(TileMap32Fg_3);
				global_tm_32px.push(TileMapParallax_3);
				global_tm_32px2.push(TileMapParallax2_3);	
				//LEVEL 5
				global_tm_objects.push(TileMapObjects_4);
				global_tm_32bg.push(TileMap32_4);
				global_tm_32fg.push(TileMap32Fg_4);
				global_tm_32px.push(TileMapParallax_4);
				global_tm_32px2.push(TileMapParallax2_4);					
				//LEVEL 6
				global_tm_objects.push(TileMapObjects_5);
				global_tm_32bg.push(TileMap32_5);
				global_tm_32fg.push(TileMap32Fg_5);
				global_tm_32px.push(TileMapParallax_5);
				global_tm_32px2.push(TileMapParallax2_5);	
				//LEVEL 7
				global_tm_objects.push(TileMapObjects_6);
				global_tm_32bg.push(TileMap32_6);
				global_tm_32fg.push(TileMap32Fg_6);
				global_tm_32px.push(TileMapParallax_6);
				global_tm_32px2.push(TileMapParallax2_6);					
				//LEVEL 8
				global_tm_objects.push(TileMapObjects_7);
				global_tm_32bg.push(TileMap32_7);
				global_tm_32fg.push(TileMap32Fg_7);
				global_tm_32px.push(TileMapParallax_7);
				global_tm_32px2.push(TileMapParallax2_7);	
				//LEVEL 9
				global_tm_objects.push(TileMapObjects_8);
				global_tm_32bg.push(TileMap32_8);
				global_tm_32fg.push(TileMap32Fg_8);
				global_tm_32px.push(TileMapParallax_8);
				global_tm_32px2.push(TileMapParallax2_8);					
				
			}
			
			//Be sure to save freshly reset variables
			if (Reset)
				{
					global_level_unlocked = 0;
					saveGame();
					//Set the game_save variable to zero so that we know the game has been UNSAVED
					global_save_so.data.game_saved = 0;
				}
				
			//If the game_saved save variable is set then load the saved game :)		
			if (global_save_so.data.game_saved )
				{
					loadGame();
				}
		}
		
		
		public static function setGoals():void
		{
			//Set the challenges for the levels

			//Level 0
			global_coins_goal.push(2);
			global_kills_goal.push(2);
			global_knock_outs_goal.push(2);
			global_timer_goal.push(0);
			global_combo_goal.push(0);
			global_score_goal.push(0);
			//Level 1
			global_coins_goal.push(8);
			global_kills_goal.push(0);
			global_knock_outs_goal.push(1);
			global_timer_goal.push(0);
			global_combo_goal.push(25);
			global_score_goal.push(0);			
			//Level 2
			global_coins_goal.push(10);
			global_kills_goal.push(0);
			global_knock_outs_goal.push(2);
			global_timer_goal.push(80);
			global_combo_goal.push(0);
			global_score_goal.push(0);	
			//Level 3
			global_coins_goal.push(11);
			global_kills_goal.push(20);
			global_knock_outs_goal.push(0);
			global_timer_goal.push(0);
			global_combo_goal.push(30);
			global_score_goal.push(0);	
			//Level 4
			global_coins_goal.push(15);
			global_kills_goal.push(12);
			global_knock_outs_goal.push(0);
			global_timer_goal.push(120);
			global_combo_goal.push(0);
			global_score_goal.push(0);	
			//Level 5
			global_coins_goal.push(9);
			global_kills_goal.push(20);
			global_knock_outs_goal.push(2);
			global_timer_goal.push(0);
			global_combo_goal.push(0);
			global_score_goal.push(0);				
			//Level 6
			global_coins_goal.push(14);
			global_kills_goal.push(0);
			global_knock_outs_goal.push(3);
			global_timer_goal.push(0);
			global_combo_goal.push(20);
			global_score_goal.push(0);	
			//Level 7
			global_coins_goal.push(8);
			global_kills_goal.push(25);
			global_knock_outs_goal.push(2);
			global_timer_goal.push(0);
			global_combo_goal.push(0);
			global_score_goal.push(0);
			//Level 8
			global_coins_goal.push(0);
			global_kills_goal.push(15);
			global_knock_outs_goal.push(5);
			global_timer_goal.push(120);
			global_combo_goal.push(0);
			global_score_goal.push(0);					
		}
		
		//Move along a direction
        public function moveAngle(X:Number,Y:Number,Angle:Number,Dist:Number):Point
        {
			var radian:Number = 0.01745 //Shorthand for PI/180 save a cycle or two :P
            var out_coords:Point = new Point( (Math.cos(Angle * radian)) * Dist, (Math.sin(Angle * radian)) * Dist );
            return out_coords;
        }
		//Find the distance between two points
		public static function getDistance(X:Number, Y:Number, X2:Number, Y2:Number):Number
		{
			var XX:Number = (X2 - X);
			var YY:Number = (Y2 - Y);
			return Math.sqrt( XX * XX ) + Math.sqrt(YY * YY);
		}
        //Find direction to point
        private function getAngle(X:Number,Y:Number,X2:Number,Y2:Number):Number
        {
            var out_angle:Number = 0;
            var radian:Number = 0.01745 //Shorthand for PI/180 save a cycle or two :P
            //Calculate angle (in radians):
            var angle_radians:Number = Math.atan2(Y-Y2,X2-X )
            // Transform the radians to degrees.
            var angle_degrees:Number = angle_radians / radian
            // If the angle is negative, make it positive.
            if (angle_degrees < 0)
                angle_degrees += 360;
            if (angle_degrees > 360)
                angle_degrees -= 360;				
            //Returns first radians and degrees
            out_angle = angle_degrees;
            return out_angle;
        }    		
		
	}
	
}