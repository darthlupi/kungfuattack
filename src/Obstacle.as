package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
   
   
	
	
    public class Obstacle extends FlxSprite
    {

        [Embed(source = "../../data/Crusher.png")] private var Img1:Class;
		[Embed(source = "../../data/CrushBall.png")] private var Img2:Class;
		[Embed(source = "../../data/Chain.png")] private var ImgChain:Class;
		[Embed(source = "../../data/Sounds/explosion2.mp3")] private var SndExp2:Class;		
		[Embed(source = "../../data/Blood.png")] private var ImgSparks:Class;	
		
		public var type:int = 0;
		
		//Effects
		public var collision_particle:FlxEmitter;		
		private var _smoke:Array = new Array;
		
		private var _start_coords:Point = new Point;
		private var _angle:Number = 0;
		
		private var _chain:FlxSprite;
		
		
        function Obstacle(X:Number=0, Y:Number=0, Type:int=0 ):void
        {

			super(X,Y,null);
			//Basic movement speeds
			maxVelocity.x = 200;  //How fast left and right it can travel
			maxVelocity.y = 200;  //How fast up and down it can travel
			type = Type;
			
			if (type == 0)
			{
				loadGraphic(Img1, true, true, 64, 64);
				addAnimation("normal", [0], 0);
				offset.x = 0;
				offset.y = 0;
				width = 64;
				height = 64;
				velocity.y = 60;
				play("normal");
				visible = true;
				trace("true");
			}

			
			if ( type >= 1 && type <= 4 )
			{
				loadGraphic(Img2, true, true, 32, 32);
				_start_coords.x = x + 4;
				_start_coords.y = y+ 35;
				addAnimation("normal", [0], 0);
				offset.x = 2;
				offset.y = 2;
				width = 28;
				height = 28;
				velocity.y = 0;
				play("normal");
				visible = true;
				_chain = new FlxSprite(x, y, ImgChain);
				_chain.loadGraphic(ImgChain, true, false, 64, 32);
				PlayState.layer2.add(_chain);
				_chain.addAnimation("normal", [0], 0);
				_chain.play("normal");
				_chain.origin.x = 7;
				_chain.origin.y = 16;				
				_chain.x = x + 9;
				_chain.y = y + 33;	
				
				if (type > 2)
					_angle += 180;
					
			}			
			
			
			//Add particles for collisions
			collision_particle = new FlxEmitter(x, y, -0.1);
			collision_particle.createSprites(ImgSparks,16,true,PlayState.layer2);
			collision_particle.setXVelocity(-300,300);
			collision_particle.setYVelocity( -300, 300);
			collision_particle.setRotation( -720, -720);
			collision_particle.gravity = 200;
			PlayState.layer2.add(collision_particle);
			
			antialiasing = false;
			
			
	
        }
           
        //All of the game action goes here
        override public function update():void
        { 		
			
			
			if (type >= 1 && type <= 4)
			{
				if (type == 1 || type == 3)
					_angle += FlxG.elapsed * 70;
				else
					_angle -= FlxG.elapsed * 70;
				if (_angle > 360)
				   _angle -= 360;
				if (_angle < 0)
				   _angle += 360;				   
				angle = _angle;
				_chain.angle = angle;
				//var points:Point = new Point;
				var points:Point =  moveAngle( _angle, 68);
				x = _start_coords.x + points.x;
				y = _start_coords.y + points.y;
			}
			super.update();	
			
		}

		override public function hitFloor(Contact:FlxCore=null):Boolean
		{
			if (type == 0)
			{
				super.hitFloor();
				velocity.y = -60;
				if (onScreen() )
				{
					for ( var s2:int = 0; s2 < 10;s2++)
						createSmoke(x + Math.random() * 64, y + 50, 0, Math.random() * -50 );
					PlayState.exp2_snd.stop();
					PlayState.exp2_snd = FlxG.play(SndExp2);
					FlxG.quake(0.01, 0.1);
				}
				return true;
			}
			
			
			return true;
		}
		override public function hitWall(Contact:FlxCore=null):Boolean
		{
			return true;
		}		
		override public function hitCeiling(Contact:FlxCore=null):Boolean
		{
			
			if (type == 0)
			{
				super.hitFloor();
				if (onScreen() )
				{				
					for ( var s2:int = 0; s2 < 10;s2++)
						createSmoke(x + Math.random() * 64, y - 8, 0, Math.random() * 50);
					PlayState.exp2_snd.stop();
					PlayState.exp2_snd = FlxG.play(SndExp2);
					FlxG.quake(0.01, 0.1);
				}
				velocity.y = 60;
				return true;
			}			
			
			return true;
		}	
		
		override public function kill():void 
		{
		
			if(dead)
				return;	
			
			super.kill();
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

        //Move along a direction
        private function moveAngle(Angle:Number,Dist:Number):Point
        {
			var radian:Number = 0.01745 //Shorthand for PI/180 save a cycle or two :P
            var out_coords:Point = new Point( (Math.cos(Angle * radian)) * Dist, (Math.sin(Angle * radian)) * Dist );
            return out_coords;
        }		
		
	}

}