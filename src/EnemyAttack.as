package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
   
   
	
	
    public class EnemyAttack extends FlxSprite
    {

        [Embed(source = "../../data/Blood.png")] private var ImgSparks:Class;
        [Embed(source = "../../data/EnemyDeath.png")] private var ImgBlood:Class;
		[Embed(source = "../../data/Sounds/enemy_swing.mp3")] private var SndAttack:Class;		
		
		public  var  hit:int = 0;		
		private var _move_speed:int = 400;
		private var _jump_power:int = 800;	
		//Effects
		public var collision_particle:FlxEmitter;
				
		private var _exist_count:Number = 1;
		private var _x_offset:Number = 0;
		private var _y_offset:Number = 0;
		public var parent:Enemy;
		public var type:int = 0;
		
        function EnemyAttack(Parent:Enemy=null,X:Number=0, Y:Number=0, XOffset:Number=0, YOffset:Number=0,W:Number=12,H:Number=12,Dur:Number=0.1,Facing:uint=RIGHT,Type:int = 0,AttackImage:Class=null ):void
        {

			super(X,Y,null);
			//Basic movement speeds
			maxVelocity.x = 200;  //How fast left and right it can travel
			maxVelocity.y = 200;  //How fast up and down it can travel
			//angularVelocity = 100; //How many degrees the object rotates			
            //bounding box tweaks
            width = W;  //Width of the bounding box
            height = H;  //Height of the bounding box
			type = Type;
			facing = Facing;
			
			//_spark_particle = FlxG.state.add(new FlxEmitter(0,0,0,0,null,-0.2,-20,20,-30,30,0,0,0,0,ImgSpark,10,true,PlayState.layer2)) as FlxEmitter;			
			parent = Parent;

			//Add particles for collisions
			collision_particle = new FlxEmitter(x, y, -0.1);
			collision_particle.createSprites(ImgSparks,16,true,PlayState.layer2);
			collision_particle.setXVelocity(-300,300);
			collision_particle.setYVelocity( -300, 300);
			collision_particle.setRotation( -720, -720);
			collision_particle.gravity = 200;
			PlayState.layer2.add(collision_particle);
			
		
			//The object now is removed from the render and update functions.  It returns only when reset is called.
			//We do this so we can precreate several instances of this object to help speed things up a little
			exists =  false;  
			_exist_count = Dur;
		
        }
           
        //All of the game action goes here
        override public function update():void
        { 		
			super.update();	
			
			
			if (type == 0)
			{
				x = parent.x + _x_offset;
				y = parent.y + _y_offset;
			}
			
			if (_exist_count > 0)
			{
				_exist_count -= FlxG.elapsed;
			}
			else
			{
				kill();
			}
			
		}

		override public function hitFloor(Contact:FlxCore=null):Boolean
		{
			return true;
		}
		override public function hitWall(Contact:FlxCore=null):Boolean
		{
			return true;
		}		
		override public function hitCeiling(Contact:FlxCore=null):Boolean
		{
			return true;
		}	
		
		override public function kill():void 
		{
		
			if(dead)
				return;	
			
			super.kill();
		}
		
		public function resetObject(Parent:Enemy=null,X:Number=0, Y:Number=0, XOffset:Number=0, YOffset:Number=0,W:Number=12,H:Number=12,Dur:Number=0.1,Facing:uint=RIGHT,Type:int = 0,AttackImage:Class=null ):void
		{
			x = X + XOffset;
			y = Y + YOffset;
			parent = Parent;
			width = W;
			height = H;
			type = Type;  //Type 0 is a invisible melee attack 1 is anything else will be visible
			facing = Facing;
			if (type != 0)
			{
				if (type == 1)
				{
					loadGraphic(AttackImage, true, true, W, H);
					addAnimation("throw", [0, 1, 2, 3], 15);
					offset.x = 10;
					offset.y = 10;
					width = 11;
					height = 11;
					play("throw");
					visible = true;
				}
			}
			else
			{
				createGraphic(W, H);
				visible = false;
				addAnimation("normal", [0]);  //Create and name and animation "normal"
				play("normal");
			}
			hit = 0;
			_exist_count = 1;
			dead = false;
			exists = true;
			_exist_count = Dur;
			_x_offset = XOffset;			
			_y_offset = YOffset;
			velocity.x = 0; //Set the left and right speed
			velocity.y = 0; //Set the left and right speed	
			acceleration.y = 0;
			//play("normal"); //Play the animation
			
			//Add particles for collisions
			collision_particle = new FlxEmitter(x, y, -0.5);
			collision_particle.createSprites(ImgSparks,26,true,PlayState.layer2);
			collision_particle.setXVelocity(-100,100);
			collision_particle.setYVelocity( -100, 100);
			collision_particle.setRotation( -720, -720);
			collision_particle.gravity = 200;
			PlayState.layer2.add(collision_particle);
			
		}
		
	}

}