package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class FumoGameOver extends MusicBeatState
{
	public function new():Void
	{
		super();
	}

	override function create()
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.loadImage('fumo/fumooo'));
		add(bg);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.switchState(new PlayState());
		}

		super.update(elapsed);
	}
}
