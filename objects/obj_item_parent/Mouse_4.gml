if owner != global.player && owner != "socket" exit;
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var itemIsBeingLooted = false;
var dropItem = noone; var itemPos = -1;
with obj_item_drop {
	if isBeingLooted && ds_list_find_index(items,other.id) != -1 {
		itemIsBeingLooted = true;
		dropItem = id;
		itemPos = ds_list_find_index(items,other.id);
	}
}

if (!global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY) && !itemIsBeingLooted 
	&& (global.fountainGui == noone)
	&& !global.isTrading
	{
	exit;
}

if type == ItemTypes.HandItem {
	if weaponType == UNARMED exit;
}

if (global.isWishing) {
	audio_play_sound(soundGrab,1,0);
	if global.fountainGui.currentMenu == INSERTGEM {
		if global.fountainGui.currentSubMenu == CHOOSEITEM {
			var si = instance_nearest(x,y,obj_fountain_gui_socketeditems);
			if ds_list_find_index(si.inv,id) != -1 {
				si.selectedItem = id;
			}
		} else if global.fountainGui.currentSubMenu == CHOOSEGEM {
			var gemsel = instance_nearest(x,y,obj_fountain_gui_gems);
			gemsel.selectedItem = id;
		}
	}
	else if global.fountainGui.currentMenu == BREAKDOWNITEM {
		if global.fountainGui.currentSubMenu == CHOOSEITEM {
			var gi = instance_nearest(x,y,obj_fountain_gui_gemmeditems);
			if ds_list_find_index(gi.inv,id) != -1 {
				gi.selectedItem = id;
			}
		}
	} else if global.fountainGui.currentMenu == REPAIRITEM {
		if global.fountainGui.currentSubMenu == CHOOSEITEM {
			var bi = instance_nearest(x,y,obj_fountain_gui_brokenitems);
			if ds_list_find_index(bi.inv,id) != -1 {
				bi.selectedItem = id;
			}
		}
	}
	exit;
}

// item selection in trading interface
/*
if global.isTrading {
	audio_play_sound(soundGrab,1,0);
	var playerItemsObj = obj_player_items;
	var vendorItemsObj = obj_vendor_items;
	// if item in inventory, it's the selectedItem of obj_player_items
	if ds_list_find_index(global.player.inventory,id) != -1 {
		playerItemsObj.selectedItem = id;
	} else {
		vendorItemsObj.selectedItem = id;
	}
} 
*/

// select this item if in inv or equipped items
if x1 >= global.inventory.invTopLeftX && x1 <= global.inventory.invBottomRightX 
	&& y1 >= global.inventory.invTopLeftY && y1 <= global.inventory.invBottomRightY {
		
	var idd = id;
	with obj_inventory {
		selectedItem = idd;
	}
	
	if global.ui.moveSelector.isActive {
		global.ui.moveSelector.x1 = x1;
		global.ui.moveSelector.y1 = y1;
	}
	
} else if ds_list_find_index(global.player.equippedItems,id) != -1 {
	var idd = id;
	with obj_equipped_items_manager {
		selectedItem = idd;
	}
	
	if global.ui.moveSelector.isActive {
		global.ui.moveSelector.x1 = x1;
		global.ui.moveSelector.y1 = y1;
	}
}
// probably being looted?
else {
	
}

var inv = global.inventory;
if global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY && point_in_rectangle(mouse_x,mouse_y,vx+inv.topLeftX,vy+inv.topLeftY,vx+inv.bottomRightX,vy+inv.bottomRightY)
{
	didClickStartInInventory = true;
	equipmentSlotBeforeDrag = noone;
} else if global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY {
	didClickStartInEquipment = true;
	equipmentSlotBeforeDrag = equipmentSlot;
}

//if type != ItemTypes.Other {
mightGrab = true;
//}