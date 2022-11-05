package;

import ui.PreferencesMenu;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";

	var randomGameover:Int = 1;
	var playingDeathSound:Bool = false;

	public var daBPM:Int = 100;

	var daBf:String = '';

	public var gameOverChar:String = "";

	function resetVariables(){
		// for (guh in defaultProperties){
		// 	daBf = guh[0];
		// }
		daBf = 'bf';
	}

	public function new(x:Float, y:Float, ?kidsImGoingToMurder:Int = 100)
	{
		var daStage = PlayState.curStage;

		if (Character.deathChar != '' || Character.deathChar != null && Character.deathChar.length > 0)
			gameOverChar = Character.deathChar;

		switch (daStage)
		{
			case 'school' | 'schoolEvil':
				stageSuffix = '-pixel';
				// daBf = 'bf-pixel-dead';
				Character.deathChar = 'bf-pixel-dead';
			default:
				// daBf = 'bf';
				Character.deathChar = 'bf';
		}
		if (PlayState.SONG.song.toLowerCase() == 'stress')
		{
			// daBf = 'bf-holding-gf-dead';
			Character.deathChar = 'bf-holding-gf-dead';
		}

		// if (Character.deathChar != '' || Character.deathChar != null && Character.deathChar.length > 0){
		// 	daBf = Character.deathChar;
		// }

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, gameOverChar);
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));

		if (kidsImGoingToMurder != 100)
			Conductor.changeBPM(kidsImGoingToMurder);
		else
			Conductor.changeBPM(daBPM);

		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');

		var exclude = [];
		if (PreferencesMenu.getPref('censor-naughty'))
		{
			exclude = [1, 3, 8, 13, 17, 21];
		}
		randomGameover = FlxG.random.int(1, 25, exclude);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;

			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12 && bf != null)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (PlayState.storyWeek == 7)
		{
			if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished && !playingDeathSound && bf != null && bf.animation.curAnim != null)
			{
				playingDeathSound = true;
				bf.startedDeath = true;
				coolStartDeath(0.2);
				FlxG.sound.play(Paths.sound('jeffGameover/jeffGameover-' + randomGameover), 1, false, null, true, function()
				{
					FlxG.sound.music.fadeIn(4, 0.2, 1);
				});
			}
		}
		else if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished && bf != null && bf.animation.curAnim != null)
		{
			bf.startedDeath = true;
			coolStartDeath();
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	function coolStartDeath(startVol:Float = 1)
	{
		FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix), startVol);
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

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
