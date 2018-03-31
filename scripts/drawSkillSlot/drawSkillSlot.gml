/// drawSkillSlot(x,y,slot)
/// @param x
/// @param y
/// @param slot

var xx = argument0;
var yy = argument1;
var slot = argument2;
var ui = global.ui; 

var drawDark = false;
with obj_skill_selector {
	if x1 == xx && y1 == yy {
		drawDark = true;
	} 
}
if drawDark {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_gray,.75);
} else {
	draw_sprite(spr_item_slot,1,xx,yy);
}



/*
var drawDark = false;
with obj_item_selector {
	if x1 == xx && y1 == yy && (isActive || type == SelectorTypes.Select) {
		drawDark = true;
	} 
}

var drawGreen = false;
if	arrayIncludes(ui.equipSelector.acceptableEquipmentSlots, slot)
	|| (ui.grabbedItem != noone && arrayIncludes(ui.grabbedItem.acceptableEquipmentSlots,slot))
	{
	drawGreen = true;
}
var drawBlack = false; 
if	(slot == EquipmentSlots.RightHand1 && 
	arrayIncludes(ui.equipSelector.acceptableEquipmentSlots,EquipmentSlots.LeftHand1) &&
	getItemAtSelectorPosition(ui.moveSelector).isTwoHanded &&
	ui.equipSelector.x1 == getEquipmentSlotObject(EquipmentSlots.LeftHand1).x1)
	||
	(slot == EquipmentSlots.RightHand2 && 
	arrayIncludes(ui.equipSelector.acceptableEquipmentSlots,EquipmentSlots.LeftHand2) &&
	getItemAtSelectorPosition(ui.moveSelector).isTwoHanded &&
	ui.equipSelector.x1 == getEquipmentSlotObject(EquipmentSlots.LeftHand2).x1)
	{
	drawBlack = true;
}

// if this slot holds the equipment manager's selectd item, draw dark

var selectedItem = global.equippedItemsManager.selectedItem;
for (var i = 0; i < ds_list_size(global.player.equippedItems); i++) {
	var item = ds_list_find_value(global.player.equippedItems,i);
	if item == selectedItem && item.equipmentSlot == slot {
		drawDark = true;
	}
}

if drawGreen && drawDark {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_green,.5);
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_black,.5);
}
else if drawGreen {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_green,.75);
} else if drawDark {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_gray,.75);
} else if drawBlack {
	draw_sprite(spr_item_slot,1,xx,yy);
	var twoHandedItem = getItemAtSelectorPosition(ui.moveSelector);
	draw_sprite_ext(twoHandedItem.itemSprite,1,xx,yy,1,1,0,c_black,.5);
	//draw_line_color(xx,yy,xx+global.inventory.slotWidth,yy+global.inventory.slotHeight,c_red,c_red);
}
else draw_sprite(spr_item_slot,1,xx,yy);

// draw slot type sprite
if slot == EquipmentSlots.LeftHand1 || slot == EquipmentSlots.LeftHand2 {
	draw_sprite_ext(spr_slot_main_hand,1,xx,yy,1,1,0,c_white,.1);
} else if slot == EquipmentSlots.RightHand1 || slot == EquipmentSlots.RightHand2 {
	draw_sprite_ext(spr_slot_off_hand,1,xx,yy,1,1,0,c_white,.1);
} else	if slot == EquipmentSlots.LeftRing1 || slot == EquipmentSlots.LeftRing2 
		|| slot == EquipmentSlots.RightRing1 || slot == EquipmentSlots.RightRing2 {
	draw_sprite_ext(spr_slot_ring,1,xx,yy,1,1,0,c_white,.1);
} else if slot == EquipmentSlots.Head {
	draw_sprite_ext(spr_slot_head,1,xx,yy,1,1,0,c_white,.1);
}