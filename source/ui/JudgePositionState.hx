package ui;

import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;

class JudgePositionState extends MusicBeatState{
    public static var SICK_POSITION:FlxPoint = new FlxPoint();
    public static var COMBO_POSITION:FlxPoint = new FlxPoint();

    public var SICK:FlxSprite = new FlxSprite().loadGraphic(Paths.image('sick', 'shared'));
    public var COMBO:FlxSprite = new FlxSprite().loadGraphic(Paths.image('combo', 'shared'));

    override function create() {
            FlxG.mouse.enabled = true;
            FlxG.mouse.visible = true;

            SICK.setPosition(SICK_POSITION.x, SICK_POSITION.y);
            COMBO.setPosition(COMBO_POSITION.x, COMBO_POSITION.y);

            var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback', 'shared'));
            add(bg);

            var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront', 'shared'));
            stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
            stageFront.updateHitbox();
            stageFront.antialiasing = true;
            stageFront.scrollFactor.set(0.9, 0.9);
            stageFront.active = false;
            add(stageFront);

            var dad:FlxSprite = new FlxSprite(100, 100);
            dad.frames = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
            dad.animation.addByPrefix('idle', 'Dad idle dance', 24, true);
            dad.animation.play('idle', true);
            add(dad);

            var boigi:FlxSprite = new FlxSprite(770, 450);
            boigi.frames = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
            boigi.animation.addByPrefix('idle', 'BF idle dance', 24, true);
            boigi.animation.play('idle', true);
            add(boigi);

            var rateingpostxtplacement:FlxText = new FlxText(0, 0, 0, ''/*urmomisgaybtw*/, 32);
            rateingpostxtplacement.screenCenter();
            rateingpostxtplacement.x = FlxG.width * 0.55;

            SICK.screenCenter();
            SICK.x = rateingpostxtplacement.x - 40;
            SICK.y -= 60;
            if(FlxG.save.data.sicky != null)
            SICK.y = FlxG.save.data.sicky;
            if(FlxG.save.data.sickx != null)
            SICK.x = FlxG.save.data.sickx;
            add(SICK);

            COMBO.screenCenter();
            COMBO.x = rateingpostxtplacement.x;
            if(FlxG.save.data.comboy != null)
            COMBO.y = FlxG.save.data.comboy;
            if(FlxG.save.data.combox != null)
            COMBO.x = FlxG.save.data.combox;
            add(COMBO);
    }

    override public function update(elapsed:Float){

        super.update(elapsed);

        FlxG.save.data.sicky = SICK_POSITION.y;
		FlxG.save.flush();
        FlxG.save.data.sickx = SICK_POSITION.x;
		FlxG.save.flush();
        FlxG.save.data.combox = COMBO_POSITION.x;
		FlxG.save.flush();
        FlxG.save.data.comboy = COMBO_POSITION.y;
		FlxG.save.flush();

        if(FlxG.keys.justPressed.LEFT){
            SICK.x -= 2;
        }
        if(FlxG.keys.justPressed.RIGHT){
            SICK.x += 2;
        }
        if(FlxG.keys.justPressed.UP){
            SICK.y -= 2;
        }
        if(FlxG.keys.justPressed.DOWN){
            SICK.y += 2;
        }
        if(FlxG.keys.justPressed.A){
            COMBO.x -= 2;
        }
        if(FlxG.keys.justPressed.D){
            COMBO.x += 2;
        }
        if(FlxG.keys.justPressed.W){
            COMBO.y -= 2;
        }
        if(FlxG.keys.justPressed.S){
            COMBO.y += 2;
        }

        SICK_POSITION.set(SICK.x, SICK.y);
        COMBO_POSITION.set(COMBO.x, COMBO.y);

        if(FlxG.keys.justPressed.ESCAPE){
            FlxG.switchState(new ui.OptionsState());
            FlxG.mouse.enabled = false;
            FlxG.mouse.visible = false;
        }
    }
}