package {
	import com.KungFu.Globals;		
	import org.flixel.FlxGame;
	import com.KungFu.PlayState;
	import com.KungFu.LevelComplete;
	import com.KungFu.SelectState;
	import com.KungFu.MenuState;
	import com.KungFu.GameComplete;
	import com.KungFu.FunBits;

		
	[SWF(width="640", height="480", backgroundColor="#1A1417")]
	[Frame(factoryClass="Preloader")]

	public class KungFu extends FlxGame
	{
		public function KungFu():void
		{
			//super(320, 240, SelectState, 2);
			//super(320, 240, MenuState , 2);
			super(320, 240, FunBits , 2);
			//super(320, 240, GameComplete , 2);
			//super(320, 240, PlayState , 2);
			showLogo = false;
			
			Globals.setStartStats(false);
			//Prepare goals
			Globals.setGoals();			
		}
	}
}
