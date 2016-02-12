package com.titch.Outliner 
{
	import com.titch.Outliner.backend.OutLevel;
	import com.titch.Outliner.backend.OutTilemap;
	import org.flixel.FlxState;
	import org.flixel.FlxLayer;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import data.Library;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class OutGameState extends FlxState
	{
		private var level:OutLevel;
		public var player:OutPlayer;
		
		public function OutGameState() 
		{
			super();
			/*
			m_game_layer = new FlxLayer ()
			m_hud_layer = new FlxLayer ()
			main_layer = new FlxLayer ()
			m_game_layer.add(main_layer);
			add(m_game_layer);
			add(m_hud_layer);
			m_bg = new FlxSprite (null, 0, 0, false, false, 640, 480, 0xFFFFFFFF);
			add(m_bg);
			*/
			level = new OutLevel (Library.map_data, Library.img_chip, 2, 1);
			add(level);
			player = new OutPlayer()
			level.main_layer.add(player);
			FlxG.follow(player);
		}
		
		override public function update():void 
		{
			level.checkCollisions(player);
			FlxG.overlapArray(level.platforms, player, playerHitPlatform);
			super.update();
		}
		
		public function playerHitPlatform ($platform:OutPlatform, $player:OutPlayer):void
		{
			$player.onPlatform = true;
			$platform.collide($player);
			if ($platform.velocity.y > 0) 
			{
				$player.velocity.y = $platform.velocity.y;
			}
			if ($platform.y < player.y && $player.velocity.y > 0)
			{
				$platform.flipDirection();
			}
			$player.velocity.x = $platform.velocity.x;
			
		}


	}

	
}