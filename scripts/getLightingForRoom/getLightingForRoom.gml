/// getLightingForRoom(rm)
/// @param rm
// returns array of colors -- light colors for each layer in a room

var rm = argument0;

switch rm {
	case rm_dungeon: {
		return [c_dkgray, c_dkgray, c_red]; break;
	}
	case rm_forest: {
		//return [make_color_rgb(56, 68, 89), c_gray];
		return [c_dkgray, c_dkgray];
	}
}