package com.KungFu
{
    import org.flixel.*;

    public class EnemyBow extends FlxSprite
    {

        [Embed(source = "../../data/EnemyBow.png")] private var ImgEnemy:Class;

		private var _bowing:int = 0;
		private var _bow_count:int = 0;
		private var _bow_max:int = 2;
		private var _boss:BigBoss;
		public var hurts:int = 0;
		private var _enemies:Array = new Array;
		private var _enemy_attacks:Array = new Array;
		private var _player:Player;		
		private var _type:int = 0;  //Type of enemy to create		
		
        function  EnemyBow(X:Number,Y:Number,Boss:BigBoss,Enemies:Array,Attack:Array,P:Player):void
        {
            super(X, Y);

			loadGraphic(ImgEnemy, true, true, 64, 64);

            width = 20;
            height = 28;
            offset.x = 22;
            offset.y = 36;
			
			//Objects and arrays
			_enemies = Enemies;
			_enemy_attacks = Attack;
			_player = P;			
			_boss = Boss;

            addAnimation("normal", [3,4,5,6], 10);
			addAnimation("bow", [7,8,9,10,7,8,9,10],6);
			addAnimation("hurt", [11, 12, 13, 14], 10);
			play("normal");
			
			if (Math.random() * 10 > 5)
			{
				facing = LEFT;
				velocity.x = -50;
			}
			else
			{
				facing = RIGHT;
				velocity.x = 50;
			}

        }
		
        override public function update():void
        {
			super.update();
			
			//Not bowing
			if (_bowing == 0 && hurts == 0 )
			{
				if ( x < 70 )
				{
					facing = RIGHT;
					velocity.x = 50;
				}
				if ( x + width > 370 )
				{
					facing = LEFT;
					velocity.x = -50;
				}	
				

			
				if ( Math.random() * 100 > 99 )
				{
					if (facing == RIGHT )
					{
						facing = LEFT;
						velocity.x = -50;
					}
					else
					{
						facing = RIGHT;
						velocity.x = 50;
					}
				}	
				//Start bowing
				if ( Math.random() * 1000 > 999 )
				{
					_bowing = 1;
					play("bow");
					velocity.x = 0;
					_bow_count = 0;
					_bow_max = 3 + Math.random() * 10;
					
					if (_boss.x + _boss.width / 2 > x + width / 2)
						facing = RIGHT;
					else	
						facing = LEFT;
					
				}
			}
			else if ( _bowing == 1 )//Stop bowing if finished
			{
				//Increase bow count until it reaches max then start walking again
				if (finished)
				{
					_bow_count += 1;
					//Bow a few times
					if (_bow_count >= _bow_max )
					{
						_bowing = 0;
						play("normal");
						if (facing == RIGHT )
						{
							facing = LEFT;
							velocity.x = -50;
						}
						else
						{
							facing = RIGHT;
							velocity.x = 50;
						}						
					}
				}
			}
			else
			{
				play("hurt");
				//Reset the bumbling idiot
				if ( y < 0 )
				{
					createEnemy(x, y);
					_bowing = 0;
					hurts = 0;
					x = 380;
					y = 258;
					play("normal");
					facing = LEFT;
					velocity.x = -50;
					velocity.y = 0;
				}
			}

		}
		
		//This little function RESETS dead enemies or creates new ones if all dead enemies are about
		private function createEnemy( X:Number , Y:Number ):void
		{
			//Loop through the _enemies array and check to see if they DON'T exists
			//_enemies.length is how many indexs are in the Array - how many things added
			for(var i:uint = 0; i < _enemies.length; i++)
				if(!_enemies[i].exists && _enemies[i].eType == _type)
				{
					_enemies[i].resetObject(X, Y); //Reset that sucker if it exists!!!
					return; //Exit the function returning nothing
				} 
			//If the above loop can't find a dead enemy then let's make a new one shall we?
			//Make a temporary variable to store the new ninja's id
			var ninja:EnemySword = new EnemySword(X, Y, _enemy_attacks, _player);
			//Now add that ninja to the _enemy_ninja Flixel array so we reset him later if he dies!
			//Notice you have to specify which layer is used here as well.
			_enemies.push(PlayState.layer1.add(ninja) );	
		}		
		
	}
	
	
	
}