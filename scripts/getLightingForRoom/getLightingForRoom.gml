/// getLightingForRoom(rm)
/// @param rm
// returns array of colors -- light colors for each layer in a room

var rm = argument0;

switch rm {
	case game_menu: {
		return [c_gray]; break;
	}
	case rm_winter: {
		var c = make_color_rgb(52, 66, 105)
		return [c, c];
	}
	case rm_xmas_town: {
		var c = make_color_rgb(52, 66, 105)
		return [c, c];
	}
	case rm_hanukkah_village: {
		var c = make_color_rgb(52, 66, 105)
		return [c, c];
	}
	case rm_tundra: {
		var c = make_color_rgb(52, 66, 105);
		return [c, c];
	}
	case rm_clayfields: {
		var c = make_color_rgb(52, 66, 105);
		return [c, c];
	}
	case rm_krampus: {
		var c = make_color_rgb(52, 66, 105);
		return [c, c];
	}
	case rm_golemking: {
		var c = make_color_rgb(52, 66, 105);
		return [c, c];
	}
	case rm_dungeon: {
		return [c_dkgray, c_dkgray, c_red]; break;
	}
	case rm_factory: {
		var c = make_color_rgb(46, 43, 68);
		var cDarker = make_color_rgb(23, 21, 34);
		return [c, c, c, c, cDarker]; break;
	}
	case rm_boss_ravebot: {
		var c = make_color_rgb(46, 43, 68);
		return [c, c]; break;
	}
	case rm_boss_lighteater: {
		var c = make_color_rgb(23, 21, 34);
		// var c = c_ltgray;
		return [c, c, c, c]; break;
	}
	case rm_dungeon2: {
		return [c_dkgray, c_dkgray, c_red]; break;
	}
	case rm_forest: {
		//return [make_color_rgb(56, 68, 89), c_gray];
		return [c_dkgray, c_dkgray];
	}
	case rm_boss_funfairy: {
		//return [make_color_rgb(56, 68, 89), c_gray];
		return [c_dkgray, c_dkgray];
	}
}