package com.KungFu
{
    import org.flixel.*;

    public class BossDead extends FlxSprite
    {

        [Embed(source = "../../data/BossDead.png")] private var ImgEnemy:Class;
		[Embed(source = "../../data/Flood.png")] private var ImgFlood:Class;
		[Embed(source = "../../data/FloodTop.png")] private var ImgFloodTop:Class;


		private var _boss:BigBoss;
		private var _obsticals:Array = new Array;
		private var _enemy_attacks:Array = new Array;
		private var _player:Player;	
		public var xoffset:Number;
		private var _end_game:int = 0;
		private var _enemies:Array = new Array();
		private var _blocks:Array = new Array();
		private var _the_end:int = 0;
		
        function BossDead(X:Number,Y:Number,Enemies:Array,Blocks:Array):void
        {
            super(X, Y);
			loadGraphic(ImgEnemy, true, true, 200, 200);
			addAnimation("normal", [0, 0, 0,0,0, 1, 1, 2, 3, 4, 5, 6, 4, 5, 6, 4, 5, 6], 6);
			play("normal");
			
			_enemies = Enemies;
			_blocks = Blocks;
			
			var flood:FlxSprite;
				flood = new FlxSprite(50, 1468  );
				flood.loadGraphic(ImgFloodTop, true, true, 320, 32);
				flood.addAnimation("normal", [0, 1, 2, 3], 10);
				flood.play("normal");
				flood.velocity.y = -400;
				PlayState.layer2.add(flood);
			for ( var i:int = 0; i < 40; i++)
			{
				flood = new FlxSprite(50, 1500+ (32*i) );
				flood.loadGraphic(ImgFlood, true, true, 320, 32);
				flood.addAnimation("normal", [0, 1, 2, 3], 10);
				flood.play("normal");
				flood.velocity.y = -400;
				PlayState.layer2.add(flood);
			}
			
        }
		
        override public function update():void
        {
			
			
			if (_curFrame > 5)
				acceleration.y = 300;
			
			if ( y > 200 )
			{
				
				PlayState.acidpool.acid_splash.setXVelocity(-80,80);
				PlayState.acidpool.acid_splash.setYVelocity( -200, -160);		
				PlayState.acidpool.acid_splash.x = x + Math.random() * width;
				PlayState.acidpool.acid_splash.y = PlayState.acidpool.y;
				PlayState.acidpool.acid_splash.emit();	
				
				FlxG.quake(0.02, 0.01);
				
				FlxG.music.volume -= FlxG.elapsed * 2; 
				FlxG.music2.volume += FlxG.elapsed * 2;
				
			}
				
			if (y >  500)
			{	
				//velocity.y = 0;
				if (_end_game == 0)
				{
					PlayState.player.velocity.y = -400;
					for (var ii:int = 0; ii < _enemies.length; ii ++)
					{
						_enemies[ii].velocity.y = -400;
					}
					for (var iii:int = 0; iii < _blocks.length; iii ++)
					{
						_blocks[iii].velocity.y = -400;
						_blocks[iii].angle = Math.random() * 360;
					}
				}
			}
			
			if (y >  1780 && _the_end == 0)
			{
				_the_end = 1;
				PlayState.rollcredits = 1;
			}
			
			super.update();
		}
		

		
	}
	
	
	
}