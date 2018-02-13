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


// if this slot holds the equipment manager's selectd item, draw dark

var selectedItem = global.equippedItemsManager.selectedItem;
for (var i = 0; i < ds_list_size(global.player.equippedItems); i++) {
	var item = ds_list_find_value(global.player.equippedItems,i);
	if item == selectedItem && item.equipmentSlot == slot {
		drawDark = true;
	}
}

if drawDark {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_gray,.75);
} else draw_sprite(spr_item_slot,1,xx,yy);