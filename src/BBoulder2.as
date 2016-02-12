package com.KungFu
{
    import org.flixel.*;
    import flash.geom.Point;
   
   
	
	
    public class BBoulder2 extends Obstacle
    {

        [Embed(source = "../../data/BBoulder2.png")] private var Img1:Class;
		[Embed(source = "../../data/Sounds/explosion2.mp3")] private var SndExp2:Class;		
		[Embed(source = "../../data/Blood.png")] private var ImgSparks:Class;	
		
		
		//Effects
		private var _smoke:Array = new Array;
		
		private var _start_coords:Point = new Point;
		private var _angle:Number = 0;
		private var _chain:FlxSprite;
		
		
        function BBoulder2(X:Number=0, Y:Number=0, Type:int=0 ):void
        {

			super(X, Y, 0);
			loadGraphic(Img1, true, true, 72, 72);
			
			width = 68;
			height = 68;
			offset.x = 2;
			offset.y = 2;
			//Basic movement speeds
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
			angle += FlxG.elapsed * 500;
			if ( y > 280)
			{
				PlayState.acidpool.acid_splash.setXVelocity(-80,80);
				PlayState.acidpool.acid_splash.setYVelocity( -200, -160);		
				PlayState.acidpool.acid_splash.x = x + Math.random() * width;
				PlayState.acidpool.acid_splash.y = PlayState.acidpool.y;
					PlayState.acidpool.acid_splash.emit();
				if ( y > 350 )
					kill();
			}
			super.update();	
		}

		override public function hitFloor(Contact:FlxCore=null):Boolean
		{

				return false;
		}
		override public function hitWall(Contact:FlxCore=null):Boolean
		{
			return false;
		}		
		override public function hitCeiling(Contact:FlxCore=null):Boolean
		{
			
			return false;
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

 
		
	}

}