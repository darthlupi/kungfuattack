package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;

    public class Enemy extends FlxSprite
    {
		[Embed(source = "../../data/Sounds/hurt1.mp3")] private var SndHurt:Class;		
        [Embed(source = "../../data/EnemyDeath.png")] private var ImgBlood:Class;		
		[Embed(source = "../../data/Sounds/jump.mp3")] private var SndJump:Class;
		[Embed(source = "../../data/Sounds/explosion2.mp3")] private var SndExplode:Class;
		[Embed(source = "../../data/Sounds/enemy_swing.mp3")] private var SndAttack:Class;
		[Embed(source="../../data/Sounds/dissapate.mp3")] private var SndDis:Class;

		//Public variables
		public var e_status:int = 0; //0 is normal - 1 is rolling - 2 is getting up
		public var hurt_counter:Number = 0;	
		public var get_up_counter:Number = 0;
		public var player:FlxSprite;
		public var on_the_ground:int = 1; //In the air or not - 1 for not in the air
		public var eType:int = 0; //Unique enemy type
		
		//Publics to set
		public var attack_trigger_reload:Number = 0.4; //What to reset the trigger to 
		public var attack_duration:Number = 0.2; //How long the attack collider exists		
		public var attack_check_reload:Number = 1; //What to set the attack check timer to
		public var attack_range:Number = 50; //How far ahead to look to see if the enemy can attack
		public var search_chance:int = 97; //What is the chance to pic the right direction
		public var move_speed:int = 50;
		public var jump_power:int = 200;
		public var jumper:Boolean = false;
		public var idle_timer:Number = 20; //1 - 2 and it will be idle - Set to zero to never idle
		public var idle_timer_reload:Number = 20; //Time to reset the idle timer to		
		public var health_max:Number = 10;		
		
		//Private variables
		private var _attack_array:Array;		
		
		//Private Attack variables
		public var attack_trigger_timer:Number = 0;	 //When the attack collider is triggered
		public var attack_state:int = 0; //What state the attack is in
		public var attack_check_timer:Number = 0; //Who often to check if can attack


		private var _blood_particle:FlxEmitter;

		private var _death_count:Number = 1;
		private var _hit_floor:Boolean = false;
		
		public var jump_through:Boolean = false;
		

		
        function  Enemy(X:Number,Y:Number,Attacks:Array,ThePlayer:Player,Img:Class):void
        {
            super(X, Y,Img );
			//loadGraphic(Img, true, true, 64, 64);
			//Assign the player's object's id to the player variable.
			//We do this to be able to do checks against the player for AI.
			player = ThePlayer;
			//Health
			health = health_max;
			
			//Assign the id of the Array created in the PlayState to a private variable
			_attack_array = Attacks;
			//Basic game speeds
			maxVelocity.x = 250;
			maxVelocity.y = 280;
			//Gravity
			acceleration.y = 420;			
			//Friction
			//drag.x = 300;
            //bounding box tweaks
            width = 20;
            height = 28;
            offset.x = 22;
            offset.y = 36;
			
			/*  For some reason if you add an animation in a parent sprite it ignores the child 
			/*  request to over write it
			
			addAnimation("idle", [0, 1,2], 8);
            addAnimation("normal", [3, 4,5,6], 10);
			addAnimation("jump", [8]);
			addAnimation("attack", [9, 9, 9,10,11,12], 10);
			addAnimation("get_up", [18, 18, 18, 18, 18, 19, 19], 8);
			addAnimation("super_dead", [18]);		
			addAnimation("stopped", [0]);
			addAnimation("dead", [15,16,17,20, 15,16,17,20], 12);
			addAnimation("hurt", [13,14],10);
            */
			facing = RIGHT;
			
		
			_blood_particle = new FlxEmitter(x, y, -1.5);
			_blood_particle.createSprites(ImgBlood,6,true,PlayState.layer2);
			_blood_particle.setXVelocity(-150,150);
			_blood_particle.setYVelocity(-200,0);
			_blood_particle.setRotation( -720, -720);
			PlayState.layer2.add(_blood_particle);

			
        }
           
        //All of the game action goes here
        override public function update():void
        {

			//Handle death
			if(dead || health <= 0)
			{
				drag.x = 100;
				//Stop the rolling and kill the enemy completely
				if (velocity.x == 0 && velocity.y == 0 && _hit_floor)
				{
					dead = true;
					_death_count -= FlxG.elapsed;
					acceleration.y = 0;
					flicker(0.1);
					play("super_dead");
				}
				else
				{
					acceleration.y = 420;
					if (velocity.x > 80 || velocity.x < -80)
						motionBlur();
				}
				
				_hit_floor == false;
				
				//Check for acid pool
				acidPoolDeathCheck();

				//If no longer onscreen kill for good
				if (_death_count <= 0 || onScreen == false)
				{
					if (onScreen())
					{
						FlxG.play(SndDis);
						for (var i:int = 0; i < 5;i+=1)
							createSmoke(x + 16, y + 16, Math.random() * 50 + Math.random() * -50, Math.random() * 50 + Math.random() * -50);
					}
					//Add to the number of kills bonus
					Globals.global_kills += 1;
					exists = false;
				}
				else
					super.update();
				return;
			}
			
			//Check if acid pool has killed or not
			acidPoolDeathCheck();

			
			//Check to on the ground or not
			if (velocity.y < 0 || velocity.y > 0)
			{
				on_the_ground = 0; //Not on the ground
			}
			
			//Reset from attacking animation
			if ( finished )
			{
				if (attack_state != 0)
				{
					attack_state = 0;
				}
			}
			
			//Counter variable that counts DOWN to when you are no longer hurt
			//Plays stunned animation and freezes enemy
			if (hurt_counter > 0)
			{
				hurt_counter -= FlxG.elapsed*3;
			}
			
			//Counter variable that counts DOWN to when when
			if (idle_timer > 0)
			{
				idle_timer -= FlxG.elapsed;
			}
			else
			{
				idle_timer = Math.random() * idle_timer_reload;
			}

			//Counter variable that counts DOWN to when you can get up again
			if (get_up_counter > 0)
			{
				get_up_counter -= FlxG.elapsed;
				if (get_up_counter <= 0 && e_status == 2)
					e_status = 0;
			}			

			///////////////////////////////
			//Check for player position and move accordingly
			///////////////////////////////
			//Moving left, right, idle OR attack
			///////////////////////////////
			if (hurt_counter <= 0 && e_status == 0)
			{
				
				attack();
				if (attack_state == 0 )
					movement();
				//Idle the enemy's horizontal movemt
				if ( idle_timer > 1 && idle_timer < 2 && on_the_ground == 1 )
					velocity.x == 0;
			}
			else
			{
				//Reset attack variables
				attack_state = 0;
				attack_check_timer = attack_check_reload;
				attack_trigger_timer = attack_trigger_reload;
			}

			statusCheck();
			
			//Animate
			animation();
			
			super.update();
			
		}
		

			
		private function statusCheck():void
		{
			//Status check
			//Stop rolling by setting the drag
			if (e_status == 1) //ROLLING!  WOOT!
			{

				//If not in the air
				if (on_the_ground == 1)
				{
					drag.x = 100;
					acceleration.y = 210;
				}
				else
				{
					drag.x = 0;
					acceleration.y = 420;
				}
				//Stop rolling
				if (velocity.x == 0 && velocity.y == 0 && on_the_ground == 1)
				{
					e_status = 2;
					get_up_counter = 0.8;
					acceleration.y = 420;
				}
					
			}
			else
			{
				drag.x = 0;
			}					
		}
		
		//Attack function
		public function attack():void
		{
			//If not attacking and the check timer runs out check again
			//Attack state 0 = check to see if you can attack
			//Attack state 1 = attacking
			//Attack state 2 = attack collider is created!
			
			if ( attack_state == 0 && attack_check_timer <= 0 )
			{
				if ( (y  + height / 2) - 10  < ( player.y + player.height / 2 ) && (y  + height / 2) + 20 > ( player.y + player.height / 2 )&& Globals.getDistance(x + width / 2, y + height / 2, player.x + player.width / 2, player.y + player.height / 2) <= attack_range )
				{
					attack_state = 1; //Attack started
					play("attack");
					velocity.x = 0;
					attack_trigger_timer = attack_trigger_reload; //Set the trigger to create the attack
					
					//Set the facing toward player so the attack doesn't look stupid :)
					if ( ( player.x + player.width / 2 ) <  (x + width / 2) )
						facing = LEFT;
					else
						facing = RIGHT;
					
				}
				attack_check_timer = attack_check_reload; //Reloaded the attack check clock
			}
			else if (attack_state == 1) //Create the attack when the damage should be done
			{
				attack_trigger_timer -= FlxG.elapsed;
				if (attack_trigger_timer <= 0)
				{
					triggerAttack();
				}
			}
			else if ( attack_state == 0 ) 
			{
				attack_check_timer -= FlxG.elapsed;
			}

		}
		
		//Override in child objects to create your own attacks :)
		public function triggerAttack():void
		{
			
			if (facing == RIGHT)
				createAttack(this, x, y, 10, -5, 25, 25, attack_duration,facing);
			else
				createAttack(this, x, y, -14, -5, 25, 25, attack_duration, facing );
				FlxG.play(SndAttack);
				attack_trigger_timer = attack_trigger_reload; //Reset the attack trigger
				attack_state = 2;
		}
		
		public function animation():void
		{
			////////////////////
			//Animation
			///////////////
			if ( hurt_counter > 0 || e_status > 0 )
			{
				if (hurt_counter > 0)
					play("hurt");
				else if (e_status == 1)
					play("dead");
				else if (e_status == 2)
					play("get_up");
			}
			else
			{
				if (attack_state == 0)
				{

					if (on_the_ground == 0)
					{
						play("jump");
					}
					else
					{
						if (velocity.x == 0)
						{
							play("idle");
						}
						else
						{
							play("normal");
						}
					}
				}
			}

		}
		
		
		override public function hitCeiling(Contact:FlxCore=null):Boolean
		{
			
			if (Contact is FlxBlockJumpThrough)
				return false;

			//_hit_floor = true;
			return super.hitCeiling();
		}
		

		override public function hitFloor(Contact:FlxCore=null):Boolean
		{
			
			if (Contact is FlxBlockJumpThrough)
			{
				if (  ( !onScreen() && player.y > y ) || y + height >= Contact.y + 8 || ( player.y >= y + 32 && player.x + width/2 > x + width /2 - 30 && player.y >= y + 32 && player.x + width/2 < x + width /2 + 30) )	
				{
					on_the_ground = 0;
						return false;
				}
			}
				
			on_the_ground = 1;
			//Stop moving down if dead
			_hit_floor = true;
			
			return super.hitFloor();
		}
		
		override public function hitWall(Contact:FlxCore=null):Boolean
		{
			
			if (Contact is FlxBlockJumpThrough)
				return false;
			
			//Explode the enemy if it is dead and traveling fast enough
		    if (health <= 0 && (velocity.x > 40 || velocity.x < -40) )
			{

				if (onScreen())
				{
					//Add to the number of kills bonus
					Globals.global_kills += 1;						
					//Do effects
					FlxG.quake(0.01, 0.2);
					PlayState.explode_sound.stop();
					PlayState.explode_sound = FlxG.play(SndExplode);
					for (var i:int = 0; i < 5;i+=1)
						createSmoke(x + 16, y + 16, Math.random() * 50 + Math.random() * -50, Math.random() * 50 + Math.random() * -50);
				}
				exists = false;
			}			
			
			super.hitWall(); //Call super thus setting velocity.x = 0;
			
			//Jumping
			if(on_the_ground == 1 && e_status == 0)
			{
				//Only jump when hitting a wall if the player is in the direction you are moving in...
				if ( ( facing == LEFT &&  ( player.x + player.width / 2 ) <  (x + width / 2)  ) || ( facing == RIGHT && player.x + player.width / 2 > x + width / 2 ) )
				{
					y -= 2;
					velocity.y = -jump_power;
					
					PlayState.jump_sound.stop();
					PlayState.jump_sound = FlxG.play(SndJump);
					
					on_the_ground = 0;
					//return(true); //Do not call super which sets velocity.x = 0;
				}
			}
			

			
			return true;
			
		}
		
		private function acidPoolDeathCheck():void
		{
			if (PlayState.acidpool_on)
			{
				if (PlayState.acidpool.y < y + height)
				{
					kill();
					
					if (e_status != 0 || hurt_counter > 0)
					{
						PlayState.GiveCombo(30, "Acid Splash");
						//Add to the number of kills bonus
						Globals.global_kills += 1;
					}
					
					if (onScreen() )
					{
						PlayState.explode_sound.stop();
						PlayState.explode_sound = FlxG.play(SndExplode);
						for (var ii:int = 0; ii < 5;ii+=1)
							createSmoke(x + 16, y + 16, Math.random() * 50 + Math.random() * -50, Math.random() * 50 + Math.random() * -50);
						PlayState.acidpool.acid_splash.setXVelocity(-80,80);
						PlayState.acidpool.acid_splash.setYVelocity( -200, -160);		
						PlayState.acidpool.acid_splash.x = x + width / 2;
						PlayState.acidpool.acid_splash.y = PlayState.acidpool.y + 16;
						for (var iii:int = 0; iii < 5;iii+=1)
							PlayState.acidpool.acid_splash.emit();
						
					}
					exists = false;
				}
			}
		}		
		
		override public function kill():void 
		{
			if(dead)
				return;	
			play("dead");

            super.kill();
			dead = false;
			exists = true;
			
			if (onScreen())
			{
				PlayState.die_sound.stop();
				PlayState.die_sound = FlxG.play(SndHurt);
			}
			
		}
		public function resetObject(X:Number, Y:Number):void
		{
			exists = true;
			visible = true;
			dead = false;
			e_status = 0;
			_death_count = 1;
			acceleration.y = 420;
			alpha = 1;
			flicker(-1);
			health = health_max;
			x = X;
			y = Y;
		}
		
		private function movement():void
		{
			

			
			//Basic movement logic
			if(player.x <= x && Math.random()*100 > search_chance )
			{
				facing = LEFT;
				velocity.x = -move_speed;
			}
			else if (player.x > x && Math.random()*100 > search_chance )
			{
				facing = RIGHT;
				velocity.x = move_speed;				
			}
			//Jumping
			if( player.y < y && velocity.y == 0 && Math.random()*10 > 2  && on_the_ground == 1 && jumper == true )
			{
				velocity.y = -jump_power;
				FlxG.play(SndJump);
				on_the_ground = 0;
			}
		}
		
		
		public function createSmoke( X:Number, Y:Number, XVelocity:Number , YVelocity:Number ):void
		{
			_blood_particle.x = x + width / 2;
			_blood_particle.y = y + height / 2;
			_blood_particle.restart();
			
			var smoke:Smoke = new Smoke(X, Y, XVelocity, YVelocity);
			PlayState.layer1.add(smoke);
		}		
		
		private function motionBlur():void
		{
			PlayState.blur_layer.helper.draw(this, Math.floor(x-offset.x)+Math.floor(FlxG.scroll.x*scrollFactor.x), Math.floor(y-offset.y)+Math.floor(FlxG.scroll.y*scrollFactor.y));
		}
		
		public function createAttack(Parent:Enemy=null,X:Number=0, Y:Number=0, XOffset:Number=0, YOffset:Number=0,W:Number=12,H:Number=12,Dur:Number=0.1,Facing:uint=RIGHT,Type:int = 0,AttackImg:Class=null ):EnemyAttack
		{
			//try to recycle attacks
			for(var i:uint = 0; i < _attack_array.length; i++)
				if(!_attack_array[i].exists)
				{
					_attack_array[i].resetObject(Parent,X,Y,XOffset,YOffset,W,H,Dur,Facing,Type,AttackImg );
					return _attack_array[i];
				} 
			//if that fails just make a new one
			var the_attack:EnemyAttack = new EnemyAttack(Parent, X,Y,XOffset,YOffset,W,H,Dur,Facing,Type,AttackImg );
			the_attack.resetObject(Parent,X,Y,XOffset,YOffset,W,H,Dur)
			_attack_array.push(PlayState.layer1.add(the_attack) );	
			return the_attack;
		}		
		

		
	}

}