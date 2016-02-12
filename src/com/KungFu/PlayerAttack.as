package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
   
   
	
	
    public class PlayerAttack extends FlxSprite
    {
        [Embed(source = "../../data/Blood.png")] private var ImgSpark:Class;

		public  var  hit:int = 0;		
		private var _move_speed:int = 400;
		private var _jump_power:int = 800;	
		private var _spark_particle:FlxEmitter;	
		private var _exist_count:Number = 1;
		private var _x_offset:Number = 0;
		private var _y_offset:Number = 0;
		public var punch_count:int = 0;
		public var the_enemy:Array;
		
        function PlayerAttack(X:Number, Y:Number, XOffset:Number, YOffset:Number ):void
        {

			super(X,Y,null); //Width 8
			//Basic movement speeds
			maxVelocity.x = 200;  //How fast left and right it can travel
			maxVelocity.y = 200;  //How fast up and down it can travel
			//angularVelocity = 100; //How many degrees the object rotates			
            //bounding box tweaks
            width = 12;  //Width of the bounding box
            height = 12;  //Height of the bounding box
            offset.x = 4;  //Where in the sprite the bounding box starts on the X axis
            offset.y = 4;  //Where in the sprite the bounding box starts on the Y axis
			addAnimation("normal", [0]);  //Create and name and animation "normal"
			//_spark_particle = FlxG.state.add(new FlxEmitter(0,0,0,0,null,-0.2,-40,40,-40,0,-360,360,0,0,ImgSpark,3,true,PlayState.layer2)) as FlxEmitter;			
			
            facing = RIGHT;
			//The object now is removed from the render and update functions.  It returns only when reset is called.
			//We do this so we can precreate several instances of this object to help speed things up a little
			exists = false;  
        }
           
        //All of the game action goes here
        override public function update():void
        { 		
			super.update();	
			
			/*
			if ( width < 20 )
			{
				if (PlayState.player.facing == LEFT)
					_x_offset = -6
				else
					_x_offset = 23
				x = PlayState.player.x + _x_offset;
				y = PlayState.player.y + _y_offset;					
			}
			else ( width > 80 )
			{
				if (PlayState.player.facing == LEFT)
					_x_offset = -194
				else
					_x_offset = 23	
				x = PlayState.player.x + _x_offset;
				y = PlayState.player.y + _y_offset;
			}
			*/
			
				x = PlayState.player.x + _x_offset;
				y = PlayState.player.y + _y_offset;

			
			if (_exist_count > 0)
			{
				_exist_count -= FlxG.elapsed * 5;
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
			//Change to 1 if you want death particles
			if (hit == 1 && width < 20 )
			{
				var smack:Smack = new Smack(x-8, y-8, 0, 0);
				smack.facing = PlayState.player.facing;
				PlayState.layer2.add(smack);
			}
			
			
			super.kill();
		}
		
		public function resetObject(X:Number,Y:Number,XOffset:Number,YOffset:Number,PunchCount:int = 0):void 
		{
			x = X + XOffset;
			y = Y + YOffset;
			hit = 0;
			_exist_count = 1;
			dead = false;
			punch_count = PunchCount;
			exists = true;
			the_enemy = [];
			width = 12;  //Width of the bounding box
            height = 12;  //Height of the bounding box
			visible = false; //Turn back on if you want it to be visible
			_x_offset = XOffset;			
			_y_offset = YOffset;
			velocity.x = 0; //Set the left and right speed
			velocity.y = 0; //Set the left and right speed			
			play("normal"); //Play the animation
		}
		
	}

}