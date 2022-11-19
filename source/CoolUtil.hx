package;

import flixel.FlxG;
import lime.utils.Assets;

using StringTools;

class CoolUtil
{
	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	public static function camLerpShit(ratio:Float)
	{
		return ((1.0 / Main.fpsCounter.currentFPS) /*FlxG.elapsed*/ / (1.0 / 60.0)) * ratio;
	}

	public static function coolLerp(a:Float, b:Float, ratio:Float)
	{
		return a + camLerpShit(ratio) * (b - a);
	}

	public static function loadSong(SongName:String, Diff:String, Week:Int)
	{
		var loader = Highscore.formatSong(SongName, Diff);
		PlayState.SONG = Song.loadFromJson(loader, SongName);
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = Diff;
		PlayState.storyWeek = Week;
		LoadingState.loadAndSwitchState(new PlayState());
	}

	public static function openURl(site:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	public static function changeicon(char:String, player:Int)
	{ // why not make changeing icons more ezz
		if (player == 1)
			PlayState.iconP1.changeIcon(char);
		else
			PlayState.iconP2.changeIcon(char);
	}

	/**
		Makes the first letter of each word in `s` uppercase.
		@param s       The string to modify
		@author swordcube
	**/
	public static function firstLetterUppercase(s:String):String
	{
		var strArray:Array<String> = s.split(' ');
		var newArray:Array<String> = [];

		for (str in strArray)
			newArray.push(str.charAt(0).toUpperCase() + str.substring(1));

		return newArray.join(' ');
	}

	public static function error(message:Null<String> = null, title:Null<String> = 'Lite Funkin Engine'):Void
	{
		#if windows
		lime.app.Application.current.window.alert(message, title);
		#else
		trace('[CoolUtil.error] $title - $message');
		#end
	}
}
