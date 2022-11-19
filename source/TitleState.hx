package;

import openfl.display.FPS;
import ui.JudgePositionState;
import ui.UnnessesaryMenu;
import openfl.display.Sprite;
import openfl.net.NetStream;
import openfl.media.Video;
import ui.PreferencesMenu;
import shaderslmfao.BuildingShaders;
import shaderslmfao.ColorSwap;
#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;
import openfl.Lib;
import flixel.addons.display.FlxBackdrop; 

using StringTools;

class TitleState extends MusicBeatState
{
	public static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var tzank_boi_apobz_obv_ur_motr:FlxSprite;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	var lastBeat:Int = 0;

	var swagShader:ColorSwap;
	var alphaShader:BuildingShaders;

	var video:Video;
	var netStream:NetStream;
	var overlay:Sprite;

	override public function create():Void
	{
		swagShader = new ColorSwap();
		alphaShader = new BuildingShaders();

		FlxG.sound.muteKeys = [ZERO];

		curWacky = FlxG.random.getObject(getIntroTextShit());

		super.create();

		FlxG.save.bind('funkin', 'ninjamuffin99');

		if (FlxG.save.data.mod != null)
			modding.ModLoader.init(FlxG.save.data.mod);
		else
			FlxG.save.data.mod = '';

		modding.ModLoader.scan();

		PreferencesMenu.initPrefs();
		PlayerSettings.init();
		Highscore.load();

		if (FlxG.save.data.weekUnlocked != null)
		{
			// FIX LATER!!!
			// WEEK UNLOCK PROGRESSION!!
			// StoryMenuState.weekUnlocked = FlxG.save.data.weekUnlocked;

			if (StoryMenuState.weekUnlocked.length < 4)
				StoryMenuState.weekUnlocked.insert(0, true);

			// QUICK PATCH OOPS!
			if (!StoryMenuState.weekUnlocked[0])
				StoryMenuState.weekUnlocked[0] = true;
		}

		if (FlxG.save.data.seenVideo != null)
		{
			VideoState.seenVideo = FlxG.save.data.seenVideo;
		}

		if (FlxG.save.data.settings != null)
			PreferencesMenu.preferences = FlxG.save.data.settings;

		if (FlxG.save.data.comboy != null)
			JudgePositionState.COMBO_POSITION.y = FlxG.save.data.comboy;
		if (FlxG.save.data.combox != null)
			JudgePositionState.COMBO_POSITION.x = FlxG.save.data.combox;
		if (FlxG.save.data.sicky != null)
			JudgePositionState.SICK_POSITION.y = FlxG.save.data.sickyy;
		if (FlxG.save.data.sickx != null)
			JudgePositionState.SICK_POSITION.x = FlxG.save.data.sickx;

		/*if (FlxG.save.data.unnessearystuffthatsset != null)
			UnnessesaryMenu.dumbassunesesaryandyesispelleditwrongidc = FlxG.save.data.unnessearystuffthatsset; */

		if (PreferencesMenu.getPref('fpsshow') != null)
			Main.fpsCounter.visible = PreferencesMenu.getPref('fpsshow');

		if (PreferencesMenu.getPref('fpsboost'))
			FlxG.stage.frameRate = 1000;

		if (PreferencesMenu.getPref('fpsboost') == false)
			FlxG.stage.frameRate = 120;

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});

		#if desktop
		DiscordClient.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			DiscordClient.shutdown();
		});
		#end
	}

	function client_onMetaData(e)
	{
		video.attachNetStream(netStream);
		video.width = video.videoWidth;
		video.height = video.videoHeight;
	}

	function netStream_onAsyncError(e)
	{
		trace("Error loading video");
	}

	function netConnection_onNetStatus(e)
	{
		if (e.info.code == 'NetStream.Play.Complete')
		{
			startIntro();
		}
		trace(e.toString());
	}

	function overlay_onMouseDown(e)
	{
		netStream.soundTransform.volume = 0.2;
		netStream.soundTransform.pan = -1;
		Lib.current.stage.removeChild(overlay);
	}

	var realbg:FlxBackdrop;
	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;

	function startIntro()
	{
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(102);
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		realbg = new FlxBackdrop(Paths.image('titlebg'), 1, 1, true, true); 
		realbg.updateHitbox(); 
		realbg.scrollFactor.set(0, 0); 
		realbg.alpha = 1; 
		realbg.screenCenter(X);
		realbg.y -= 320;
		realbg.velocity.x = 20;
		add(realbg); 

		logoBl = new FlxSprite(-110, 43);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = true;
		logoBl.scale.set(0.8, 0.8);
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 18);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		logoBl.shader = swagShader.shader;

		gfDance = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07);
		gfDance.frames = Paths.getSparrowAtlas('gfDanceTitle');
		gfDance.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		gfDance.antialiasing = true;
		add(gfDance);
		gfDance.shader = swagShader.shader;
		add(logoBl);

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		add(titleText);

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "[504]brandon\nLeather128\nMemeHoovy\nInskal\nFutureDorito", true);
		credTextShit.screenCenter();

		credTextShit.visible = false;

		tzank_boi_apobz_obv_ur_motr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('UrMom'));
		add(tzank_boi_apobz_obv_ur_motr);
		tzank_boi_apobz_obv_ur_motr.visible = false;
		tzank_boi_apobz_obv_ur_motr.setGraphicSize(Std.int(tzank_boi_apobz_obv_ur_motr.width * 0.8));
		tzank_boi_apobz_obv_ur_motr.updateHitbox();
		tzank_boi_apobz_obv_ur_motr.screenCenter(X);
		tzank_boi_apobz_obv_ur_motr.antialiasing = true;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.onComplete = function()
			{
				FlxG.switchState(new VideoState());
			}
		}
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	var isRainbow:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.EIGHT)
		{
			FlxG.switchState(new CutsceneAnimTestState());
		}

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if (FlxG.keys.justPressed.F) // why f?
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;
		}

		if (pressedEnter && !transitioning && skippedIntro)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.onComplete = null;
			}

			titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;

			// Check if version is outdated
			if (!OutdatedSubState.leftState)
			{
				// TODO: Make a check here or delete this since no NGAPI
				FlxG.switchState(new MainMenuState());
			}
		}

		if (pressedEnter && !skippedIntro && initialized)
		{
			skipIntro();
		}

		if (controls.UI_LEFT)
		{
			swagShader.update(elapsed * 0.1);
		}
		if (controls.UI_RIGHT)
		{
			swagShader.update(-elapsed * 0.1);
		}

		super.update(elapsed);
		if (FlxG.keys.justPressed.CONTROL)
			FlxG.switchState(new LatencyState());
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function beatHit()
	{
		super.beatHit();

		logoBl.animation.play('bump');
		danceLeft = !danceLeft;

		if (danceLeft)
			gfDance.animation.play('danceRight');
		else
			gfDance.animation.play('danceLeft');

		#if debug
		trace(curBeat);
		trace(curStep);
		#end

		if (curBeat > lastBeat)
		{
			for (i in lastBeat...curBeat)
			{
				switch (i + 1)
				{
					case 1:
						createCoolText(['[504]brandon', 'leather128', 'MemeHoovy', 'InsKal', 'FutureDorito']);
					case 3:
						addMoreText('present');
					case 4:
						deleteCoolText();
					case 5:
						createCoolText(['In association', 'with']);
					case 7:
						addMoreText('ur mom');
						tzank_boi_apobz_obv_ur_motr.visible = true;
					case 8:
						deleteCoolText();
						tzank_boi_apobz_obv_ur_motr.visible = false;
					case 9:
						createCoolText([curWacky[0]]);
					case 11:
						addMoreText(curWacky[1]);
					case 12:
						deleteCoolText();
					case 13:
						addMoreText('Friday');
					case 14:
						addMoreText('Night');
					case 15:
						addMoreText('Funkin');
					case 16:
						skipIntro();
				}
			}
		}

		lastBeat = curBeat;
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(tzank_boi_apobz_obv_ur_motr);

			FlxG.camera.flash(FlxColor.WHITE, 4);
			remove(credGroup);
			skippedIntro = true;
		}
	}
}
