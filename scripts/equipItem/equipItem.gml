/// equipItem(item,slot)
/// @param item
/// @param slot

// Pre-Condition -- this item is able to to in this slot

var itemOriginal = argument[0];
var slot = argument[1];

var item  = noone;

// itemOriginal might actually be the copy; CHECK
if itemOriginal.copyOf != noone {
	var temp = itemOriginal;
	itemOriginal = itemOriginal.copyOf;
	item = temp;
}
else {
	// see if there is already a copy of item
	with itemOriginal.object_index {
		if copyOf == itemOriginal {
			item = id;
		}
	}

	if item == noone {
		with itemOriginal {
			item = instance_copy(false);
			item.copyOf = itemOriginal;
		}
	}
}

if item.type == ItemTypes.HandItem && item.weaponType == UNARMED exit;

// set equipmentSlot property for item and add it to equippedItems list
var equippedItems = global.player.equippedItems;
ds_list_add(equippedItems,item);
ds_list_add(equippedItems,itemOriginal);
item.equipmentSlot = slot;
itemOriginal.equipmentSlot = slot;

// set x1 and y1 values for newly equipped item
var equipmentSlotObj = getEquipmentSlotObject(slot);
item.x1 = equipmentSlotObj.x1;
item.y1 = equipmentSlotObj.y1;

// set equippedLimbItem if slot was LeftHand1 or RightHand1
if slot == EquipmentSlots.LeftHand1 {
	ds_map_replace(global.player.equippedLimbItems, "l", item);
	global.player.comboHitsToNextLevel = ds_map_find_value(global.player.comboHitsToNextLevelMap,item.weaponType);
} else if slot == EquipmentSlots.RightHand1 {
	ds_map_replace(global.player.equippedLimbItems, "r", item);
}

// update player defenses based on Head item defenses
if item.type == ItemTypes.Head {
	var currentDefense = ds_map_find_first(item.defenses);
	for (var i = 0; i < ds_map_size(item.defenses); i++) {
		var hatDefense = ds_map_find_value(item.defenses,currentDefense);
		var currentPlayerDefense = ds_map_find_value(global.player.defenses,currentDefense);
		// do not directly manipulate the defenses map ??? -- instead, update the base def val
		ds_map_replace(global.player.defenses,currentDefense,currentPlayerDefense+hatDefense);
		
		var defMap = ds_map_find_value(global.player.propertiesBaseValues,ModifiableProperties.Defenses);
		ds_map_replace(defMap,currentDefense,hatDefense);
		
		currentDefense = ds_map_find_next(item.defenses,currentDefense);
	}
}

updatePlayerPropertiesItem(item,true);

/*
// if this was the inventory selected item, its not anymore
if global.inventory.selectedItem == item {
	global.inventory.selectedItem = noone;
}
