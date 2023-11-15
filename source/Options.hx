package;

import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import flixel.FlxG;
import openfl.display.FPS;
import openfl.Lib;

class OptionCatagory
{
	public static var iconbops:String = 'BOP';

	private var _options:Array<Option> = new Array<Option>();
	public final function getOptions():Array<Option>
	{
		return _options;
	}

	public final function addOption(opt:Option)
	{
		_options.push(opt);
	}

	
	public final function removeOption(opt:Option)
	{
		_options.remove(opt);
	}

	private var _name:String = "New Catagory";
	public final function getName() {
		return _name;
	}

	public function new (catName:String, options:Array<Option>)
	{
		_name = catName;
		_options = options;
	}
}

class Option
{
	public function new()
	{
		display = updateDisplay();
	}
	private var description:String = "";
	private var display:String;
	public final function getDisplay():String
	{
		return display;
	}

	public final function getDescription():String
	{
		return description;
	}

	// Returns whether the label is to be updated.
	public function press():Bool { return throw "stub!"; }
	private function updateDisplay():String { return throw "stub!"; }
}

class ZXNMOption extends Option
{
	private var controls:Controls;

	public function new(controls:Controls)
	{
		super();
		this.controls = controls;
	}

	public override function press():Bool
	{
        FlxG.state.openSubState(new KeyBindMenu());
		return true;
	}

	private override function updateDisplay():String
	{
		return  FlxG.save.data.zxnm ? "Controls" : "Controls";
	}
}

class DialOption extends Option
{
	public function new(desc:String)
	{
		super();
	}

	public override function press():Bool
	{
		FlxG.save.data.restored = !FlxG.save.data.dialogue;
		trace('Restored Dialogue : ' + FlxG.save.data.dialogue);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return  FlxG.save.data.dialogue ? "Dialogue On" : "Dialogue Off";
	}
}

class BotPlayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.botplay = !FlxG.save.data.botplay;
		trace('BotPlay : ' + FlxG.save.data.botplay);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
		return "BotPlay " + (FlxG.save.data.botplay ? "on" : "off");
}

class PosBarOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.songPosition ? "SongPositionBar ON" : "SongPositionBar OFF";
	}
}

class DownscrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.downscroll ? "Downscroll" : "Upscroll";
	}
}

class MiddleScrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.middleScroll = !FlxG.save.data.middleScroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.middleScroll ? "MiddleScroll" : "RegScroll";
	}
}

class IconBopOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	
	public override function press():Bool
	{
		FlxG.save.data.iconbops = !FlxG.save.data.iconbops;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Icon Bops " + (!FlxG.save.data.iconbops ? "off" : "on");
	}
}

class QuaverBarOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.quaverbar = !FlxG.save.data.quaverbar;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Quaver Bar " + (!FlxG.save.data.quaverbar ? "off" : "on");
	}
}

class PTOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.pttauntsound = !FlxG.save.data.pttauntsound;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "PT Sound Effect: " + (!FlxG.save.data.pttauntsound ? "off" : "on");
	}
}
