/// fs_save_inventory
/// returns a map of all the inventory items
var sd_inventory = ds_map_create();
with obj_item_parent {
	
	if owner == global.player {
		var sd_item = ds_map_create();
	
		ds_map_replace(sd_item,"ObjectIndex",object_index);
		ds_map_replace(sd_item,"ObjectName",object_get_name(object_index));
		// All these things will be generated once instance is instantiated
		//ds_map_replace(sd_item,"Name",name); -- will be generated / fixed after gems
		//ds_map_replace(sd_item,"BaseName",baseName);
		//ds_map_replace(sd_item,"Description",name);
		// type
		// subType
		// spriteName / itemSprite
		// isSellable / isUsable
		// value -- should be calculated as item is generated
		
		ds_map_replace(sd_item,"Rarity",rarity);
		ds_map_replace(sd_item,"Count",count);
		ds_map_replace(sd_item,"AcceptableEquipmentSlots",acceptableEquipmentSlots);
		ds_map_replace(sd_item,"EquipmentSlot",equipmentSlot);
		ds_map_replace(sd_item,"NumberOfSockets",numberOfSockets);
		
		// saving socketed gems
		if ds_exists(socketedGems, ds_type_list) && ds_list_size(socketedGems) > 0 {
			var gemsList = ds_list_create(); // every 2 indexes describe 1 gem (index 0 - gem obj index, index 1 - gem condition...)
			for (var i = 0; i < ds_list_size(socketedGems); i++) {
				var gem = ds_list_find_value(socketedGems,i);
				
				//var gemData = [gem.object_index,gem.condition];
				
				
				ds_list_add(gemsList,gem.object_index);
				ds_list_add(gemsList,gem.condition);
			}
			//ds_map_replace(sd_item,"SocketedGems",gemsList);
			ds_map_add_list(sd_item,"SocketedGems",gemsList);
		}
		
		// saving item properties
		if ds_exists(itemProperties,ds_type_map) && ds_map_size(itemProperties) > 0 {
			var propsList = ds_list_create(); // list of kvp [prop,val]
			var currentProp = ds_map_find_first(itemProperties);
			for (var i = 0; i < ds_map_size(itemProperties); i++) {
				var val = ds_map_find_value(itemProperties,currentProp);
				
				//var list = ds_list_create();
				//ds_list_add(list,currentProp);
				//ds_list_add(list,val);
				
				//ds_list_add(propsList,[currentProp,val]);
				ds_list_add(propsList,currentProp);
				ds_list_add(propsList,val);
				currentProp = ds_map_find_next(itemProperties,currentProp);
			}
			//ds_map_replace(sd_item,"ItemProperties",propsList);
			ds_map_add_list(sd_item,"ItemProperties",propsList);
		}
		
		ds_map_replace(sd_item,"Durability",durability);
		ds_map_replace(sd_item,"DurabilityMax",durabilityMax);
		
		ds_map_replace(sd_item,"Charges",charges);
		ds_map_replace(sd_item,"ChargesMax",chargesMax);
		
		ds_map_replace(sd_item,"Ammo",ammo);
		ds_map_replace(sd_item,"AmmoMax",ammoMax);
	
		//var key = fs_generate_key(id); // TODO this is not guaranteed unique at all for items -- reference their location in inventory?
		var key = ds_list_find_index(global.player.inventory,id);
		// or maybe key can just be inventory index

		ds_map_add_map(sd_inventory,key,sd_item);
	}
}

return sd_inventory;