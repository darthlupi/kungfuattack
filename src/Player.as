package com.KungFu
{
	import flash.filters.BlurFilter;
    import org.flixel.*;
    import flash.geom.Point;
  
	
	
    public class Player extends FlxSprite
    {
        [Embed(source = "../../data/Player.png")] private var ImgPlayer:Class;
		[Embed(source = "../../data/Blood.png")] private var ImgBlood:Class;

		[Embed(source = "../../data/Sounds/jump.mp3")] private var SndJump:Class;
		[Embed(source="../../data/Sounds/swing1.mp3")] private var SndSwing1:Class;		
		[Embed(source = "../../data/Sounds/swing2.mp3")] private var SndSwing2:Class;	
		[Embed(source = "../../data/Sounds/charge_yell.mp3")] private var SndYell:Class;
		
		[Embed(source = "../../data/Sounds/big_explosion.mp3")] private var SndBigExplosion:Class;
		
		private var _death_skull:FlxSprite;
		
		private var _charge_shot:FlxSprite; //Sprite for charge shot power up

		public var wall_jump:int = 0; //Simply used in the play state to check if the tutorial should still show for wall jumping
		
		private var _move_speed:int = 500;
		private var jump_power:int = 250;	
		private var _double_jump:int = 0;
		private var _p_attacks:Array;		
		private var _blur_counter:int = 0;
		public var _attack_counter:Number = 0;
		public var _throw_counter:Number = 0;		
		public var _animate_counter:Number = 0;
		public var _power_punch:Number = 0;
		
		
		
		private var _displacers:Array = new Array;
		
		private var _smoke:Array = new Array;
		
		//Public variables
		public static var hurt_counter:Number = 0;
		public static var attack:int = 0;
		public static var punch_count:int = 0;
		public static var punch_count_timer:Number = 0;
		public var status:int = 0;
		public static var get_up_counter:Number = 0;
		//Status variables

		private var _p_status:int = 0;
		public static var jump:int = 1;
		
		//Sounds
		public static var yell_sound:FlxSound = new FlxSound;
		
		public var jump_through:Boolean = false;

		
        function  Player(X:Number,Y:Number,Attacks:Array):void
        {
            super(X,Y,ImgPlayer);
			loadGraphic(ImgPlayer, true, true, 38, 38);
			

			
			//Assign the id of the Array created in the PlayState to a private variable
			_p_attacks = Attacks;
			//Basic game speeds
			maxVelocity.x = 100;
			maxVelocity.y = 300;
			//Set the player health
			health = 10;
			//Gravity
			acceleration.y = 420;			
			//Friction
			drag.x = 300;
            //bounding box tweaks
            width = 16;
            height = 28;
            offset.x = 12;
            offset.y = 10;
            addAnimation("normal", [3,4,5,6], 8);
			addAnimation("jump", [7]);
			addAnimation("jump_down", [8]);			
			addAnimation("attack", [2, 13, 14], 12);
			addAnimation("attack_t", [19, 20, 21,22,22,22,23,23,23,23], 12);
			addAnimation("attack_p2", [15, 15, 16, 17, 17, 18], 17);	
			addAnimation("attack_p3", [15], 0);
			addAnimation("attack_k", [24, 25, 26,27,27], 10);			
			addAnimation("attack_j", [9, 10, 11, 11, 12], 15);		
			addAnimation("attack_f", [40, 41, 42, 43], 10);	
			addAnimation("attack_d", [44,45,46,47,48,49,50,51],25);	
			addAnimation("stopped", [0,1,2],5);
			addAnimation("hurt", [28, 29], 10);
			addAnimation("rolling", [35, 30, 31, 32], 12);
			addAnimation("get_up", [33,33,33,33,33,34,34],8);
			addAnimation("dead", [36,37,38,39], 8);	

			

			
            facing = RIGHT;
			//dust_particle = FlxG.state.add(new FlxEmitter(0, 0, 0, 0, null, -1, -30, 30, -20, 20, 0, 0, 0, 0, ImgBlood, 15, true, PlayState.layer1)) as FlxEmitter;
			
			
        }
           
        //All of the game action goes here
        override public function update():void
        {
            
			if (dead)
			{
				
				if(finished) exists = false;
                else
                    super.update();
                return;
            }
			

			
			
			

			
			//Counter variable that counts DOWN to when you can attack again
			if (_attack_counter > 0)
			{
				_attack_counter -= FlxG.elapsed*3;
			}
			
			//Counter variable that counts DOWN to when you can throw again
			if (_throw_counter > 0)
			{
				_throw_counter -= FlxG.elapsed*3;
			}			
			
			//Counter variable that counts DOWN for attack animations
			if (_animate_counter > 0)
			{
				_animate_counter -= FlxG.elapsed*3;
			}			
			
			//Counter for motion blur
			if (_blur_counter > 0)
			{
				_blur_counter -= FlxG.elapsed * 3;
				if (attack == 5 && _attack_counter > 0 )
					color = 0xff0000FF
				if (attack == 6 && _attack_counter > 0 && Globals.global_power[4] == 1 )
					color = 0xff00EE00

				motionBlur();
				color = 0xffFFFFFF
			}					
			
			
			//Counter variable that counts DOWN to when you are no longer hurt
			if (hurt_counter > 0)
			{
				hurt_counter -= FlxG.elapsed*3;
			}
			
			punch_count_timer -= FlxG.elapsed;
			if (punch_count_timer <= 0)
			{
				punch_count = 0;
			}
			
			//Counter variable that counts DOWN to when you can get up again
			if (get_up_counter > 0)
			{
				get_up_counter -= FlxG.elapsed;
				
				if (get_up_counter <= 0.25)
					flicker(1);
				
				if (get_up_counter <= 0)
					status = 0;
			}	
			
			if (status == 0)
			{
				movement();
				attacks();
				maxSpeedChecker();
			}
			animation();
			statusCheck();
		
			//Check for death
			acidPoolDeathCheck();
			
			//Stop player motion if going outside of view bounds
			if ( x + ( velocity.x * FlxG.elapsed ) < 0 ||   (x + width ) + ( velocity.x * FlxG.elapsed ) > PlayState.state_width )
				velocity.x = 0;
			
			super.update();
		}
		
		private function maxSpeedChecker():void
		{
			if (attack == 2 && _attack_counter > 0.2 && Globals.global_power[1] == 1 )
			{
				maxVelocity.x = 500;
				//Throw in a little motion blur for fun!!!
				if (attack == 2 && _attack_counter > 0 && Globals.global_power[1] == 1 )
					color = 0xffFF0000

				motionBlur();
				color = 0xffFFFFFF

			}
			else
			{
				maxVelocity.x = 100;
			}
		}

		private function statusCheck():void
		{
			//Status check
			//Stop rolling by setting the drag
			if (status == 1) //ROLLING!  WOOT!
			{
				//If not in the air
				if (velocity.y == 0)
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
				if (velocity.x == 0 && velocity.y == 0)
				{
					status = 2;
					get_up_counter = 0.8;
					acceleration.y = 420;
					
				}
					
			}
			else
			{
				drag.x =300;
			}	
	}
		
		
		private function animation():void
		{
			////////////////////
			//Animation
			///////////////
			if (hurt_counter > 0 || status != 0)
			{
				if (hurt_counter > 0)
					play("hurt");
				else if (status == 1)
					play("rolling");
				else if (status == 2)
					play("get_up");
			}
			else if (_animate_counter <= 0)		
			{
				if (velocity.y != 0)
				{
					jump = 1;
					if (velocity.y < 0)
						play("jump");
					else
						play("jump_down");
				}
				else
				{
					jump = 0;
					if (velocity.x == 0)
					{
						play("stopped");
					}
					else
					{
						play("normal");
					}
				}
			}		
		}
		
		
		private function attacks():void
		{
			/////////////
			//Attacks
			////////////
			//Punches and kicks
			
			
			
			
			if(( FlxG.keys.justPressed("C") || FlxG.keys.justPressed("K") )  && _attack_counter <= 0 && _throw_counter <= 0 )
			{
				attack = -1; //Reset the attacks
				//Normal Punch
				if (jump == 0  && FlxG.keys.UP == false && FlxG.keys.DOWN == false)
				{
					FlxG.play(SndSwing1);
					attack = 0;
					
				    //Mega punch if you are walking and punching
					if (FlxG.keys.LEFT || FlxG.keys.RIGHT)
					{
						punch_count = 2;
					}
						
					if (punch_count < 2)
						play("attack");
					else
					{
						FlxG.play(SndSwing2);
						play("attack_p2")
					}
					_attack_counter = 1;
					_animate_counter = 1;
					velocity.x = 0;
					//Play attack sound
					FlxG.play(SndJump);
					if (facing == LEFT)
						throwStar( x,y,-6, 8);
					if (facing == RIGHT)
						throwStar(x, y, 23, 8);		
						
					//Reset punch count
					if (punch_count >= 2)
						punch_count = 0;
				}

				//Down Kick
				if (jump == 1 && FlxG.keys.DOWN && Globals.global_power[4] == 1  )
				{
					FlxG.play(SndSwing1);
					attack = 6;
					play("attack_d");
					punch_count = 0;
					_attack_counter = 2;
					_animate_counter = 1;					
					velocity.y += 250;
					_blur_counter = 8;
					//Play attack soundx
					FlxG.play(SndJump);
					throwStar( x,y ,10, 30);
				}	
				
				//Flip Kick
				if (jump == 1 && FlxG.keys.UP && Globals.global_power[3] == 1)
				{
					FlxG.play(SndSwing1);
					attack = 5;
					play("attack_f");
					punch_count = 0;
					_attack_counter = 1.4;
					_animate_counter = 1.3;					
					//velocity.x += velocity.x * 0.1;
					//Play attack sound
					FlxG.play(SndJump);
					_blur_counter = 8;
					var tmpstar2:PlayerAttack;
					if (facing == LEFT)
						tmpstar2 = throwStar( x,y ,-8, 0);
					if (facing == RIGHT)
						tmpstar2 = throwStar(x , y , -8, 0);
					tmpstar2.width = 32;
					tmpstar2.height = 20;
					
				}	
				
				//Jump Kick
				if ( jump == 1  && attack != 5 && attack != 6 )
				{
					FlxG.play(SndSwing1);
					attack = 1;
					play("attack_j");
					punch_count = 0;
					_attack_counter = 1;
					_animate_counter = 0.7;					
					//velocity.x += velocxcity.x * 0.1;
					//Play attack soundx
					FlxG.play(SndJump);
					if (facing == LEFT)
						throwStar( x,y ,-6, 14);
					if (facing == RIGHT)
						throwStar(x , y , 23, 14);					
				}				
				
				
				//Slide Kick --Stun move
				if (jump == 0 && FlxG.keys.DOWN && FlxG.keys.UP == false)
				{
					FlxG.play(SndSwing1);
					attack = 2;
					punch_count = 0;
					play("attack_j");
					_attack_counter = 1.5;
					_animate_counter = 0.7;	
					//Play attack sound
					FlxG.play(SndJump);
					if (facing == LEFT)
					{
						throwStar( x , y ,-6, 14);
						velocity.x = -150;
					}
					else
					{
						throwStar(x, y, 23, 14);	
						velocity.x = 150;
					}
					
					//No SHADOW KICK!
					if (Globals.global_power[1] == 1)
					{
						velocity.x = velocity.x * 2;
						_throw_counter = 2;
					}
					
				}	
				//Normal Kick
				if (jump == 0  && FlxG.keys.DOWN == false && FlxG.keys.UP)
				{
					FlxG.play(SndSwing2);
					attack = 3;
					punch_count = 0;
					play("attack_k");
					_attack_counter = 1.5;
					_animate_counter = 1.2;
					velocity.x = 0;
					//Play attack sound
					FlxG.play(SndJump);
					if (facing == LEFT)
						throwStar( x,y,-6, 5);
					if (facing == RIGHT)
						throwStar(x,y, 23, 5);					
				}						
			}		
			
			//POWER PUNCH!!!
			if (FlxG.keys.LEFT == false && FlxG.keys.RIGHT == false && ( FlxG.keys.pressed("C") || FlxG.keys.pressed("K")  )  && _attack_counter <= 0 && _throw_counter <= 0 && jump == 0 && Globals.global_power[2] == 1)
			{
				if (_power_punch == 0)
				{
					yell_sound.stop();
					yell_sound = FlxG.play(SndYell);
				}
				play("attack_p3")
				_power_punch += FlxG.elapsed;
				var tmpdisplacer:DisplaceBlob;
				_animate_counter = 0.2;		
				FlxG.quake(_power_punch * 0.01, 0.1);
				for ( var s2:int = 0; s2 < 2; s2++)
				{
					tmpdisplacer = createDiplacer(x - 10 + (Math.random() * 5) * 6, y  + Math.random() * 32, Math.random()*5-Math.random()*5, -50 - Math.random() * -50);
					if ( Math.random() * 5 > 3)
						tmpdisplacer.color = 0xffFFE0EF;
					else
						tmpdisplacer.color = 0xffFFFFFF;
				}
				if (_power_punch >= 0.7)
				{
					FlxG.quake(0.02, 0.4)
					FlxG.play(SndBigExplosion);
					attack = 4;
					_power_punch = 0;
					punch_count = 2;
					play("attack_p2")
					_attack_counter = 1;
					_animate_counter = 1;
					velocity.x = 0;
					//Play attack sound
					FlxG.play(SndSwing2);
					var tmpstar:PlayerAttack;
					FlxG.flash(0xffFFFFFF, 0.25);
					
					if (facing == LEFT)
					{
						tmpstar = throwStar( x -194 ,y, -194, 8);
						tmpstar.width = 200;
						
						_charge_shot = new ChargeShot(x - 280, y-4 )
						PlayState.layer1.add(_charge_shot  );
						//_charge_shot.velocity.x = -550;
						_charge_shot.facing = LEFT;
						
						for ( var s3:int = 0; s3 < 250; s3++)
						{
							tmpdisplacer = createDiplacer(x -  Math.random() * 280, y  + Math.random() * 5 + 4,  Math.random() * - 13 + Math.random() * 13, Math.random() * - 13 + Math.random() * 13 );						
							//if ( Math.random() * 5 > 3)
							//	tmpdisplacer.color = 0xffFFE0EF;
							//else
								tmpdisplacer.color = 0xffFFFFFF;
						}
					}
					if (facing == RIGHT)
					{
						tmpstar = throwStar(x+23, y, 23, 8);
						tmpstar.width = 200;
						
						_charge_shot = new ChargeShot(x + 15, y-4 )
						PlayState.layer1.add(_charge_shot  );
						//_charge_shot.velocity.x = 550;
						_charge_shot.facing = RIGHT;
						
						
						for ( var s4:int = 0; s4 < 250; s4++)
						{
							tmpdisplacer = createDiplacer(x + 15 + Math.random() * 280, y  + Math.random() * 5 + 4,  Math.random() * - 13 + Math.random() * 13, Math.random() * - 13 + Math.random() * 13 );	
							//if ( Math.random() * 5 > 3)
							//	tmpdisplacer.color = 0xffFFE0EF;
							//else
								tmpdisplacer.color = 0xffFFFFFF;

							
						}
					}
				}
			}
			else if (_power_punch > 0)
			{
				yell_sound.stop();
				_power_punch = 0;
			}
			
		}
		
		
		private function movement():void
		{
			///////////////////////////////
			//KEY PRESSES
			///////////////////////////////
			//Moving left and right :)
			///////////////////////////////
			if (FlxG.keys.LEFT  && _throw_counter <= 0 )
			{
				facing = LEFT;
				velocity.x -= _move_speed * FlxG.elapsed;
			}
			else if (FlxG.keys.RIGHT && _throw_counter <= 0)
			{
				facing = RIGHT;
				velocity.x += _move_speed * FlxG.elapsed;				
			}
			
			

			
			
			//Double Jumping
			if( ( FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") ) && _double_jump == 0 && Globals.global_power[0] == 1 && velocity.y != 0)
			{
				velocity.y = -150;
				FlxG.play(SndJump);
				_double_jump = 1;	
				_blur_counter = 20;
			}			
			
			//Jumping
			if(( FlxG.keys.justPressed("X") || FlxG.keys.justPressed("J") ) && velocity.y == 0)
			{
				if (FlxG.keys.DOWN && jump_through)
					velocity.y += 100;
				else
					velocity.y = -jump_power;
				FlxG.play(SndJump);
			}
			
			if( ( !FlxG.keys.X && !FlxG.keys.J )  && velocity.y < 0 && _attack_counter <= 0)
			{
				velocity.y += 8;
			}				
		}
		
		override public function hitFloor(Contact:FlxCore=null):Boolean
		{
			if (Contact is FlxBlockJumpThrough )
			{
				
				if ( (FlxG.keys.DOWN && ( FlxG.keys.pressed("X") || FlxG.keys.pressed("J")  ) ) || y + height >= Contact.y + 8 )
				{
					return false;
				}
				jump_through = true;
			}
			else
			{
				jump_through = false;
			}
			//Can double jump again...
			_double_jump = 0;
			
			
			//Drill kick
			if ( attack == 6 && _attack_counter > 1 )
			{
				velocity.y = -170;
				_attack_counter = 1;
				for ( var s1:int = 0; s1 < 5;s1++)
					createSmoke(x + 16, y + 16, Math.random() * -50, Math.random() * 50 + Math.random() * -50);
				return true;
			}		

			return super.hitFloor();
	
		}
		
		override public function hitCeiling(Contact:FlxCore=null):Boolean
		{
			if (Contact is FlxBlockJumpThrough)
				return false;
				
			//Knock player down if he gets hit by a bouncy block on the head
			if (Contact is BouncyBlock &&  ( x > Contact.x && x < Contact.x + Contact.width && y > Contact.y  ) )
			{
				//Update knock downs
				
				if ( status != 1 )
				{
					FlxG.play(SndBigExplosion);
					Globals.global_knock_outs += 1;
				}
				status = 1;
				if (Contact.x + Contact.width / 2 < x + width / 2 )
					velocity.x = 40;
				else 
					velocity.x = -40;
				return false
			}
			
			return super.hitCeiling();
		}
		
		override public function hitWall(Contact:FlxCore=null):Boolean
		{
			if (Contact is FlxBlockJumpThrough)
				return false;
				
			///Knock player down if he gets hit by a bouncy block on the head
			if (Contact is BouncyBlock &&  ( x > Contact.x && x < Contact.x + Contact.width && y > Contact.y + Contact.height ) )
			{
				//Update knock downs
				
				if ( status != 1 )
				{
					FlxG.play(SndBigExplosion);
					Globals.global_knock_outs += 1;
				}
				status = 1;
				velocity.y = -100;
				if (Contact.x + Contact.width / 2 < x + width / 2 )
					velocity.x = 40;
				else 
					velocity.x = -40;
				return false
			}
			
			super.hitWall()
			

			

			//Jump kick off of the wall!!!
			if ( ( attack == 1 && _attack_counter > 0.5 ) || ( attack == 5 && _attack_counter > 0.5 ) )
			{
				if (facing == RIGHT)
				{
					velocity.x = -220;
					for ( var s1:int = 0; s1 < 5;s1++)
						createSmoke(x + 16,y+16,Math.random() * -50, Math.random() * 50 + Math.random() * -50);
				}
				else
				{
					velocity.x = 220;
					for ( var s2:int = 0; s2 < 5;s2++)
						createSmoke(x - 16,y+16,Math.random() * 50, Math.random() * 50 + Math.random() * -50);
				}
				velocity.y = -160;
				wall_jump = 1; //Only for the playstate tutorial 
			}
			return true;
		}		

		override public function hurt(Damage:Number):void
		{
			hurt_counter = 1;
			return super.hurt(Damage);
		}		
		
		override public function kill():void 
		{
			
			if(dead)
				return;	
			PlayState.stop_sounds = 1;
			FlxG.quake(0.005, 0.35);
			FlxG.flash(0xffFFFFFF, 0.35);
            super.kill();
			FlxG.play(SndSwing2);
			FlxG.music.fadeOut(1);
			FlxG.music2.stop();
			exists = true;
			play("dead");
			//acceleration.y = 0;
			velocity.y = -120;	
			velocity.x = 0;
			finished = false;
		}		
		
		private function throwStar( X:Number,Y:Number,XOffset:Number , YOffset:Number ):PlayerAttack
		{
			//try to recycle attacks
			for(var i:uint = 0; i < _p_attacks.length; i++)
				if(!_p_attacks[i].exists)
				{
					_p_attacks[i].resetObject(X, Y + 2,XOffset, YOffset,punch_count);
					return _p_attacks[i];
				} 
			//if that fails just make a new one
			var star:PlayerAttack = new PlayerAttack(X, Y + 2, XOffset, YOffset);
			star.resetObject(X, Y,XOffset, YOffset,punch_count)
			_p_attacks.push(PlayState.layer1.add(star) );	
			return star;
		}
		
		
		private function createDiplacer( X:Number, Y:Number, XVelocity:Number , YVelocity:Number ):DisplaceBlob
		{
			//try to recycle attacks
			for(var i:uint = 0; i < _displacers.length; i++)
				if(!_displacers[i].exists)
				{
					_displacers[i].resetObject(X, Y,XVelocity, YVelocity);
					return _displacers[i];
				} 

			var d:DisplaceBlob = new DisplaceBlob(FlxG.buffer, X, Y, 4, 4, 2, 2, 2);
			d.velocity.x = XVelocity;
			d.velocity.y = YVelocity;
			_displacers.push(PlayState.layer3.add(d));
			return d;
		}			
		
		
		private function createSmoke( X:Number, Y:Number, XVelocity:Number , YVelocity:Number ):void
		{
			//try to recycle attacks
			for(var i:uint = 0; i < _smoke.length; i++)
				if(!_smoke[i].exists)
				{
					_smoke[i].resetObject(X, Y,XVelocity, YVelocity);
					return;
				} 
			
			var smoke:DarkSmoke = new DarkSmoke(X, Y, XVelocity, YVelocity);
			_smoke.push(PlayState.layer1.add(smoke));
		}	
		
		private function motionBlur():void
		{
			PlayState.blur_layer.helper.draw(this, Math.floor(x-offset.x)+Math.floor(FlxG.scroll.x*scrollFactor.x), Math.floor(y-offset.y)+Math.floor(FlxG.scroll.y*scrollFactor.y));
		}		
		
		private function acidPoolDeathCheck():void
		{
			if (PlayState.acidpool_on)
			{
				if (PlayState.acidpool.y < y + height)
				{
					
					_death_skull = new DeathSkull(160, 120);
					PlayState.layerHUD.add(_death_skull);
					PlayState.acidpool.acid_splash.setXVelocity(-80,80);
					PlayState.acidpool.acid_splash.setYVelocity( -200, -160);		
					PlayState.acidpool.acid_splash.x = x + width / 2;
					PlayState.acidpool.acid_splash.y = PlayState.acidpool.y + 16;
					for (var iii:int = 0; iii < 15;iii+=1)
						PlayState.acidpool.acid_splash.emit();
					kill();
				}
			}
		}		
		
	}

}