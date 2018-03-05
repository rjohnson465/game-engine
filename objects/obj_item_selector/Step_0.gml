var pad = global.player.gamePadIndex;

// gamepad input
if gamepad_is_connected(pad) {
	
	// move selector left
	if gamepad_button_check_pressed(pad,gp_padl) {
		if !isActive || !ui.isShowingMenus exit;

		// move selector to next slot on left, if it exists
		if !isSelectorAtFirstInventoryColumn() && isSelectorInInventory() {
			x1 -= slotWidth;
			if isSelectorInInventory() {
				inv.selectedItem = getItemAtSelectorPosition(id);
			}
		}

		else if isSelectorInEquippedItems() {
			moveSelectorInEquippedItems("left");
			if !isSelectorInInventory {
				eq.selectedItem = getItemAtSelectorPosition(id);
			}
		}
	}
	
	// move selector right
	if gamepad_button_check_pressed(pad,gp_padr) {
		if !isActive || !ui.isShowingMenus exit;

		// move selector to next slot on right, if it exists
		if !isSelectorAtLastInventoryColumn() && isSelectorInInventory() {
			x1 += slotWidth;
			if isSelectorInInventory() {
				inv.selectedItem = getItemAtSelectorPosition(id);
			}
		} else if isSelectorAtLastInventoryColumn() {
			if type == SelectorTypes.Select {
				// go to lefthanditem1 slot
				var s = noone;
				with obj_equipmentslot {
					if slot == EquipmentSlots.LeftHand1 {
						s = id;
					}
				}
				if s == noone exit;
				x1 = s.x1;
				y1 = s.y1;
			}
		}

		else if isSelectorInEquippedItems() {
			moveSelectorInEquippedItems("right");
			eq.selectedItem = getItemAtSelectorPosition(id);
		}
	}
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) {
		if !isActive || !ui.isShowingMenus exit;

		if isSelectorInEquippedItems() {
			moveSelectorInEquippedItems("up");
			eq.selectedItem = getItemAtSelectorPosition(id);
		} 

		else if isSelectorInInventory {
	
			// if we're not at the highest row in inventory, move up
			if y1 > inv.invTopLeftY {
				y1 -= inv.slotHeight;
				inv.selectedItem = getItemAtSelectorPosition(id);
			}
	
	
			else if inv.scrollLevel != 0 {
				inv.scrollLevel--;
				inv.selectedItem = getItemAtSelectorPosition(id);
			}
		}
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) {
		if !isActive || !ui.isShowingMenus exit;

		if isSelectorInEquippedItems() {
			moveSelectorInEquippedItems("down");
			eq.selectedItem = getItemAtSelectorPosition(id);
		}

		else if isSelectorInInventory {
	
			if y1 < inv.invTopLeftY+(3*inv.slotHeight) {
		
				y1 += inv.slotHeight;
				if getItemAtSelectorPosition(id) {
					inv.selectedItem = getItemAtSelectorPosition(id);
				} else y1 -= inv.slotHeight;
			}
	
			// are there more items than shown?
			else {
				if !is_undefined(ds_list_find_value(global.player.inventory, 19 + (5*inv.scrollLevel))) {
					inv.scrollLevel++;
				}
			}
		}
	}
	
	// handle select / equip with selector
	if gamepad_button_check_pressed(pad,gp_face1) {
		if !isActive || !ui.isShowingMenus exit;

		// if item equipped items, enter "Equip Mode"
		switch type {
			// if selector type and hovering over an equipped item, activate the equip selector object
			case SelectorTypes.Select: {
				if isSelectorInEquippedItems() || isSelectorInInventory() {
					isActive = false;
					// find Equip selector and activate it (in End Step event)
				}
				break;
			}
			case SelectorTypes.Equip: {
				var moveSelector = ui.moveSelector;
				var equipSelector = id;
				var selectedEquipmentSlot = noone;
		
				// equipselector is in inventory
				if array_length_1d(ui.equipSelector.acceptableEquipmentSlots) == 0 {		
					with obj_equipmentslot {
						if x1 == moveSelector.x1 && y1 == moveSelector.y1 {
							selectedEquipmentSlot = id;
						}
					}
					equipItemVerbose(getItemAtSelectorPosition(id),selectedEquipmentSlot);
		
				}
				// equipSelector is in equipped items
				else {
					with obj_equipmentslot {
						if x1 == equipSelector.x1 && y1 == equipSelector.y1 {
							selectedEquipmentSlot = id;
						}
					}
					equipItemVerbose(getItemAtSelectorPosition(moveSelector),selectedEquipmentSlot);
					acceptableEquipmentSlots = [];
				}
				moveSelector.isActive = true;
				equipSelector.isActive = false;
		
				break;
			}
			case SelectorTypes.Imbue: {
			}
		}	
	} // end face1 button handling
	
	// handle canceling selector event (square / x button) or unequipping hovered item
	if gamepad_button_check_pressed(pad,gp_face3) {
		// if Equip or Imbue selectors are active, deactivate them and re-activate the Select selector
		if type == SelectorTypes.Equip || type == SelectorTypes.Imbue {
			isActive = false;
			acceptableEquipmentSlots = [];
			ui.moveSelector.isActive = true;	
		}
		
		// unequip selected item 
		if type == SelectorTypes.Select && isSelectorInEquippedItems {
			var item = getItemAtSelectorPosition(id);
			if item && isActive {
				unequipItem(getItemAtSelectorPosition(id));
			}
		}
	}
	
}