package;

import flixel.system.FlxAssets.FlxShader;
import shaders.ColorSwapShader;

class ColorSwapEffect
{
	public var shader:ColorSwapShader = new ColorSwapShader();
	public var hueShit:Float = 0;
	public var hasOutline:Bool = false;

	public function new()
	{
		shader.uTime.value = [0];
		shader.money.value = [0];
		shader.awesomeOutline.value = [hasOutline];
	}

	public function update(elapsed:Float)
	{
		shader.uTime.value[0] += elapsed;
		hueShit += elapsed;
	}
}