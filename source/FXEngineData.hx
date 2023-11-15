// Stolen from KE LOL!
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;

class FXEngineData
{   
	public static var checkForUpdates:Bool = true;
	public static var hideHud:Bool = false;

    public static function initSave()
    {	
		if (FlxG.save.data.zxnm == null)
			FlxG.save.data.zxnm = false;

		if (FlxG.save.data.dialogue == null)
			FlxG.save.data.dialogue = false;

		if(FlxG.save.data.hideHud != null) {
			hideHud = FlxG.save.data.hideHud;
		}

	    if (FlxG.save.data.downscroll == null)
		   FlxG.save.data.downscroll = false;

        if (FlxG.save.data.botplay == null)
           FlxG.save.data.botplay = false;

        if (FlxG.save.data.checkForUpdates == null)
           FlxG.save.data.checkForUpdates = false;

        if (FlxG.save.data.iconbops == null)
            FlxG.save.data.iconbops = false;     

        if (FlxG.save.data.quaverbar == null)
            FlxG.save.data.quaverbar = false; 

        if (FlxG.save.data.icons == null)
            FlxG.save.data.icons = false; 

        if (FlxG.save.data.songPosition == null)
            FlxG.save.data.songPosition = false;

        if (FlxG.save.data.middleScroll == null) 
            FlxG.save.data.middleScroll = false;   

        if (FlxG.save.data.pttauntsound == null) 
            FlxG.save.data.pttauntsound = false;              
    }

	@:keep public static inline function framerateAdjust(input:Float):Float 
    {
		return FlxG.elapsed * 60 * input;
	}

}