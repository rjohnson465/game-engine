/// fs_load_inventory(inventoryDataMap)
/// @param inventoryDataMap
/// creates inventory from save game file
var sd_inventory = argument[0];

var p = global.player;
ds_list_clear(p.equippedItems);
p.leftHandItem = p.unarmed;
p.rightHandItem = p.unarmed;
ds_map_replace(p.equippedLimbItems,"l",p.unarmed);
ds_map_replace(p.equippedLimbItems,"r",p.unarmed);
var lhi = p.leftHandItem;
var rhi = p.rightHandItem;
ds_list_clear(p.inventory);


var holdingList = ds_list_create(); 
var cv = ds_map_find_first(sd_inventory);
for (var j = 0; j < ds_map_size(sd_inventory); j++) {
	
	var sd_item = ds_map_find_value(sd_inventory,cv);
	var objName = ds_map_find_value(sd_item,"ObjectName");
	var objIndex = asset_get_index(objName);
	
	var item = instance_create_depth(x,y,1,objIndex);
	
	item.persistent = true;
	item.owner = global.player; // ensure player is created before inventory is loaded
	item.rarity = ds_map_find_value(sd_item,"Rarity");
	item.count = ds_map_find_value(sd_item,"Count");
	item._pts = ds_map_find_value(sd_item,"Pts");
	item.acceptableEquipmentSlots = ds_map_find_value(sd_item,"AcceptableEquipmentSlots");
	item.numberOfSockets = ds_map_find_value(sd_item,"NumberOfSockets");
	item.durability = ds_map_find_value(sd_item,"Durability");
	item.ammo = ds_map_find_value(sd_item,"Ammo");
	item.charges = ds_map_find_value(sd_item,"Charges");
	
	
	// insert gems
	var gemsList = ds_map_find_value(sd_item,"SocketedGems");
	if gemsList != undefined && ds_exists(gemsList,ds_type_list) {
		for (var i = 0; i < ds_list_size(gemsList); i += 2) {
			var gemObjIndex = asset_get_index(ds_list_find_value(gemsList,i));
			var gemCondition = ds_list_find_value(gemsList,i+1);
			var gem = makeGem(gemObjIndex,gemCondition);
			insertGemIntoItem(gem,item);
		}
	}
	
	// populate item properties
	var propsList = ds_map_find_value(sd_item,"ItemProperties");
	if propsList != undefined && ds_exists(propsList,ds_type_list) && ds_list_size(propsList) > 0 {
		for (var i = 0; i < ds_list_size(propsList); i += 2) {
			var prop = ds_list_find_value(propsList,i);
			var val = ds_list_find_value(propsList,i+1);
			
			// props with macros are saved as formatted string "MACRO <val>"
			if is_string(val) {
				var index = string_pos(" ",val);
				var length = string_length(val);
				var macro = string_copy(val,0,index-1);
				var v = string_copy(val,index+1,20);
				v = real(v);
				val = [macro,v];
			}
			addItemProperty(item,prop,val);
		}
	}
	
	// populate item property modifiers
	var propsList2 = ds_map_find_value(sd_item,"ItemPropertyModifiers");
	if propsList2 != undefined && ds_exists(propsList2,ds_type_list) && ds_list_size(propsList2) > 0 {
		for (var i = 0; i < ds_list_size(propsList2); i += 2) {
			var prop = ds_list_find_value(propsList2,i);
			var val = ds_list_find_value(propsList2,i+1);
			// props with macros are saved as formatted string "MACRO <val>"
			if is_string(val) {
				var index = string_pos(" ",val);
				var length = string_length(val);
				var macro = string_copy(val,0,index-1);
				var v = string_copy(val,index+1,20);
				v = real(v);
				val = [macro,v];
			}
			ds_map_replace(item.itemPropertyModifiers,prop,val);
		}
	}
	applyBasePropertyModifiers(item);
	
	// populate item property modifiers pts
	var propsList = ds_map_find_value(sd_item,"ItemPropertyModifiersPts");
	if propsList != undefined && ds_exists(propsList,ds_type_list) && ds_list_size(propsList) > 0 {
		for (var i = 0; i < ds_list_size(propsList); i += 2) {
			var prop = ds_list_find_value(propsList,i);
			var val = ds_list_find_value(propsList2,i+1);
			// props with macros are saved as formatted string "MACRO <val>"
			if is_string(val) {
				var index = string_pos(" ",val);
				var length = string_length(val);
				var macro = string_copy(val,0,index-1);
				var v = string_copy(val,index+1,20);
				v = real(v);
				val = [macro,v];
			}
			ds_map_replace(item.itemPropertyModifiersPts,prop,val);
		}
	}

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
			addItemToInventory(id);
		}
		if !is_string(invIndex) && invIndex < 0 && !object_index == obj_unarmed_parent {
			instance_destroy(id,1);
		}
	}
}

// avoid memory leak
ds_list_destroy(holdingList); holdingList = -1;

if global.player.leftHandItem == noone {
	global.player.leftHandItem = global.player.unarmed;
}
if global.player.rightHandItem == noone && !global.player.leftHandItem.isTwoHanded {
	global.player.rightHandItem = unarmed;
}

var a = ds_list_create();
var b = ds_map_create();
ds_list_destroy(a); a = -1;
ds_map_destroy(b); b = -1;
