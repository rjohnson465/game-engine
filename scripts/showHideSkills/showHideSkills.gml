if global.player.hp <= 0 exit;
isShowingMenus = !isShowingMenus;
currentMenu = SKILLS;
if isShowingMenus {
	// move any items that are equipped to their slots
	var equippedItems = global.player.equippedItems;
	for (var i = 0; i < ds_list_size(equippedItems); i++) {
		var equippedItem = ds_list_find_value(equippedItems,i);
		var equippedItemSlot = equippedItem.equipmentSlot;
		var slotObj = getEquipmentSlotObject(equippedItemSlot);
		
		equippedItem.x1 = slotObj.x1;
		equippedItem.y1 = slotObj.y1;
	}
} 

cursor_sprite = -1;

if !isShowingMenus {
	moveSelector.isActive = true;
	equipSelector.isActive = false;
	imbueSelector.isActive = false;
	equipSelector.acceptableEquipmentSlots = [];
	isShowingExplanations = false;
}