/// getFilterPosition(filter)
/// @param filter

// Get the x / y position of a filter drawn in the UI. Must be called by global inventory object

var f = argument[0];

var arr = noone;

var currentFilter = ds_map_find_first(filterSprites);
var filtersTotalWidth = 0;
var filterOffset = 0; // for gamepad inventory
if gamepad_is_connected(global.player.gamePadIndex) {
	filterOffset = 1;
	var scale = filtersWidth / sprite_get_width(spr_prompt_xbox_lb);
}
for (var i = 0; i < ds_map_size(filterSprites); i++) {
	var spr = ds_map_find_value(filterSprites,currentFilter);
	
	var xx = topLeftX+((i+filterOffset)*filtersWidth);
	var yy = topLeftY;
	if currentFilter == f {
		arr = [xx, yy];
	}

	// draw_sprite_ext(spr,1,topLeftX+((i+filterOffset)*filtersWidth),topLeftY,1,1,0,c_gray,.75);
	
	filtersTotalWidth += filtersWidth;
	currentFilter = ds_map_find_next(filterSprites,currentFilter);
}

return arr;