/// unequipItem(item)
/// @param item

var item = argument[0];
var slot = item.equipmentSlot;

// need to do this for player limb (hand) / weapon refresh
if item.equipmentSlot == EquipmentSlots.LeftHand1 {
	ds_map_replace(global.player.equippedLimbItems,"l",global.player.unarmed);
	global.player.leftHandItem = global.player.unarmed;
} else if item.equipmentSlot == EquipmentSlots.RightHand1 {
	ds_map_replace(global.player.equippedLimbItems,"r",global.player.unarmed);
	global.player.rightHandItem = global.player.unarmed;
}
			
// remove this item from player's equipped items list
if item.type == ItemTypes.HandItem && item.weaponType == UNARMED {
} else {
	ds_list_delete(global.player.equippedItems,ds_list_find_index(global.player.equippedItems,item));
	item.equipmentSlot = noone;
}

// Belt item handling

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
		
		unequipBeltItem(index);
		exit;
		
	}

// update player defenses based on Head item defenses
if item.type == ItemTypes.Head {
	var currentDefense = ds_map_find_first(item.defenses);
	for (var i = 0; i < ds_map_size(item.defenses); i++) {
		var hatDefense = ds_map_find_value(item.defenses,currentDefense);
		var currentPlayerDefense = ds_map_find_value(global.player.defenses,currentDefense);
		ds_map_replace(global.player.defenses,currentDefense,currentPlayerDefense-hatDefense);
		var defMap = ds_map_find_value(global.player.propertiesBaseValues,ModifiableProperties.Defenses);
		ds_map_replace(defMap,currentDefense,0);
		currentDefense = ds_map_find_next(item.defenses,currentDefense);
	}
}

updatePlayerPropertiesItem(item,false);

// add this item back to player inventory
//ds_list_add(global.player.inventory,item);
