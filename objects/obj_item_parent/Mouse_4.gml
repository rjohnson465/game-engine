if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

if !isEquipped {
	var idd = id;
	with obj_inventory {
		selectedItem = idd;
	}
}
mightGrab = true;