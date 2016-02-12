package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;

    public class BigBoss extends FlxSprite
    {
	
        [Embed(source = "../../data/BossBodyAni.png")] private var Img:Class;
		[Embed(source = "../../data/BossHead.png")] private var ImgHead:Class;	
		[Embed(source = "../../data/BossHeadOverLay.png")] private var ImgHead2:Class;
		[Embed(source = "../../data/Sounds/jump.mp3")] private var SndJump:Class;
		[Embed(source = "../../data/Sounds/explosion2.mp3")] private var SndExp2:Class;		


		//Big Boss Head
		private var _boss_head:FlxSprite;
		private var _boss_head2:FlxSprite;
		//Boss State
		private var _state:int = 0;
		private var _state_count:Number = 0;
		private var _state_start:int = 2;
		
		//Public variables
		public var e_status:int = 0; //0 is normal - 1 is rolling - 2 is getting up
		public var hurt_counter:Number = 0;	
		public var get_up_counter:Number = 0;
		public var player:FlxSprite;
		public var on_the_ground:int = 1; //In the air or not - 1 for not in the air
		public var eType:int = 0; //Unique enemy type
		
		
	
		public var health_max:Number = 10;		
		
		//Private variables
		private var _attack_array:Array;
		
		private var _start_y:Number = 0;
		
		private var _throw:int = 0;
		
		private var _which_dir:int = 1;
		
		private var _blocks:Array = new Array;
		
		private var _smoke:Array = new Array;
		
		private var _worships:Array = new Array;
		
		private var _boulders:Array = new Array;
		
		private var _obsticals:Array = new Array;
		
		private var _enemies:Array = new Array;
		private var _enemy_attacks:Array = new Array;		
		private var _player:Player;
		
		private var _add_enemy:int = 0;
		private var _add_enemy1:int = 0;
		private var _add_enemy2:int = 0;

		


		
        function  BigBoss(X:Number,Y:Number,Blocks:Array,ThePlayer:Player,Enemies:Array,EnemyAttacks:Array,Obsticals:Array):void
        {
            super(X, Y,Img );
			loadGraphic(Img, true, true, 200, 200);
			//Assign the player's object's id to the player variable.
			//We do this to be able to do checks against the player for AI.
			_player = ThePlayer;
			//Health
			health = health_max;
			//End initial intro setup
			
			_enemies = Enemies;
			_enemy_attacks = EnemyAttacks;
			_obsticals = Obsticals;
			
			
			//Assign the id of the Bouncy Blocks Array created in the PlayState to a private variable
			_blocks = Blocks;
			//Basic game speeds
			maxVelocity.x = 250;
			maxVelocity.y = 280;
            width = 160;
            height = 28;
            offset.x = 20;
            offset.y = 36;

			facing = RIGHT;
			
			_start_y = Y;
			//Animations
			addAnimation("walk", [0, 1, 2, 3], 8);
			addAnimation("jump_up", [5], 8);
			addAnimation("jump_down", [6], 8);
			//                      0-2   3-4 5-6 7-8  9 10 11 12       
			addAnimation("throw", [2,2,2,7,7, 8,8,9,9,10,11,12,13,13], 10);
			play("walk");


				

			
        }
           
        //All of the game action goes here
        override public function update():void
        {
			

			//Increase the state counter
			_state_count += FlxG.elapsed;
			

			//Load state
			if (_state == 0)
			{
				_state = 1;
				//Create the boss's head
				_boss_head = new FlxSprite(x + 55, y );
				_boss_head.loadGraphic(ImgHead, true, false, 55, 67);
				_boss_head.addAnimation("normal", [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1], 5);

				_boss_head.addAnimation("throw", [0,0,0,1,1,2,3,2,3,4 , 4, 4, 4, 4 ], 10);
				_boss_head.addAnimation("hurt", [4,5], 8);
				_boss_head.play("normal");
				PlayState.boss_head = _boss_head;
				PlayState.layerparalax.add(_boss_head);
				
				_boss_head2 = new FlxSprite(x + 55, y );
				_boss_head2.loadGraphic(ImgHead2, true, false, 55, 67);
				_boss_head2.addAnimation("normal", [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1], 5);
				_boss_head2.addAnimation("throw", [0,0,0,1,1,1,2,3,2,3,4,4,1,1,0], 10);
				_boss_head2.addAnimation("hurt", [4,5], 8);
				_boss_head2.play("normal");
				PlayState.layerparalax.add(_boss_head2);
				
				
				_state_count = 0;
				_state_start = 2;
				x = 360;
				y = -60
				velocity.x = -300;
				
				//Create worshipers
				for ( var ii:int; ii < 3; ii++)
				{
					var ew:EnemyBow = new EnemyBow(Math.random() * 200 + 70, 258,this,_enemies,_enemy_attacks,_player);
					_worships.push(PlayState.layerparalax.add(ew));
				}				
				
			}
			
			//Maker sure the boss head follows
			_boss_head.x = x + 55;
			_boss_head.y = y;
			
			//Add extra worshipers
			if ( health < health_max * 0.8 && _add_enemy == 0)
			{
				_add_enemy = 1;
				var ew1:EnemyBow = new EnemyBow(360, 258,this,_enemies,_enemy_attacks,_player);
				_worships.push(PlayState.layerparalax.add(ew1));				
			}

			//Add extra worshipers
			if ( health < health_max * 0.6 && _add_enemy1 == 0)
			{
				_add_enemy1= 1;
				var ew2:EnemyBow = new EnemyBow(360, 258,this,_enemies,_enemy_attacks,_player);
				_worships.push(PlayState.layerparalax.add(ew2));				
			}
			
			//Add extra worshipers
			if ( health < health_max * 0.4 && _add_enemy2 == 0)
			{
				_add_enemy2 = 1;
				var ew3:EnemyBow = new EnemyBow(360, 258,this,_enemies,_enemy_attacks,_player);
				_worships.push(PlayState.layerparalax.add(ew3));				
			}			
			
		


			
			/////////////////////////////
			//Start the different states 
			//////////////////////////////
			
			//JUMP STATE
			if (_state == 1)
			{
				//Set gravity
				acceleration.y = 500;
				//Start jump
				if (_state_start == 0)
				{
					velocity.y = -180;
					y = _start_y - 1;
					_state_start = 1;
				}
				
				if (_state_start == 2)
				{
					velocity.y = -260;
					y = 100;
					_state_start = 1;
				}				
				
				if ( velocity.y < 0)
					play("jump_up");
				else
					play("jump_down");
				
				//Stop jumping
				if (y >= _start_y  )
				{
					y = _start_y;
					acceleration.y = 0;
					velocity.y = 0;
					
					//Shoot the blocks up in the air
					var bi:int = 0;
					if (_which_dir == 0)
						bi = 4;
					
					for (var blocki:int = bi;blocki < bi + 4 ; blocki += 1)
						_blocks[blocki].velocity.y = -380;
					
					//Send worshipers flying!
					for ( var wi:int; wi < _worships.length; wi++)
					{
						
						if (_worships[wi].x > x && _worships[wi].x + _worships[wi].width < x + width)
						{
							_worships[wi].velocity.y = - 300 - Math.random() * 100;
							_worships[wi].hurts = 1;
						}
						
						
					}
					
						
					//Effects
					PlayState.exp2_snd.stop();
					PlayState.exp2_snd = FlxG.play(SndExp2);
					FlxG.quake(0.02, 0.3);
					for ( var s2:int = 0; s2 < 25;s2++)
						createSmoke(x + Math.random() * 140 + 10, y + 170, 0, Math.random() * -50 );					
					
					//Reset the state
						
					_state = 2;
					_state_count = 0;
					_state_start = 0;
					play("walk");
					if (_which_dir == 1)
					{
						_which_dir = 0;
						velocity.x = 50;
					}
					else
					{
						_which_dir = 1;
						velocity.x = -50;
					}
				}
			}
			
			//THROW STATE
			if ( _state == 2 && _state_count > 3 )
			{
				//Start throw
				if (_state_start == 0)
				{
					velocity.x = 0;
					_state_start = 1;
					_throw = 0
				}
				
				//Boss animations
				_boss_head.play("throw");
				_boss_head2.play("throw");
				play("throw");
				_boss_head.y = y;
				if ( _curFrame > 2 )
					_boss_head.y = y + 30;		
				if ( _curFrame > 5 )
					_boss_head.y = y + 48;
				if ( _curFrame >= 9 )
					_boss_head.y = y + 30;	
				if ( _curFrame > 9 )
					_boss_head.y = y + 10;	
					
				if (_curFrame < 6 && _curFrame > 2)
					createSmoke(x + Math.random() * 140 + 10, y + 170, 0, Math.random() * -50 );
	
					
				if (_curFrame == 12 && _throw == 0)
				{
					_throw = 1;
					createBoulders(x + 25, y + 50,-82);
					createBoulders(x + 135, y + 50,+ 25);	
				}	
				//Stop throwing
				if ( finished || health > health_max * 0.5 )
				{

					_boss_head.play("normal");
					_boss_head2.play("normal");
					_boss_head.y = y ;
					_state = 1;
					_state_count = 0;
					_state_start = 0;
				}
			}

			//Hurt face :(
			if ( hurt_counter > 0)
			{

				_boss_head.x += Math.random() * 5 - Math.random() * 5;
				_boss_head.y += Math.random() * 5 - Math.random() * 5;
				hurt_counter -= FlxG.elapsed;
				_boss_head.play("hurt");
				_boss_head2.play("hurt");
			}
			else if (velocity.x != 0 )
			{
				_boss_head.play("normal");
				_boss_head2.play("normal");
			}
	
			_boss_head2.x = _boss_head.x;
			_boss_head2.y = _boss_head.y;
			
			
			//DEATH
			if ( health <= 0)
			{
				_boss_head.kill();
				_boss_head2.kill();
				var death:BossDead = new BossDead(x - offset.x, y- offset.y,_enemies,_blocks);
				PlayState.layerparalax.add(death);
				kill();
			}
			
			super.update();
			

		}
		//BOULDERS
		private function createBoulders( X:Number, Y:Number,XOFF:Number ):void
		{
			//try to recycle boulders
			for(var i:uint = 0; i < _boulders.length; i++)
				if(!_boulders[i].exists)
				{
					_boulders[i].reset(X, Y);
					_boulders[i].xoffset = XOFF;
					return;
				} 
			var boulder:BBoulder1 = new BBoulder1( X, Y, this, _obsticals, _player);
			boulder.xoffset = XOFF;
			_boulders.push(PlayState.layerparalax.add(boulder));
		}		
		
		private function createSmoke( X:Number, Y:Number, XVelocity:Number , YVelocity:Number ):void
		{
			//try to recycle s moke
			for(var i:uint = 0; i < _smoke.length; i++)
				if(!_smoke[i].exists)
				{
					_smoke[i].resetObject(X, Y,XVelocity, YVelocity);
					return;
				} 
			var smoke:DarkSmoke = new DarkSmoke(X, Y, XVelocity, YVelocity);
			_smoke.push(PlayState.layerparalax.add(smoke));
		}		

	}
		


}