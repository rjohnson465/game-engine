/// filterInvItems(allInvItemsList, filter)
/// @param allInvItemsList
/// @param filter

/// Calling instance MUST have dynamic inv list

var inventory = argument[0];
var filter = argument[1];

if !ds_exists(inventory, ds_type_list) exit;

for (var i = 0; i < ds_list_size(inventory); i++) {
	var el = ds_list_find_value(inventory, i);
	switch filter {
		case InventoryFilters.Melee: {
			if (el.subType != HandItemTypes.Melee || !object_is_ancestor(el.object_index,obj_hand_item_parent)) && (!object_is_ancestor(el.object_index, obj_shield_parent)) {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
		case InventoryFilters.Ranged: {
			if el.subType != HandItemTypes.Ranged || !object_is_ancestor(el.object_index,obj_hand_item_parent) {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
		case InventoryFilters.Rings: {
			if el.type != ItemTypes.Ring {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
		case InventoryFilters.Head: {
			if el.type != ItemTypes.Head {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
		case InventoryFilters.Other: {
			if el.type != ItemTypes.Other {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
		case InventoryFilters.Keys: {
			if el.type != ItemTypes.Key {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
		case InventoryFilters.Gems: {
			if el.type != ItemTypes.Gem {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
	}
}

