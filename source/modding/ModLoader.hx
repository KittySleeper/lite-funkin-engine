package modding;

/**
 * Class that loads different mods into the game.
 * @author Leather128
 */
class ModLoader
{
	/**
	 * Currently selected mod in the game.
	 */
	public static var current_mod:String = '';

	/**
	 * `Array` of the names of all currently available mods.
	 */
	public static var available_mods:Array<String> = [];

	/**
	 * Initializes the mod system with the specified `mod`.
	 * @param mod Mod to initialize with.
	 */
	public static function init(?mod:String, ?restart_state:Bool = false):Void
	{
		#if polymod
		if (mod != null)
			current_mod = mod;

		polymod.Polymod.init({
			modRoot: 'mods/',
			dirs: [current_mod],
			framework: OPENFL,
			frameworkParams: {
				assetLibraryPaths: [
					'songs' => 'songs', 'shared' => 'shared', 'week2' => 'week2', 'week3' => 'week3', 'week4' => 'week4', 'week5' => 'week5',
					'week6' => 'week6', 'week7' => 'week7', 'week8' => 'week8', 'troll' => 'troll'
				]
			},
			errorCallback: function(err:polymod.Polymod.PolymodError):Void
			{
				trace('{ message: ${err.message}, code: ${err.code}, severity: ${err.severity}, origin: ${err.origin} }');
			}
		});
		#else
		CoolUtil.error('Failed to initialize Polymod with $mod because Polymod does not exist!');
		#end

		if (restart_state)
			flixel.FlxG.resetState();
	}

	/**
	 * Uses Polymod to scan for all available mods in the mods folder.
	 */
	public static function scan():Void
	{
		#if polymod
		for (meta in polymod.Polymod.scan('mods/', '*.*.*'))
		{
			available_mods.push(meta.id);
		}
		#end
	}
}
