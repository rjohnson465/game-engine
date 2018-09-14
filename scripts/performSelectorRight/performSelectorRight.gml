if !isActive || !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;
audio_play_sound(snd_ui_option_change,1,0);
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