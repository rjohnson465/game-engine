if global.ui.grabbedItem {
	var droppedItem = global.ui.grabbedItem;
	var leftHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand1);
	var leftHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand2);
	var rightHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand1);
	var rightHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand2);
	var equippedItems = global.player.equippedItems;
	
	// if dropped item is already equipped anywhere else, unequip it from that slot
	var currentKey = ds_map_find_first(equippedItems);
	var key = noone;
	var size = ds_map_size(equippedItems);
	for (var i = 0; i < size; i++){
		if ds_map_find_value(equippedItems,currentKey) == droppedItem.id {
			key = currentKey
		}
		currentKey = ds_map_find_next(equippedItems, currentKey);
	}
	if  key == EquipmentSlots.LeftHand1 || key == EquipmentSlots.LeftHand2 
	|| key == EquipmentSlots.RightHand1 || key == EquipmentSlots.RightHand2 
	{
		ds_map_replace(equippedItems, key, global.player.unarmed);
	} else {
		ds_map_replace(equippedItems, key, noone);
	}
	//isEquipped = false;
	
	if slot == EquipmentSlots.LeftHand1 || slot == EquipmentSlots.LeftHand2 {
		if	(droppedItem.type == HandItemTypes.Shield 
			|| droppedItem.type == HandItemTypes.Melee 
			|| droppedItem.type == HandItemTypes.Ranged)
			&& !droppedItem.isTwoHanded 
			{	
				if slot == EquipmentSlots.LeftHand1 {
					leftHandItem.isEquipped = false;
					ds_map_replace(equippedItems,EquipmentSlots.LeftHand1,droppedItem);
					droppedItem.isEquipped = true;
					droppedItem.x1 = x1;
					droppedItem.y1 = y1;
					if rightHandItem.isTwoHanded {
						rightHandItem.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.RightHand1,global.player.unarmed);
					}
				} else {
					leftHandItem2.isEquipped = false;
					ds_map_replace(equippedItems,EquipmentSlots.LeftHand2,droppedItem);
					droppedItem.isEquipped = true;
					if rightHandItem2.isTwoHanded {
						rightHandItem2.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.RightHand2,global.player.unarmed);
					}
				}
			}
	} else if slot == EquipmentSlots.RightHand1 || slot == EquipmentSlots.RightHand2 {
		// shields cannot be put in the right hand
		if	(droppedItem.type == HandItemTypes.Melee 
			|| droppedItem.type == HandItemTypes.Ranged) {
				if slot == EquipmentSlots.RightHand1 {
					rightHandItem.isEquipped = false;
					ds_map_replace(equippedItems,EquipmentSlots.RightHand1,droppedItem);
					droppedItem.isEquipped = true;
					droppedItem.x1 = x1;
					droppedItem.y1 = y1;
				} else {
					rightHandItem2.isEquipped = false;
					ds_map_replace(equippedItems,EquipmentSlots.RightHand2,droppedItem);
					droppedItem.isEquipped = true;
					droppedItem.x1 = x1;
					droppedItem.y1 = y1;
				}
				
				if droppedItem.isTwoHanded {
					if slot == EquipmentSlots.RightHand1 {
						leftHandItem.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.LeftHand1,global.player.unarmed);
					} else {
						leftHandItem2.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.LeftHand2,global.player.unarmed);
					}
				}
			}
	}
	
} 
