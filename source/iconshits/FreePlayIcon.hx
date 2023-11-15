package iconshits;

import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class FreePlayIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	var char:String = '';
	var isPlayer:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		this.isPlayer = isPlayer;

		changeIcon(char);
		antialiasing = true;
		scrollFactor.set();
	}

	public var isOldIcon:Bool = false;

	public function swapOldIcon():Void
	{
		isOldIcon = !isOldIcon;

		if (isOldIcon)
			changeIcon('bf-old');
		else
			changeIcon(PlayState.SONG.player1);
	}

	public function changeIcon(newChar:String):Void
	{
   		if (newChar != 'bf-pixel' && newChar != 'bf-old')
        	newChar = newChar.split('-')[0].trim();

    	if (newChar != char)
    	{
        	if (animation.getByName(newChar) == null)
        	{
            	#if sys
            	loadGraphic(Paths.loadImage('icons/icon-' + newChar), true, 150, 150);
            	#else
            	loadGraphic(Paths.loadImage('icons/icon-' + newChar), true, 150, 150);
            	#end
            	animation.add(newChar, [0, 1], 0, false, isPlayer);
        	}
        	animation.play(newChar);
        	char = newChar;
   		}
   		else if (animation.getByName(newChar) == null)
    	{
       		// Load and set the default icon
        	#if sys
        	loadGraphic(Paths.loadImage('icons/default-icon'), true, 150, 150); // Update the path as needed
       	 	#else
        	loadGraphic(Paths.loadImage('icons/default-icon'), true, 150, 150); // Update the path as needed
        	#end
        	animation.add(newChar, [0], 0, false, isPlayer); // Use a single frame for the default icon
        	animation.play(newChar);
    	}
	}
		
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}