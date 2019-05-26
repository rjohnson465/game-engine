/// equipItem(item,slot)
/// @param item
/// @param slot

// Pre-Condition -- this item is able to to in this slot

var item = argument[0];
var slot = argument[1];

if item.type == ItemTypes.HandItem && item.weaponType == UNARMED exit;

// set equipmentSlot property for item and add it to equippedItems list
var equippedItems = global.player.equippedItems;
ds_list_add(equippedItems,item);
item.equipmentSlot = slot;

if	slot == EquipmentSlots.BeltItem1 || 
	slot == EquipmentSlots.BeltItem2 ||
	slot == EquipmentSlots.BeltItem3 ||
	slot == EquipmentSlots.BeltItem4 ||
	slot == EquipmentSlots.BeltItem5 {
		
		var index = -1;
		
		switch (slot) {
			case EquipmentSlots.BeltItem1: {
				index = 0;
				break;
			}
			case EquipmentSlots.BeltItem2: {
				index = 1;
				break;
			}
			case EquipmentSlots.BeltItem3: {
				index = 2;
				break;
			}
			case EquipmentSlots.BeltItem4: {
				index = 3;
				break;
			}
			case EquipmentSlots.BeltItem5: {
				index = 4;
				break;
			}
		}
		
		equipBeltItem(index, item);
		
		exit;
	}

// set x1 and y1 values for newly equipped item
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
