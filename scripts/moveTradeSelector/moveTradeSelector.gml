/// moveTradeSelector(direction)
/// @param direction "up" | "left" | "down" | "right"
/// must be called by obj_vendor_items || obj_player_items

var dir = argument[0];

if selectedItem == noone {
	selectedItem = ds_list_find_value(inv,0);
	if selectedItem == noone exit;
}

var closestItem = selectedItem; var closestDist = 10000;
for (var i = 0; i < ds_list_size(inv); i++) {

	var item = ds_list_find_value(inv,i);
	
	var distToSelectedItem = point_distance(item.x1,item.y1,selectedItem.x1,selectedItem.y1);
	
	if distToSelectedItem < closestDist {
		var doSwitch = false;
		switch dir {
			case "up" : {
				var a = selectedItem.y1;
				var b = invTopLeftY;
				if selectedItem.y1 > invTopLeftY {
					if item.y1 < selectedItem.y1 {
						doSwitch = true; 
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
					if item.y1 > selectedItem.y1 {
						doSwitch = true;
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
				var pred = (object_index == obj_player_items || (object_index == obj_vendor_items && selectedItem.x1 != invTopLeftX));
				if item.x1 < selectedItem.x1 && pred {
					doSwitch = true; 
				}
				else if (object_index == obj_player_items && selectedItem.x1 == invTopLeftX) {
					// nearest item in obj_vendor_item's inv
					var vendorItemsObj = obj_vendor_items;
					var vinv = vendorItemsObj.inv;
					if ds_exists(vinv,ds_type_list) {
						var closestVitem = ds_list_find_value(vinv,0); var closestDist = 10000;
						for (var j = 0; j < ds_list_size(vinv); j++) {
							var vitem = ds_list_find_value(vinv,j);
							var dist = point_distance(selectedItem.x1, selectedItem.y1, vitem.x1, vitem.y1);
							if dist < closestDist {
								closestDist = dist;
								closestVitem = vitem;
							}
						}
						vendorItemsObj.selectedItem = closestVitem;
					} else {
						vendorItemsObj.selectedItem = noone;
					}
					isActive = false;
					vendorItemsObj.isActive = true;
					vendorItemsObj.joystickInputFrame = 0;
					exit;
				}
				break;
			}
			case "right" : {
				var pred = (object_index == obj_player_items || (object_index == obj_vendor_items && selectedItem.x1 != invBottomRightX));
				var lastItem = ds_list_find_value(inv,ds_list_size(inv)-1);
				if item.x1 > selectedItem.x1 && pred {
					doSwitch = true; 
				}
				else if (object_index == obj_vendor_items && (selectedItem.x1 == invBottomRightX || selectedItem == lastItem)) {
					// nearest item in obj_vendor_item's inv
					var playerItemsObj = obj_player_items;
					var vinv = playerItemsObj.inv;
					if ds_exists(vinv,ds_type_list) {
						var closestVitem = ds_list_find_value(vinv,0); var closestDist = 10000;
						for (var j = 0; j < ds_list_size(vinv); j++) {
							var vitem = ds_list_find_value(vinv,j);
							
							var dist = point_distance(selectedItem.x1, selectedItem.y1, vitem.x1, vitem.y1);
							if dist < closestDist && vitem.x1 > 0 {
								closestDist = dist;
								closestVitem = vitem;
							}
						}
						playerItemsObj.selectedItem = closestVitem;
					} else {
						playerItemsObj.selectedItem = noone;
					}
					isActive = false;
					playerItemsObj.isActive = true;
					var pio = instance_nearest(x,y,obj_player_items);
					pio.joystickInputFrame = 0;
					exit;
				}
				break;
			}
		}
		if doSwitch {
			closestDist = distToSelectedItem;
			closestItem = item;
		}
	}
}
selectedItem = closestItem;