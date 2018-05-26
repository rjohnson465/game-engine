if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

// do not attempt a swap with an equipped item
//if id == global.ui.grabbedItem && equipmentSlot != noone exit;

// if released over another item (and not released over a slot to equip item)
if id == global.ui.grabbedItem {
	
	// if dropped somewhere in inventory and was equipped, unequip item
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
		
	if !isItemEquipped(id) {
	
		var nearestOtherItem = instance_nearest(x,y,obj_item_parent);
		var i = 1;
		while nearestOtherItem == id {
			nearestOtherItem = script_execute(scr_find_nth_closest,x,y,obj_item_parent,i);
			i++;
		}
	
		if nearestOtherItem.object_index != obj_item_coins {

			if position_meeting(x,y,nearestOtherItem) && !position_meeting(x,y,obj_equipmentslot) {
				var inv = global.player.inventory;
				var otherPosition = ds_list_find_index(inv,nearestOtherItem);
				var pos = ds_list_find_index(inv,id);
				ds_list_set(inv,pos,nearestOtherItem);
				ds_list_set(inv,otherPosition,id);
	
			}
		} 
	}
	isGrabbed = false;
	grabFrame = 0;
	mightGrab = false;
	global.ui.grabbedItem = noone;
	cursor_sprite = -1;
	visible = false;
}
grabFrame = 0;

