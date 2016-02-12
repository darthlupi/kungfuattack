package com.KungFu
{
    import org.flixel.*;

    public class BBoulder1 extends FlxSprite
    {

        [Embed(source = "../../data/BBoulder.png")] private var ImgEnemy:Class;


		private var _boss:BigBoss;
		private var _obsticals:Array = new Array;
		private var _enemy_attacks:Array = new Array;
		private var _player:Player;	
		public var xoffset:Number;
		
        function  BBoulder1(X:Number,Y:Number,Boss:BigBoss,Obsticals:Array,P:Player):void
        {
            super(X, Y);

			loadGraphic(ImgEnemy, true, true, 64, 64);

            width = 20;
            height = 28;
            offset.x = 22;
            offset.y = 36;
			
			//Objects and arrays
			_obsticals = Obsticals;
			_player = P;			
			_boss = Boss;
        }

        override public function update():void
        {
			super.update();
			angle += FlxG.elapsed * 500;
			if (angle > 360)
				angle = 0;
			velocity.y = -500 - Math.random() * 150;
			
			if (y < - 100)
			{	
				var ob:BBoulder2 = new BBoulder2(_player.x + xoffset, y);
				ob.acceleration.y = 500;
				_obsticals.push(ob);
				PlayState.layer0.add(ob);
				kill();
			}
		}
	}
	
	
	
}