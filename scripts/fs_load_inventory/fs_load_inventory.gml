/// fs_load_inventory(inventoryDataMap)
/// @param inventoryDataMap
/// creates inventory from save game file

// destroy all current enemy data objs
with obj_item_parent {
	var _name = object_get_name(object_index);
	var _owner = owner == global.player;
	var _is_not_ancestor = !object_is_ancestor(object_index,obj_unarmed_parent);
	var _is_unarmed_parent = object_index != obj_unarmed_parent;
	//if owner == global.player && !object_is_ancestor(object_index,obj_unarmed_parent) && object_index != obj_unarmed_parent {
	if _owner && _is_not_ancestor && _is_unarmed_parent {
		instance_destroy(id,1);
	}
}

var p = global.player;
ds_list_clear(p.equippedItems);
p.leftHandItem = p.unarmed;
p.rightHandItem = p.unarmed;
ds_map_replace(p.equippedLimbItems,"l",p.unarmed);
ds_map_replace(p.equippedLimbItems,"r",p.unarmed);
var lhi = p.leftHandItem;
var rhi = p.rightHandItem;
ds_list_clear(p.inventory);

var sd_inventory = argument[0];
var holdingList = ds_list_create(); 
var cv = ds_map_find_first(sd_inventory);
for (var j = 0; j < ds_map_size(sd_inventory); j++) {
	
	var sd_item = ds_map_find_value(sd_inventory,cv);
	var objName = ds_map_find_value(sd_item,"ObjectName");
	var objIndex = asset_get_index(objName);
	//var objIndexName = object_get_name(objIndex);
	
	var item = instance_create_depth(x,y,1,objIndex);
	item.owner = global.player;

	item.persistent = true;
	item.owner = global.player; // ensure player is created before inventory is loaded
	item.rarity = ds_map_find_value(sd_item,"Rarity");
	item.count = ds_map_find_value(sd_item,"Count");
	item.acceptableEquipmentSlots = ds_map_find_value(sd_item,"AcceptableEquipmentSlots");
	item.numberOfSockets = ds_map_find_value(sd_item,"NumberOfSockets");
	//item.durability = ds_map_find_value(sd_item,"Durability");
	//item.charges = ds_map_find_value(sd_item,"Charges");
	//item.ammo = ds_map_find_value(sd_item,"Ammo");
	
	// insert gems
	var gemsList = ds_map_find_value(sd_item,"SocketedGems");
	if gemsList != undefined && ds_exists(gemsList,ds_type_list) {
		for (var i = 0; i < ds_list_size(gemsList); i += 2) {
			//var gemArr = ds_list_find_value(gemsList,i);
			var gemObjIndex = asset_get_index(ds_list_find_value(gemsList,i));
			var gemCondition = ds_list_find_value(gemsList,i+1);
			insertGemIntoItem(makeGem(gemObjIndex,gemCondition),item);
		}
	}
	
	// populate item properties
	var propsList = ds_map_find_value(sd_item,"ItemProperties");
	if propsList != undefined && ds_exists(propsList,ds_type_list) && ds_list_size(propsList) > 0 {
		for (var i = 0; i < ds_list_size(propsList); i += 2) {
			var propArr = ds_list_find_value(propsList,i);
			//var prop = propArr[0];
			//var val = propArr[1];
			var prop = ds_list_find_value(propsList,i);
			var val = ds_list_find_value(propsList,i+1);
			if ds_exists(val,ds_type_list) && ds_list_size(val) == 2 {
				var macro = ds_list_find_value(val,0);
				var amnt = ds_list_find_value(val,1);
				val = [macro,amnt];
			}
			
			addItemProperty(item,prop,val);
		}
	}
	
	// populate item property modifiers
	var propsList = ds_map_find_value(sd_item,"ItemPropertyModifiers");
	if propsList != undefined && ds_exists(propsList,ds_type_list) && ds_list_size(propsList) > 0 {
		for (var i = 0; i < ds_list_size(propsList); i += 2) {
			var propArr = ds_list_find_value(propsList,i);
			var prop = ds_list_find_value(propsList,i);
			var val = ds_list_find_value(propsList,i+1);
			if ds_exists(val,ds_type_list) && ds_list_size(val) == 2 {
				var macro = ds_list_find_value(val,0);
				var amnt = ds_list_find_value(val,1);
				val = [macro,amnt];
			}
			
			ds_map_replace(item.itemPropertyModifiers,prop,val);
		}
	}
	applyBasePropertyModifiers(item);

	// if item is equipped, equip item
	item.equipmentSlot = ds_map_find_value(sd_item,"EquipmentSlot");
	if item.equipmentSlot != noone {
		equipItem(item,item.equipmentSlot);
	}

	// set an index flag property
	item.invIndex = cv;
	
	// add to holding list (to be sorted later)
	ds_list_add(holdingList,item);
	
	cv = ds_map_find_next(sd_inventory,cv);
}

// iterate again over items to ensure proper ordering
for (var i = 0; i < ds_list_size(holdingList); i++) {
	with obj_item_parent {
		if owner == global.player && invIndex == string(i) {
			//ds_list_add(global.player.inventory,id);
			addItemToInventory(id);
		}
	}
}

// avoid memory leak
ds_list_destroy(holdingList);

if global.player.leftHandItem == noone {
	global.player.leftHandItem = global.player.unarmed;
}
if global.player.rightHandItem == noone && !global.player.leftHandItem.isTwoHanded {
	global.player.rightHandItem = unarmed;
}
