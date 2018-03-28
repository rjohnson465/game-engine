/// addItemToInventory(item)
/// @param item

var item = argument0;
var p = global.player;

if item.isStackable {
	// check if there's another item of this object_index in inventory
	var stack = noone;
	for (var i = 0; i < ds_list_size(p.inventory); i++) {
		var el = ds_list_find_value(p.inventory,i);
		if object_is_ancestor(el.object_index,obj_gem_parent) {
			if el.object_index == item.object_index && el.condition == item.condition {
				stack = el;
			}
		}
		else if el.object_index == item.object_index {
			stack = el;
		}
	}
	if stack != noone {
		stack.count++;
	} else {
		ds_list_add(p.inventory,item);
		if !item.persistent {
			item.persistent = true;
		}
	}
} else {
	ds_list_add(p.inventory,item);
	if !item.persistent {
		item.persistent = true;
	}
}



