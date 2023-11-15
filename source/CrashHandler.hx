#if CRASH_HANDLER
package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import Discord.DiscordClient;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import openfl.Lib;
import Discord.DiscordClient;

class CrashHandler extends MusicBeatSubstate
{
	var bf:Boyfriend;

	var stageSuffix:String = "";
	var randomGameover:Int = 1;

	var danceTime:Bool = false;
	var started:Bool = false;

	var daChrome:Float = 0.003;
	var daNoise:Int = 100;
	var awesomeShaderTime:Bool = false;	

	// error
	var errorText: FlxText;
	var errorGroup: FlxTypedGroup<Alphabet>;
	var othererrorText: FlxText;
    var theactualerrorshithere: FlxText;

	public function new(x:Float, y:Float)
	{
		var daBf:String = 'bf';
		FlxG.sound.music.stop();

		super();

		Conductor.songPosition = 0;
		FlxG.sound.music.stop();

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.loadImage('menuDesat'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		bf = new Boyfriend(770, 450, daBf);
		add(bf);

		// error lel
		errorGroup = new FlxTypedGroup<Alphabet>();
		add(errorGroup);

		var errortest:Alphabet = new Alphabet(100, 0, "An error has occured!", true, false);
		errorGroup.add(errortest);

        errorText = new FlxText(10, 100, FlxG.width - 20, "Please report this error to https://github.com/blitzexlmao/Blammed-ModFarted.");
        errorText.alignment = FlxTextAlign.CENTER;
        errorText.color = FlxColor.RED;
        errorText.size = 16;
        add(errorText);

        othererrorText = new FlxText(10, 150, FlxG.width - 20, "Press enter to close the game.");
        othererrorText.alignment = FlxTextAlign.CENTER;
        othererrorText.color = FlxColor.RED;
        othererrorText.size = 16;
        add(othererrorText);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');

		randomGameover = FlxG.random.int(1, 25);		
	}

	var playingDeathSound:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (PlayState.SONG.song.toLowerCase() == 'thorns')
			{
				if (awesomeShaderTime)
				{
					if (!isEnding)
					{
						PlayState.vhsShader.setNoisePercent(100 / 100);
						PlayState.chromaticAbberation.setChrome(FlxG.random.float(0.001, 0.005));
					}
					else
					{
						daNoise -= 2;
						daChrome += 0.0001;
	
						PlayState.chromaticAbberation.setChrome(daChrome);
						PlayState.vhsShader.setNoisePercent(daNoise / 100);
					}
				}
				else
				{
					PlayState.vhsShader.setNoisePercent(0);
					PlayState.chromaticAbberation.setChrome(0);
					PlayState.vhsShader.update(elapsed);
				}
	
				if (started)
					PlayState.vhsShader.update(elapsed);
			}	

		if (controls.ACCEPT)
		{
            DiscordClient.shutdown();
            Sys.exit(1);
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	private function coolStartDeath():Void
	{
		// I would do a thing but I'm gay
	}

	override function beatHit()
	{
		super.beatHit();

		if (danceTime && !isEnding)
			{
				bf.animation.play('deathLoop', true);
			}
	
			FlxG.log.add('beat' + curBeat);	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
#end