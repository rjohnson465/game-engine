/// fs_save_inventory
/// returns a map of all the inventory items
var sd_inventory = ds_map_create(); // this is the only ds that should survive 
with obj_item_parent {
	
	if owner == global.player {
		
		var key = ds_list_find_index(global.player.inventory,id);
		if key == -1 {
			continue;
		}
		
		var sd_item = ds_map_create();
		ds_map_replace(sd_item,"ObjectIndex",object_index);
		ds_map_replace(sd_item,"ObjectName",object_get_name(object_index));
		
		ds_map_replace(sd_item,"Rarity",rarity);
		ds_map_replace(sd_item,"Count",count);
		ds_map_replace(sd_item,"Pts",_pts);
		ds_map_replace(sd_item,"AcceptableEquipmentSlots",acceptableEquipmentSlots);
		ds_map_replace(sd_item,"EquipmentSlot",equipmentSlot);
		ds_map_replace(sd_item,"NumberOfSockets",numberOfSockets);
		ds_map_replace(sd_item,"Durability",durability);
		ds_map_replace(sd_item,"Charges",charges);
		ds_map_replace(sd_item,"Ammo",ammo);
		ds_map_replace(sd_item, "BeltItemIndex", beltItemIndex);
		ds_map_replace(sd_item, "CanUse", canUse);
		// some descriptions (i.e. health flask) may change based on stats, so remember them when save
		ds_map_replace(sd_item, "Description", description);
		
		// rings need to remember what their sprite is, as it is variable on create
		if type == ItemTypes.Ring {
			ds_map_replace(sd_item, "ItemSpriteName", itemSpriteName);
		}
		
		// keys need to remember keySpriteName and keySpriteIndex
		if object_index == obj_item_key {
			ds_map_replace(sd_item, "KeyName", name); //??
			ds_map_replace(sd_item, "KeyDescription", description);
			ds_map_replace(sd_item, "KeySpriteName", spriteName);
			ds_map_replace(sd_item, "KeySpriteIndexName", keySpriteIndexName);
		}
		
		// Gems / pieces must remember condition
		if object_is_ancestor(object_index, obj_gem_parent) || object_is_ancestor(object_index, obj_gempieces_parent) {
			ds_map_replace(sd_item, "Condition", condition);
		}
		
		var customItemPropertiesCopy = ds_map_deep_clone(customItemProperties);
		ds_map_add_map(sd_item,"CustomItemProperties", customItemPropertiesCopy);
		
		
		// saving socketed gems
		if ds_exists(socketedGems, ds_type_list) && ds_list_size(socketedGems) > 0 {
			var gemsList = ds_list_create(); // every 2 indexes describe 1 gem (index 0 - gem obj index, index 1 - gem condition...)
			for (var i = 0; i < ds_list_size(socketedGems); i++) {
				var gem = ds_list_find_value(socketedGems,i);
				ds_list_add(gemsList,object_get_name(gem.object_index));
				ds_list_add(gemsList,gem.condition);
			}
			ds_map_add_list(sd_item,"SocketedGems",gemsList);
		}
		
		
		// saving item property modifiers
		if ds_exists(itemPropertyModifiers,ds_type_map) && ds_map_size(itemPropertyModifiers) > 0 {
			var propsList = ds_list_create(); // list of kvp [prop,val]
			var currentProp = ds_map_find_first(itemPropertyModifiers);
			for (var i = 0; i < ds_map_size(itemPropertyModifiers); i++) {
				var val = ds_map_find_value(itemPropertyModifiers,currentProp);
				
				// save as formatted string for macro / val arrays (otherwise we have to save / load lists, which are fickle)
				if is_array(val) {
					var macro = val[0];
					var v = val[1];
					val = string(macro) + " " + string(v);
				}
				
				ds_list_add(propsList,currentProp);
				ds_list_add(propsList,val);
				currentProp = ds_map_find_next(itemPropertyModifiers,currentProp);
			}
			ds_map_add_list(sd_item,"ItemPropertyModifiers",propsList);
		}
		
		// saving item property modifiers pts
		if ds_exists(itemPropertyModifiersPts,ds_type_map) && ds_map_size(itemPropertyModifiersPts) > 0 {
			var propsList = ds_list_create(); // list of kvp [prop,val]
			var currentProp = ds_map_find_first(itemPropertyModifiersPts);
			for (var i = 0; i < ds_map_size(itemPropertyModifiersPts); i++) {
				var val = ds_map_find_value(itemPropertyModifiersPts,currentProp);
				
				// save as formatted string for macro / val arrays (otherwise we have to save / load lists, which are fickle)
				if is_array(val) {
					var macro = val[0];
					var v = val[1];
					val = string(macro) + " " + string(v);
				}
				
				ds_list_add(propsList,currentProp);
				ds_list_add(propsList,val);
				currentProp = ds_map_find_next(itemPropertyModifiersPts,currentProp);
			}
			ds_map_add_list(sd_item,"ItemPropertyModifiersPts",propsList);
		}
		
		// saving item properties
		if ds_exists(itemProperties,ds_type_map) && ds_map_size(itemProperties) > 0 {
			var propsList = ds_list_create(); // list of kvp [prop,val]
			var currentProp = ds_map_find_first(itemProperties);
			for (var i = 0; i < ds_map_size(itemProperties); i++) {
				var val = ds_map_find_value(itemProperties,currentProp);
				
				// save as formatted string for macro / val arrays (otherwise we have to save / load lists, which are fickle)
				if is_array(val) {
					var macro = val[0];
					var v = val[1];
					val = string(macro) + " " + string(v);
				}
				
				ds_list_add(propsList,currentProp);
				ds_list_add(propsList,val);
				currentProp = ds_map_find_next(itemProperties,currentProp);
			}
			ds_map_add_list(sd_item,"ItemProperties",propsList);
		} 
		
		// or maybe key can just be inventory index
		ds_map_add_map(sd_inventory,key,sd_item);
	}
}

return sd_inventory;