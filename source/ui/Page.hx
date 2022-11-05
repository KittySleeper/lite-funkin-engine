package ui;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSignal.FlxTypedSignal;

class Page extends FlxTypedGroup<Dynamic>
{
	public var onSwitch:FlxTypedSignal<PageName->Void> = new FlxTypedSignal<PageName->Void>();
	public var onExit:FlxTypedSignal<Void->Void> = new FlxTypedSignal<Void->Void>();
	public var onForceExit:FlxTypedSignal<Void->Void> = new FlxTypedSignal<Void->Void>();

	public var enabled(default, set):Bool = true;
	public var canExit:Bool = true;

	public var forceExit(default, set):Bool = false;

	public function exit()
	{
		onExit.dispatch();
	}

	public function forceExit()
	{
		onForceExit.dispatch();
	}	

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (enabled)
		{
			updateEnabled(elapsed);
		}
	}

	function updateEnabled(elapsed:Float)
	{
		if (canExit && PlayerSettings.player1.controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			onExit.dispatch();
		}

		if (forceExit){
			FlxG.sound.play(Paths.sound('cancelMenu'));
			forceExit.dispatch();
		}
	}

	function set_enabled(state:Bool)
	{
		return enabled = state;
	}

	function set_forceExit(s:Bool){
		return forceExit = s;
	}

	public function openPrompt(prompt:Prompt, callback:Dynamic)
	{
		enabled = false;
		prompt.closeCallback = function()
		{
			enabled = true;
			if (callback != null)
				callback();
		}
		FlxG.state.openSubState(prompt);
	}

	override public function destroy()
	{
		super.destroy();
		onSwitch.removeAll();
	}
}