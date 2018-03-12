/// isSelectorInEquippedItems(*selector)
/// @param *selector
// must be called by an instance of selector

var s = id;
if argument_count == 1 {
	s = argument[0];
}
var selectorX = s.x1;
var selectorY = s.y1;

var eq = global.equippedItemsManager;

if global.ui.currentMenu == INVENTORY {
	return	selectorX >= eq.topLeftX && selectorX <= eq.bottomRightX
			&& selectorY >= eq.topLeftY && selectorY <= eq.bottomRightY;
}
return false;