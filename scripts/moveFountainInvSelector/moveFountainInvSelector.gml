/// moveFountainInvSelector(direction)
/// @param direction "up" | "left" | "down" | "right"
/// must be called by obj_item_drop

var dir = argument[0];

var closestItem = selectedItem; var closestDist = 10000;
for (var i = 0; i < ds_list_size(inv); i++) {

	var item = ds_list_find_value(inv,i);
	
	var distToSelectedItem = point_distance(item.x1,item.y1,selectedItem.x1,selectedItem.y1);
	
	if distToSelectedItem < closestDist {
		var doSwitch = false;
		switch dir {
			case "up" : {
				if item.y1 < selectedItem.y1 doSwitch = true; break;
			}
			case "down" : {
				if item.y1 > selectedItem.y1 doSwitch = true; break;
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