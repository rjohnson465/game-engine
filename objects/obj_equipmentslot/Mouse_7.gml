if global.ui.grabbedItem {
	
	var droppedItem = global.ui.grabbedItem;
	var equippedItems = global.player.equippedItems;
	var unarmed = global.player.unarmed;
	
	// first, make sure the dropped item can go in this slot 
	var handItemPredicate = droppedItem.type == ItemTypes.HandItem 
							&& (slot == EquipmentSlots.LeftHand1 || slot == EquipmentSlots.LeftHand2 ||
							slot == EquipmentSlots.RightHand1 || slot == EquipmentSlots.RightHand2);
	// TODO add more predicates to determine dropped item can go in this slot (for Rings and Head)
	if handItemPredicate {		
		var actualSlot = slot;
		// I. unequip anything that will be replaced by this dropped item
		
		// there are some special cases for hand items 
		// 1) 2H items take up both slots for a weapon set
		// 2) Shields must always be in the left slot of a weapon set
		// 3) If a hand item is dropped into a set w/ a 2h item, unequip that 2h item
		if droppedItem.type == ItemTypes.HandItem {
			
			var otherSlot = noone;
			switch (slot) {
				case EquipmentSlots.LeftHand1: {
					otherSlot = EquipmentSlots.RightHand1;
					break;
				}
				case EquipmentSlots.LeftHand2: {
					otherSlot = EquipmentSlots.RightHand2;
					break;
				}
				case EquipmentSlots.RightHand1: {
					otherSlot = EquipmentSlots.LeftHand1;
					break;
				}
				case EquipmentSlots.RightHand2: {
					otherSlot = EquipmentSlots.LeftHand2;
					break;
				}
			}
				
			// 1)
			if droppedItem.isTwoHanded {
				switch (slot) {
					case EquipmentSlots.LeftHand1: {
						actualSlot = EquipmentSlots.RightHand1;
						break;
					}
					case EquipmentSlots.LeftHand2: {
						actualSlot = EquipmentSlots.RightHand2;
						break;
					}
				}
				// unequip items on this slot and its "otherSlot" companion to make room for 2h item
				var alreadyEquippedItem = getItemInEquipmentSlot(slot);
				if alreadyEquippedItem && alreadyEquippedItem.spriteName != "unarmed" {
					unequipItem(alreadyEquippedItem);
				}
				var alreadyEquippedItem = getItemInEquipmentSlot(otherSlot);
				if alreadyEquippedItem && alreadyEquippedItem.spriteName != "unarmed" {
					unequipItem(alreadyEquippedItem);
				}
			}
			// 2) 
			else if droppedItem.subType == HandItemTypes.Shield {
				if slot == EquipmentSlots.RightHand1 {
					actualSlot = EquipmentSlots.LeftHand1;
				} else if slot == EquipmentSlots.RightHand2 {
					actualSlot = EquipmentSlots.LeftHand2;
				}
				// if there's something equipped in actualSlot, unequip that
				var alreadyEquippedItem = getItemInEquipmentSlot(actualSlot);
				if alreadyEquippedItem && alreadyEquippedItem.spriteName != "unarmed" {
					unequipItem(alreadyEquippedItem);
				}
			}
			// 3)
			if !droppedItem.isTwoHanded {
				var alreadyEquippedItem = getItemInEquipmentSlot(slot);
				if alreadyEquippedItem && alreadyEquippedItem.spriteName != "unarmed" {
					unequipItem(alreadyEquippedItem);
				}
				// check if companion slot OR this slot has a 2h item
				var itemInOtherSlot = getItemInEquipmentSlot(otherSlot);
				if itemInOtherSlot.isTwoHanded {
					unequipItem(itemInOtherSlot);
				}
			}
		}
		// rings / headwear is nice and easy -- just unequip whatever was in that slot before
		else {
			// if dropped item is already equipped anywhere else, unequip it from that slot
			var alreadyEquippedItem = getItemInEquipmentSlot(slot);
			if alreadyEquippedItem && alreadyEquippedItem.spriteName != "unarmed" {
				unequipItem(alreadyEquippedItem);
			}
		}
		
		// equip the item to this slot
		equipItem(droppedItem,actualSlot);
		
	}

	
	
	/*
	// equip dropped item (if dropped in proper slot)
	if slot == EquipmentSlots.LeftHand1 || slot == EquipmentSlots.LeftHand2 {
		if	(droppedItem.type == HandItemTypes.Shield 
			|| droppedItem.type == HandItemTypes.Melee 
			|| droppedItem.type == HandItemTypes.Ranged)
			{	
				if !droppedItem.isTwoHanded {
					if slot == EquipmentSlots.LeftHand1 {
						leftHandItem.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.LeftHand1,droppedItem);
						ds_map_replace(global.player.equippedLimbItems,"l",droppedItem);
						droppedItem.isEquipped = true;
						droppedItem.equipmentSlot = slot;
						droppedItem.x1 = x1;
						droppedItem.y1 = y1;
						if rightHandItem.isTwoHanded {
							rightHandItem.isEquipped = false;
							ds_map_replace(equippedItems,EquipmentSlots.RightHand1,unarmed);
							ds_map_replace(global.player.equippedLimbItems,"r",unarmed);
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
						ds_map_replace(global.player.equippedLimbItems,"l",unarmed);
						rightHandItem.isEquipped = false;
						ds_map_replace(equippedItems,EquipmentSlots.RightHand1,droppedItem);
						ds_map_replace(global.player.equippedLimbItems,"r",droppedItem);
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
						droppedItemClone.y1 = y1;
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
					ds_map_replace(global.player.equippedLimbItems,"r",droppedItem);
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
						ds_map_replace(global.player.equippedLimbItems,"l",droppedItem);
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
		droppedItem.isEquipped = false;
	}*/
	
} 
