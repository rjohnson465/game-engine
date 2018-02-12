/// isSelectorInInventory

var selectorX = x1;
var selectorY = y1;

/*with obj_item_selector {
	selectorX = x1;
	selectorY = y1;
}*/

var inv = global.inventory;

if global.ui.currentMenu == INVENTORY {
	return	selectorX >= inv.invTopLeftX && selectorX <= inv.invBottomRightX
			&& selectorY >= inv.invTopLeftY && selectorY <= inv.invBottomRightY;
}
return false;