if global.ui.grabbedItem {
	var droppedItem = global.ui.grabbedItem;
	var leftHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand1);
	var leftHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand2);
	var rightHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand1);
	var rightHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand2);
	var equippedItems = global.player.equippedItems;
	var unarmed = global.player.unarmed;
	
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
		ds_map_replace(equippedItems, key, unarmed);
		droppedItem.isEquipped = false;
	} else {
		ds_map_replace(equippedItems, key, noone);
		droppedItem.isEquipped = false;
	}
	
	// equip dropped item (if dropped in proper slot)
	if slot == EquipmentSlots.LeftHand1 || slot == EquipmentSlots.LeftHand2 {
		if	(droppedItem.type == HandItemTypes.Shield 
			|| droppedItem.type == HandItemTypes.Melee 
			|| droppedItem.type == HandItemTypes.Ranged)
			//&& !droppedItem.isTwoHanded 
			{	
				if !droppedItem.isTwoHanded {
					if slot == EquipmentSlots.LeftHand1 {
						leftHandItem.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.LeftHand1,droppedItem);
						droppedItem.isEquipped = true;
						droppedItem.x1 = x1;
						droppedItem.y1 = y1;
						if rightHandItem.isTwoHanded {
							rightHandItem.isEquipped = false;
							ds_map_replace(equippedItems,EquipmentSlots.RightHand1,unarmed);
						}
					} else {
						leftHandItem2.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.LeftHand2,droppedItem);
						droppedItem.isEquipped = true;
						droppedItem.x1 = x1;
						droppedItem.y1 = y1;
						droppedItem.isEquipped = true;
						if rightHandItem2.isTwoHanded {
							rightHandItem2.isEquipped = false;
							ds_map_replace(equippedItems,EquipmentSlots.RightHand2,unarmed);
						}
					}
				} else if droppedItem.isTwoHanded {
					if slot == EquipmentSlots.LeftHand1 {
						leftHandItem.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.LeftHand1,unarmed);
						rightHandItem.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.RightHand1,droppedItem);
						droppedItem.isEquipped = true;
						droppedItem.x1 = global.ui.rightHandItem1Slot.x1;
						droppedItem.y1 = global.ui.rightHandItem1Slot.y1;
						// TODO -- have a copy item in the leftHandItem1Slot so users can still drag from there
						
						/*var droppedClone = noone;
						with (droppedItem) {
							var droppedItemClone = instance_copy(false);
							droppedItemClone.cloneOf = droppedItem;
						}
						droppedItemClone.x1 = x1;
						droppedItemClone.y1 = y1;*/
					}
					else {
						leftHandItem2.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.LeftHand2,unarmed);
						rightHandItem2.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.RightHand2,droppedItem);
						droppedItem.isEquipped = true;
						// item object needs to go to righthand2 slot coordinates, not lefthand2 coordinates
						droppedItem.x1 = global.ui.rightHandItem2Slot.x1;
						droppedItem.y1 = global.ui.rightHandItem2Slot.y1;
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
						ds_map_replace(equippedItems,EquipmentSlots.LeftHand1,unarmed);
					} else {
						leftHandItem2.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.LeftHand2,unarmed);
					}
				}
			}
	}
	// final else (wrong item / wrong slot)
	else {
		// if dropped item is already equipped anywhere else, unequip it from that slot
		/*var currentKey = ds_map_find_first(equippedItems);
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
			ds_map_replace(equippedItems, key, unarmed);
		} else {
			ds_map_replace(equippedItems, key, noone);
		}
		droppedItem.isEquipped = false;*/
	}
	
} 
