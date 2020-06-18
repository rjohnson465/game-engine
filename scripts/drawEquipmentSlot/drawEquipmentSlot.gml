/// drawEquipmentSlot(x,y,slot)
/// @param x
/// @param y
/// @param slot

var xx = argument0;
var yy = argument1;
var slot = argument2;
var ui = global.ui; 

var drawDark = false;
with obj_item_selector {
	if x1 == xx && y1 == yy && (isActive) {
		drawDark = true;
	} 
}

var drawGreen = false;
if	arrayIncludes(ui.equipSelector.acceptableEquipmentSlots, slot)
	|| (ui.grabbedItem != noone && arrayIncludes(ui.grabbedItem.acceptableEquipmentSlots,slot))
	{
	drawGreen = true;
}

// if mouse over an acceptable equip slot, dark dark
var slotWidth = sprite_get_width(spr_item_slot);
if !gamepad_is_connected(global.player.gamePadIndex) && drawGreen && mouseOverGuiRect(xx, yy, xx + slotWidth, yy + slotWidth) {
	drawDark = true;
}

var drawBlack = false; 
var itemAtMoveSelector = getItemAtSelectorPosition(ui.moveSelector);
if	(slot == EquipmentSlots.RightHand1 && 
	arrayIncludes(ui.equipSelector.acceptableEquipmentSlots,EquipmentSlots.LeftHand1) &&
	(itemAtMoveSelector != undefined && instance_exists(itemAtMoveSelector) && itemAtMoveSelector.isTwoHanded) &&
	ui.equipSelector.y1 == getEquipmentSlotObject(EquipmentSlots.LeftHand1).y1)
	||
	(slot == EquipmentSlots.RightHand2 && 
	arrayIncludes(ui.equipSelector.acceptableEquipmentSlots,EquipmentSlots.LeftHand2) &&
	(itemAtMoveSelector != undefined && instance_exists(itemAtMoveSelector) && itemAtMoveSelector.isTwoHanded) &&
	ui.equipSelector.y1 == getEquipmentSlotObject(EquipmentSlots.LeftHand2).y1)
	{
	
	drawBlack = true;
}

// if this slot holds the equipment manager's selectd item, draw dark
var selectedItem = global.equippedItemsManager.selectedItem;
var itemSelectorAt = getItemAtSelectorPosition(global.ui.moveSelector);
if selectedItem != itemSelectorAt selectedItem = noone;
for (var i = 0; i < ds_list_size(global.player.equippedItems); i++) {
	var item = ds_list_find_value(global.player.equippedItems,i);
	if item == selectedItem && item.equipmentSlot == slot {
		drawDark = true;
	}
}

if drawGreen && drawDark {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_green,.5);
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_black,.5);
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,C_HIGHLIGHT,global.gameManager.selectedItemFilterAlpha);
}
else if drawGreen {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_green,.75);
} else if drawDark {
	
} else draw_sprite(spr_item_slot,1,xx,yy);


if drawBlack {
	// draw_sprite(spr_item_slot,1,xx,yy);
	var twoHandedItem = getItemAtSelectorPosition(ui.moveSelector);
	draw_sprite_ext(twoHandedItem.itemSprite,1,xx,yy,1,1,0,c_black,.5);
}


// draw slot type sprite
if slot == EquipmentSlots.RightHand1 || slot == EquipmentSlots.RightHand2 {
	draw_sprite_ext(spr_slot_main_hand,1,xx,yy,1,1,0,c_white,.1);
} else if slot == EquipmentSlots.LeftHand1 || slot == EquipmentSlots.LeftHand2 {
	draw_sprite_ext(spr_slot_off_hand,1,xx,yy,1,1,0,c_white,.1);
} else	if slot == EquipmentSlots.LeftRing1 || slot == EquipmentSlots.LeftRing2 
		|| slot == EquipmentSlots.RightRing1 || slot == EquipmentSlots.RightRing2 {
	draw_sprite_ext(spr_slot_ring,1,xx,yy,1,1,0,c_white,.1);
} else if slot == EquipmentSlots.Head {
	draw_sprite_ext(spr_slot_head,1,xx,yy,1,1,0,c_white,.1);
}