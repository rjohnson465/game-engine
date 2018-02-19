/// isSelectorInInventory(*selectorId)
/// *selectorId

var selectorX = 0; var selectorY = 0;
if argument_count == 1 {
	var selector = argument[0];
	selectorX = selector.x1;
	selectorY = selector.y1;
}
else {
	selectorX = x1;
	selectorY = y1;
}

var inv = global.inventory;

if global.ui.currentMenu == INVENTORY {
	return	selectorX >= inv.invTopLeftX && selectorX <= inv.invBottomRightX
			&& selectorY >= inv.invTopLeftY && selectorY <= inv.invBottomRightY;
}
return false;