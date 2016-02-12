package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;

    public class EnemySword extends Enemy
    {
		[Embed(source = "../../data/Sounds/hurt1.mp3")] private var SndHurt:Class;		
        [Embed(source = "../../data/Enemy.png")] private var ImgEnemy:Class;
        [Embed(source = "../../data/EnemyDeath.png")] private var ImgBlood:Class;		
		[Embed(source = "../../data/Sounds/jump.mp3")] private var SndJump:Class;
		[Embed(source = "../../data/Sounds/explosion2.mp3")] private var SndExplode:Class;
		[Embed(source = "../../data/Sounds/enemy_swing.mp3")] private var SndAttack:Class;
		[Embed(source="../../data/Sounds/dissapate.mp3")] private var SndDis:Class;

		
        function  EnemySword(X:Number,Y:Number,Attacks:Array,ThePlayer:Player):void
        {
            super(X, Y,Attacks,ThePlayer,ImgEnemy );

			loadGraphic(ImgEnemy, true, true, 64, 64);

            width = 20;
            height = 28;
            offset.x = 22;
            offset.y = 36;
			
			attack_duration = 0.2;
			
			eType = 0; //Unique id for enemy type
			
			health = health_max;
			
			addAnimation("idle", [0, 1,2], 8);
            addAnimation("normal", [3, 4,5,6], 10);
			addAnimation("jump", [8]);
			addAnimation("attack", [9, 9, 9,10,11,12,12], 10);
			addAnimation("get_up", [18, 18, 18, 18, 18, 19, 19], 8);
			addAnimation("super_dead", [18]);		
			addAnimation("stopped", [0]);
			addAnimation("dead", [15,16,17,20, 15,16,17,20], 12);
			addAnimation("hurt", [13,14],10);
			
			
        }

			
		
	}
}