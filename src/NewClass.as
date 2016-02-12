package com.KungFu
{
	import org.flixel.FlxSprite;
	
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class BouncyBlock extends FlxSprite
	{
		[Embed(source = "../../data/BouncyBlock.png")] private var ImgBouncyBlock:Class;
		//MOVEMENT LIMITS
		private var m_start_pos:int
		private var m_end_pos:int
		//MOVEMENT DIRECTION
		private var m_dir:Boolean;
		//DIRECTIONAL CONSTS
		private var UP:Boolean = true;
		private var DOWN:Boolean = false;
		//DIRECTIONAL STATE
		private var m_state:int;
		private const HORIZONTAL:int = 0;
		private const VERTICAL:int = 1;
		
		
		public function BouncyBlock(X:int, Y:int, DistEnd:int = 1, DistStart:int = 0, Axis:String = "y", ReverseStart:Boolean = false) :void
		{
			super(ImgBouncyBlock, X, Y, true, false, 32, 12);
			height = 12; 
			addAnimation("idle", [0, 1], 2, true)
			play("idle");
			switch (Axis)
			{
				case "y":
				m_state = VERTICAL;
				velocity.y = 50;
				m_dir = DOWN;
				break;
				default:
				m_state = HORIZONTAL;
				velocity.x = 50;
				m_dir = RIGHT;
				break;
			}
			drag.x = drag.y = 0;
			setMoveRange(DistEnd,DistStart);
		}
		
		private function setMoveRange (DistEnd:int, DistStart:int):void
		{
			if (m_state == VERTICAL)
			{
				m_start_pos = y - DistStart;
				m_end_pos = y + DistEnd;
			}
			if (m_state == HORIZONTAL)
			{
				m_start_pos = x - DistStart;
				m_end_pos = x + DistEnd;
			}
		}
		
		override public function update ():void
		{
			if (m_state == VERTICAL)
			{
				if (y > m_end_pos && m_dir == DOWN)
				{
					flipDirection ();
				}
				if (y < m_start_pos && m_dir == UP)
				{
					flipDirection ();
				}
			}
			else if (m_state == HORIZONTAL) 
			{
				if (x > m_end_pos && m_dir == RIGHT)
				{
					flipDirection ();
				}
				if (x < m_start_pos && m_dir == LEFT)
				{
					flipDirection ();
				}
			}
			super.update();
		}
		
		public function flipDirection ():void
		{
			m_dir = !m_dir
			velocity.x *= -1;
			velocity.y *= -1;
		}
		
	}

}