package com.KungFu
{
import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
	
import org.flixel.FlxG;
import org.flixel.FlxLayer;
import org.flixel.FlxSprite;
	
public class MotionEffectLayer extends FlxLayer
{
	public  var helper:FlxSprite;
	
	public function MotionEffectLayer():void
	{
		super();
		
		// create a sprite that will act as an uncleared buffer for the bullets
		helper = new FlxSprite();
		helper.createGraphic(FlxG.width, FlxG.height, 0x00000000, true);
	}
	
	override public function render():void
	{
		// fade the alpha of the helper buffer																   //Rate of fade
		helper.pixels.colorTransform(new Rectangle(0, 0, FlxG.width, FlxG.height), new ColorTransform(1, 1, 1, 0.9));
			
		// save FlxG.buffer
		var tmp:BitmapData = FlxG.buffer;

		// point FlxG.buffer at our helper sprite so the bullets get drawn onto this instead of FlxG.buffer
		FlxG.buffer = helper.pixels;

		super.render();
			
		// put the buffer back
		FlxG.buffer = tmp;
		
		
			
		// copy our helper buffer to the main flixel buffer
		FlxG.buffer.copyPixels(helper.pixels, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(0, 0), null, null, true);
		//For the level transistion effects
		Globals.global_tmp_buffer = FlxG.buffer;
	}
}

}