/// drawEquipmentSlot(x,y,slot)
/// @param x
/// @param y
/// @param slot

var xx = argument0;
var yy = argument1;
var slot = argument2;

var drawDark = false;
with obj_item_selector {
	if x1 == xx && y1 == yy && (isActive || type == SelectorTypes.Select) {
		drawDark = true;
	} 
}

var drawGreen = false;
if arrayIncludes(global.ui.equipSelector.acceptableEquipmentSlots, slot) {
	drawGreen = true;
}
var drawBlack = false; 
if	(slot == EquipmentSlots.RightHand1 && 
	arrayIncludes(global.ui.equipSelector.acceptableEquipmentSlots,EquipmentSlots.LeftHand1) &&
	getItemAtSelectorPosition(global.ui.moveSelector).isTwoHanded)
	||
	(slot == EquipmentSlots.RightHand2 && 
	arrayIncludes(global.ui.equipSelector.acceptableEquipmentSlots,EquipmentSlots.LeftHand2) &&
	getItemAtSelectorPosition(global.ui.moveSelector).isTwoHanded)
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
	draw_line_color(xx,yy,xx+global.inventory.slotWidth,yy+global.inventory.slotHeight,c_red,c_red);
}
else draw_sprite(spr_item_slot,1,xx,yy);