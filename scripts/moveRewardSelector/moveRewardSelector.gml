/// moveRewardSelector(direction)
/// @param direction "up" | "left" | "down" | "right"
/// must be called by obj_vendor_items || obj_player_items

var dir = argument[0];

if selectedItem == noone {
	selectedItem = ds_list_find_value(inv,0);
	if selectedItem == noone exit;
}
audio_play_sound(snd_ui_option_change,1,0);
var closestItem = selectedItem; var closestDist = 10000;
for (var i = 0; i < ds_list_size(inv); i++) {

	var item = ds_list_find_value(inv,i);
	
	var distToSelectedItem = point_distance(item.x1,item.y1,selectedItem.x1,selectedItem.y1);
	
	if distToSelectedItem < closestDist {

		switch dir {
			case "up" : {
				if selectedItem.y1 > invTopLeftY {
					if selectedItem != item && item.y1 < selectedItem.y1 {
						if point_distance(selectedItem.x1, selectedItem.y1, item.x1, item.y1) < closestDist {	
							closestDist = distToSelectedItem;
							closestItem = item; 
						}
					}
				}
				else if scrollLevel != 0 {
					scrollLevel--; 
					var currentPos = ds_list_find_index(inv,selectedItem);
					selectedItem = ds_list_find_value(inv,currentPos-5);
					exit;
				}
				break;
			}
			case "down" : {
				// main -- selected item is not at the bottom of shown elements
				if selectedItem.y1 < invTopLeftY+(3*slotHeight) {
					if selectedItem != item && item.y1 > selectedItem.y1 {
						if point_distance(selectedItem.x1, selectedItem.y1, item.x1, item.y1) < closestDist {	
							closestDist = distToSelectedItem;
							closestItem = item; 
						}
					}
				}
				
				// selected item is at the bottom of shown elements -- scroll down
				else if !is_undefined(ds_list_find_value(inv, 20 + (5*scrollLevel))) {
					scrollLevel++; 
					var currentPos = ds_list_find_index(inv,selectedItem);
					for (var i = 5; i >= 0; i--) {
						if ds_list_size(inv) >= currentPos+i && ds_list_find_value(inv,currentPos+i) != undefined {
							selectedItem = ds_list_find_value(inv,currentPos+i);
							exit;
						}
					}
					exit;
				}
				
				break;
			}
			case "left" : {
				if ds_exists(inv,ds_type_list) {
					var closestVitem = selectedItem; var closestDist = 10000;
					for (var j = 0; j < ds_list_size(inv); j++) {
						var vitem = ds_list_find_value(inv,j);
						if vitem == selectedItem continue;
						var dist = point_distance(selectedItem.x1, selectedItem.y1, vitem.x1, vitem.y1);
						if dist < closestDist && vitem.x1 < selectedItem.x1 {
							closestDist = dist;
							closestVitem = vitem;
						}
					}
					selectedItem = closestVitem;
				} else {
					selectedItem = noone;
				}
				isActive = true;
				joystickInputFrame = 0;
				exit;
				break;
			}
			case "right" : {
				if ds_exists(inv,ds_type_list) {
					var closestVitem = selectedItem; var closestDist = 10000;
					for (var j = 0; j < ds_list_size(inv); j++) {
						var vitem = ds_list_find_value(inv,j);
						if vitem == selectedItem continue;
						var dist = point_distance(selectedItem.x1, selectedItem.y1, vitem.x1, vitem.y1);
						if dist < closestDist && vitem.x1 > selectedItem.x1 {
							closestDist = dist;
							closestVitem = vitem;
						}
					}
					selectedItem = closestVitem;
				} else {
					selectedItem = noone;
				}
				isActive = true;
				joystickInputFrame = 0;
				exit;
				break;
			}
		}

	}
}
selectedItem = closestItem;