package 
{ 
	
	import org.flixel.data.FlxFactory; 
	public class Preloader extends FlxFactory 
	{ 
		public function Preloader():void 
		{
			className = "KungFu";
			//myURL = "flashgamelicense.com";
			myURL = "lupigames.com";
			super();
		}
	}
}
