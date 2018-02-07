if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

//if !isEquipped {
if ds_list_find_index(global.player.inventory,id) {
	var idd = id;
	with obj_inventory {
		selectedItem = idd;
	}
}
mightGrab = true;