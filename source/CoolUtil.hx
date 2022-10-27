package;

import flixel.FlxG;
import lime.utils.Assets;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD", "ERECT", "TROLL"];

	public static function difficultyString():String
	{
		return difficultyArray[PlayState.storyDifficulty];
	}

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

	public static function loadSong(SongName:String, Diff:Int, Week:Int) {
		var loader = Highscore.formatSong(SongName, Diff);
		PlayState.SONG = Song.loadFromJson(loader, SongName);
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = Diff;
		PlayState.storyWeek = Week;
		LoadingState.loadAndSwitchState(new PlayState());
	}
     
	public static function browserLoad(site:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	public static function changeicon(char:String, player:Int) {//why not make changeing icons more ezz
		if(player == 1)
		PlayState.iconP1.changeIcon(char);
		else
		PlayState.iconP2.changeIcon(char);
	}
}
