/// isSelectorInEquippedItems
// must be called by an instance of selector

var selectorX = x1;
var selectorY = y1;

/*with obj_item_selector {
	selectorX = x1;
	selectorY = y1;
}*/

var eq = global.equippedItemsManager;

if global.ui.currentMenu == INVENTORY {
	return	selectorX >= eq.topLeftX && selectorX <= eq.bottomRightX
			&& selectorY >= eq.topLeftY && selectorY <= eq.bottomRightY;
}
return false;