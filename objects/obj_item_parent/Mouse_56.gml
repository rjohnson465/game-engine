if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

// if released over another item (and not released over a slot to equip item)
if id == global.ui.grabbedItem {
	var nearestOtherItem = instance_nearest(x,y,obj_item_parent);
	var i = 1;
	while nearestOtherItem == id {
		nearestOtherItem = script_execute(scr_find_nth_closest,x,y,obj_item_parent,i);
		i++;
	}

	if position_meeting(x,y,nearestOtherItem) {
	
		var inv = global.player.inventory;
		var otherPosition = ds_list_find_index(inv,nearestOtherItem);
		var pos = ds_list_find_index(inv,id);
		ds_list_set(inv,pos,nearestOtherItem);
		ds_list_set(inv,otherPosition,id);
	
	}
	
	// if dropped somewhere in inventory and was equipped, unequip item
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	if	isEquipped 
		&& (mouse_x > vx + 212 && mouse_x < vx + 562) 
		&& (mouse_y > vy + 184 && mouse_y < vy + 400) 
		{
			
			isEquipped = false;
			var equippedItems = global.player.equippedItems;
			var currentKey = ds_map_find_first(equippedItems);
			var key = noone;
			var size = ds_map_size(equippedItems);
			for (var i = 0; i < size; i++){
				if ds_map_find_value(equippedItems,currentKey) == id {
					key = currentKey
				}
			    currentKey = ds_map_find_next(equippedItems, currentKey);
			}
			// TODO if it was a two handed item, need to delete its clone
			/*if !is_undefined(isTwoHanded) && isTwoHanded {
				// find its clone
				var clone = noone;
				var original = id;
				with(obj_hand_item_parent) {
					if cloneOf == original {
						clone = id;
					}
				}
				instance_destroy(clone,false);
			}*/
			if  key == EquipmentSlots.LeftHand1 || key == EquipmentSlots.LeftHand2 
				|| key == EquipmentSlots.RightHand1 || key == EquipmentSlots.RightHand2 
				{
					ds_map_replace(equippedItems, key, global.player.unarmed);
				} else {
					ds_map_replace(equippedItems, key, noone);
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

