/// moveFountainInvSelector(direction)
/// @param direction "up" | "left" | "down" | "right"
/// must be called by obj_fountain_gui_*

var dir = argument[0];

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
				else if !is_undefined(ds_list_find_value(inv, 19 + (5*scrollLevel))) {
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
				if item.x1 < selectedItem.x1 doSwitch = true; break;
			}
			case "right" : {
				var a = item.x1;
				var b = selectedItem.x1;
				if item.x1 > selectedItem.x1 {
					doSwitch = true; 
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