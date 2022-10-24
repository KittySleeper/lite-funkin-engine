package ui;

import flixel.FlxGame;
import lime.tools.Command;
import openfl.display.Window;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import haxe.ds.StringMap;
import flixel.FlxSubState;

class UnnessearyMenu extends Page
{
	public static var unnessearyfunnis:StringMap<Dynamic> = new StringMap<Dynamic>();

	var checkboxes:Array<CheckboxThingie> = [];
	var menuCamera:FlxCamera;
	var items:TextMenuList;
	var camFollow:FlxObject;

	override public function new()
	{
		super();

		menuCamera = new FlxCamera();
		FlxG.cameras.add(menuCamera, false);

		menuCamera.bgColor = FlxColor.TRANSPARENT;
		camera = menuCamera;

		add(items = new TextMenuList());

		unnessearystuffthatgersetssetcreation('siguremode', 'MYEYESWEREDIEINGWHENTESTINGTHIS', true);

		camFollow = new FlxObject(FlxG.width / 2, 0, 140, 70);
		if (items != null) camFollow.y = items.members[items.selectedIndex].y;

		menuCamera.follow(camFollow, null, 0.06);
		menuCamera.deadzone.set(0, 160, menuCamera.width, 40);
		menuCamera.minScrollY = 0;
		items.onChange.add(function(item:TextMenuItem)
		{
			camFollow.y = item.y;
		});
	}

	public static function getUnnessesaryinfo(unnessesarythinglol:String)
	{
		return unnessearyfunnis.get(unnessesarythinglol);
	}

	public static function initallofthisshit()
	{
		unnessesaryshitcheck('MYEYESWEREDIEINGWHENTESTINGTHIS', true);
	}

	public static function unnessesaryshitcheck(identifier:String, defaultValue:Dynamic)
	{
		if (unnessearyfunnis.get(identifier) == null)
		{
			unnessearyfunnis.set(identifier, defaultValue);
			trace('set preference!');
		}
		else
		{
			trace('found preference: ' + Std.string(unnessearyfunnis.get(identifier)));
		}
	}

	public function unnessearystuffthatgersetssetcreation(label:String, identifier:String, value:Dynamic)
	{
		items.createItem(120, 120 * items.length + 30, label, Bold, function()
		{
			unnessesaryshitcheck(identifier, value);
			if (Type.typeof(value) == TBool)
			{
				prefToggle(identifier);
			}
			else
			{
				trace('swag');
			}
		});
		if (Type.typeof(value) == TBool)
		{
			createCheckbox(identifier);
		}
		else
		{
			trace('swag');
		}
		trace(Type.typeof(value));
	}

	public function createCheckbox(identifier:String)
	{
		var box:CheckboxThingie = new CheckboxThingie(0, 120 * (items.length - 1), unnessearyfunnis.get(identifier));
		checkboxes.push(box);
		add(box);
	}

	public function prefToggle(identifier:String)
	{
		var value:Bool = unnessearyfunnis.get(identifier);
		value = !value;
		unnessearyfunnis.set(identifier, value);
		checkboxes[items.selectedIndex].daValue = value;
		trace('toggled? ' + Std.string(unnessearyfunnis.get(identifier)));
		switch (identifier)
		{
			
		}

		FlxG.save.data.unnessearystuffthatsset = unnessearyfunnis;
		FlxG.save.flush();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		menuCamera.followLerp = CoolUtil.camLerpShit(0.05);
		items.forEach(function(item:MenuItem)
		{
			if (item == items.members[items.selectedIndex])
				item.x = 150;
			else
				item.x = 120;
		});
	}
}
