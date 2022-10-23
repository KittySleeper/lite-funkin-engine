package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;

class HEY extends MusicBeatState{
    override function create() {
        var bg = new FlxSprite(null, null, Paths.image('menuDesat'));
        bg.scrollFactor.x = bg.scrollFactor.x;
        bg.scrollFactor.y = bg.scrollFactor.y;
        bg.setGraphicSize(Std.int(bg.width));
        bg.updateHitbox();
        bg.x = bg.x;
        bg.y = bg.y;
        bg.visible = false;
        bg.antialiasing = true;
        bg.alpha = 0.7;
        bg.color = 0xFF1B1A1A;

        var warn = new FlxText();
		warn.text = "hey this engine is in github beta and isnt even 1% complete\nthis is supposed what my formor engine 'dike engine' was supposed to be\nthere will be many bugs and it is likely unstable\nif you understand you can press enter to go to title state.\nbut if you want to see my formor engine press escape";
		warn.alignment = CENTER;
		warn.scale.set(2.3,2.3);
		warn.updateHitbox();
		warn.screenCenter();
		add(warn); 
    }

    override public function update(elapsed:Float){
        if (FlxG.keys.justPressed.ENTER){
            FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
            FlxG.switchState(new MainMenuState());
        }
        if(FlxG.keys.justPressed.ESCAPE)
        #if linux
            Sys.command('/usr/bin/xdg-open', ["https://github.com/504brandon/dike-engine/", "&"]);
        #else
            FlxG.openURL('https://github.com/504brandon/dike-engine/');
        #end
    }
}