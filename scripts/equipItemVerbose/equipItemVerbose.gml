/// equipItemVerbose(item,slot)
/// @param item
/// @param slot

// item to equip. This function handles all idiosyncracies for various equipment slots

var droppedItem = argument0;
var slotObj = argument1;
var equippedItems = global.player.equippedItems;
var unarmed = global.player.unarmed;

with slotObj {
	// first, make sure the dropped item can go in this slot 
	var handItemPredicate = droppedItem.type == ItemTypes.HandItem 
							&& (slot == EquipmentSlots.LeftHand1 || slot == EquipmentSlots.LeftHand2 ||
							slot == EquipmentSlots.RightHand1 || slot == EquipmentSlots.RightHand2);
	// TODO add more predicates to determine dropped item can go in this slot (for Rings and Head)
	if handItemPredicate {		
		
		// if this item was equipped anywhere else, unequip it from that slot
		if droppedItem.equipmentSlot != noone {
			unequipItem(droppedItem);
		}
		
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
					if alreadyEquippedItem != droppedItem && alreadyEquippedItem.copyOf != droppedItem  {
						with alreadyEquippedItem {
							instance_destroy();
						}
					}
				}
				
				var itemInOtherSlot = getItemInEquipmentSlot(otherSlot);
				if itemInOtherSlot && itemInOtherSlot.spriteName != "unarmed" {
					unequipItem(itemInOtherSlot);
					if itemInOtherSlot != droppedItem && itemInOtherSlot.copyOf != droppedItem  {
						with itemInOtherSlot {
							instance_destroy();
						}
					}
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
					if alreadyEquippedItem != droppedItem && alreadyEquippedItem.copyOf != droppedItem  {
						with alreadyEquippedItem {
							instance_destroy();
						}
					}
				}
			}
			// 3)
			if !droppedItem.isTwoHanded {
				var alreadyEquippedItem = getItemInEquipmentSlot(slot);
				if alreadyEquippedItem && alreadyEquippedItem.spriteName != "unarmed" {
					unequipItem(alreadyEquippedItem);
					if alreadyEquippedItem != droppedItem/* && alreadyEquippedItem.copyOf != droppedItem */{
						with alreadyEquippedItem {
							instance_destroy();
						}
					}
				}
				// check if companion slot OR this slot has a 2h item
				var itemInOtherSlot = getItemInEquipmentSlot(otherSlot);
				if itemInOtherSlot.isTwoHanded {
					unequipItem(itemInOtherSlot);
					if itemInOtherSlot != droppedItem && itemInOtherSlot.copyOf != droppedItem  {
						with itemInOtherSlot {
							instance_destroy();
						}
					}
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
}