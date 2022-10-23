package ui;

import flixel.FlxG;
import flixel.FlxSprite;

class JudgePositionState extends MusicBeatState{
    override function create() {
            var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback', 'shared'));
            add(bg);

            var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront', 'shared'));
            stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
            stageFront.updateHitbox();
            stageFront.antialiasing = true;
            stageFront.scrollFactor.set(0.9, 0.9);
            stageFront.active = false;
            add(stageFront);

            var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains', 'shared'));
            stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
            stageCurtains.updateHitbox();
            stageCurtains.antialiasing = true;
            stageCurtains.scrollFactor.set(1.3, 1.3);
            stageCurtains.active = false;
            add(stageCurtains);
    }

    override public function update(elapsed:Float){
        if(FlxG.keys.justPressed.ESCAPE){
            FlxG.switchState(new ui.OptionsState());
        }
    }
}