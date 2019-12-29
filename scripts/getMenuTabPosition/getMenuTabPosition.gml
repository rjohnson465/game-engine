/// getFilterPosition(tabMacro)
/// @param tabMacro

// Get the x / y position of a tab drawn in the UI. Must be called by global UI object

var t = argument[0];

var arr = noone;
// menu category tabs (3)
var tabWidth = 0;
if gamepad_is_connected(global.player.gamePadIndex) {
	tabWidth = (menusWidth-(menuTabsHeight*2)) / array_length_1d(menuTypes); // (menuTabsHeight*2) allows 2 trigger prompts
} else {
	tabWidth = menusWidth / array_length_1d(menuTypes);
}
var xx = MENUS_TOPLEFT_X;
var yy = MENUS_TOPLEFT_Y+menusHandleHeight;
if gamepad_is_connected(global.player.gamePadIndex) {
	xx = MENUS_TOPLEFT_X + menuTabsHeight;
}
for (var i = 0; i < array_length_1d(menuTypes); i++) {
	var x1 = xx + (i*tabWidth);
	var el = menuTypes[i];
	
	if el == t {
		arr = [x1, yy, tabWidth];
	}
}

return arr;