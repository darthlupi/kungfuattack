package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
  
	
	
    public class EnemyDoor3 extends FlxSprite
    {
		[Embed(source = "../../data/EnemyDoor.png")] private var Img:Class;
		
		private var _count_down:Number = 1;
		private var _count_down_reset:Number = 8;
		private var _enemy_ninjas:Array = new Array;
		private var _enemy_attacks:Array = new Array;
		private var _player:Player;
		private var _type:int = 2;  //Type of enemy to create
		
		public function EnemyDoor3(X:Number,Y:Number,EnemyArray:Array,Attack:Array,P:Player):void
		{
			super(X, Y, Img);
			x = X;
			y = Y;
			loadGraphic(Img, true, false, 64, 64);
			visible = true;
			addAnimation("normal", [2], 8);
			play("normal");
			_enemy_ninjas = EnemyArray;
			_enemy_attacks = Attack;
			
			_player = P;
			
			
		}
		
		override public function update():void
        {
			super.update();
			
			//Check to create bad buys
			if (_count_down > 0)
			{
				_count_down -= FlxG.elapsed;
			}
			else if (_count_down != -100)
			{
				//Make sure it is not submerged in acid
				if (y + height < PlayState.acidpool.y - 10)
				{
					_count_down = _count_down_reset;
					if (onScreen() || _player.y < y + 150)
						createEnemy(x + 32, y + 32);
				}
			}
		}

		//This little function RESETS dead enemies or creates new ones if all dead enemies are about
		private function createEnemy( X:Number , Y:Number ):void
		{
			//Loop through the _enemy_ninjas array and check to see if they DON'T exists
			//_enemy_ninjas.length is how many indexs are in the Array - how many things added
			for(var i:uint = 0; i < _enemy_ninjas.length; i++)
				if(!_enemy_ninjas[i].exists && _enemy_ninjas[i].eType == _type)
				{
					_enemy_ninjas[i].resetObject(X, Y); //Reset that sucker if it exists!!!
					return; //Exit the function returning nothing
				} 
			if (_enemy_ninjas.length < 40)
			{
			//If the above loop can't find a dead enemy then let's make a new one shall we?
			//Make a temporary variable to store the new ninja's id
			var ninja:EnemyAxe = new EnemyAxe(X, Y, _enemy_attacks, _player);
			//Now add that ninja to the _enemy_ninja Flixel array so we reset him later if he dies!
			//Notice you have to specify which layer is used here as well.
			_enemy_ninjas.push(PlayState.layer1.add(ninja) );
			}
		}				
		
		
	}
	
}