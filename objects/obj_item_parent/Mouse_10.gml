if global.inventory.isConfirmingDestroyItem exit;
var _p1 = ds_list_find_index(global.player.inventory,id);
var _p2 = !global.ui.isShowingMenus;
var _p3 = global.ui.currentMenu != INVENTORY;
if ds_list_find_index(global.player.inventory,id) != -1 && (!global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY) && global.fountainGui == noone && !global.isTrading exit;
if global.fountainGui != noone {
	var fm = global.fountainGui.currentMenu;
	if global.fountainGui.currentMenu == FOUNTAIN exit;
	else {
		switch global.fountainGui.currentMenu {
			case REPAIRITEM: {
				var inv = obj_fountain_gui_brokenitems.inv;
				if ds_list_find_index(inv, id) == -1 exit;
				break;
			}
			case INSERTGEM: {
				var inv = global.fountainGui.currentSubMenu == CHOOSEITEM ? obj_fountain_gui_socketeditems.inv : obj_fountain_gui_gems.inv;
				if ds_list_find_index(inv, id) == -1 exit;
				break;
			}
			case BREAKDOWNITEM: {
				var inv = obj_fountain_gui_gemmeditems.inv;
				if ds_list_find_index(inv, id) == -1 exit;
				break;
			}
		}
	}
}
if x1 > 0 && global.ui.grabbedItem != id audio_play_sound(snd_ui_option_change,1,0);
var itemIsBeingLooted = false;
var dropItem = noone; var itemPos = -1;
with obj_item_drop {
	if isBeingLooted && ds_list_find_index(items,other.id) != -1 {
		itemIsBeingLooted = true;
		dropItem = id;
		itemPos = ds_list_find_index(items,other.id);
	}
}

if itemIsBeingLooted {
	dropItem.selectedItem = id;
}

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

// maybe this is a reward item?
var isSelectingReward = false;
if instance_number(obj_item_reward) > 0 {
	isSelectingReward = true;
	var ir = instance_nearest(x, y, obj_item_reward); 
	if ir.isConfirming exit;
	ir.selectedItem = id;
}

// item selection in trading interface
if global.isTrading && !isSelectingReward {
	//audio_play_sound(soundGrab,1,0);
	var playerItemsObj = obj_player_items;
	var vendorItemsObj = obj_vendor_items;
	if playerItemsObj.isConfirming || vendorItemsObj.isConfirming exit;
	// if item in inventory, it's the selectedItem of obj_player_items
	if ds_list_find_index(global.player.inventory,id) != -1 {
		playerItemsObj.selectedItem = id;
	} else {
		vendorItemsObj.selectedItem = id;
	}
}



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
