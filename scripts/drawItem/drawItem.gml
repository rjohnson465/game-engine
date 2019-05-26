/// drawItem(item,x,y,*isInventoryItem, *scale, *alpha, *showIfEquipped, *showIfHighlighted)
/// @param item
/// @param x
/// @param y
/// @param isInventoryItem*
/// @param scale*
/// @param alpha*
/// @param showIfEquipped* denotes whether or not to draw equipped background color
/// @param showIfHighlighted* denotes whether or not to draw the orange highlight under item, if item is highlighted

var item = argument[0];
var x1 = argument[1];
var y1 = argument[2];
var isInventoryItem = true;
if argument_count > 3 {
	isInventoryItem = argument[3];
}
var scale = 1;
if argument_count > 4 {
	scale = argument[4];
}
var alpha = 1;
if argument_count > 5 {
	alpha = argument[5];
}
var showIfEquipped = isInventoryItem;
if argument_count > 6 {
	showIfEquipped = argument[6];
}
var showIfHighlighted = true; 
if argument_count > 7 {
	showIfHighlighted = argument[7];
}

var p = global.player;
var inv = global.inventory;
var slotWidth = inv.slotWidth;
var slotHeight = inv.slotHeight;

// if equipped, draw equipped color background
if showIfEquipped && item.equipmentSlot != noone {
	draw_sprite_ext(spr_item_slot, 1, x1, y1, scale, scale, 0, C_HANDLES, alpha);
}

// if highlighted, draw the highlight / selection
if showIfHighlighted {
	var activeSelector = global.ui.moveSelector.isActive ? global.ui.moveSelector : global.ui.equipSelector;
	var isSelected = false; 
	if variable_instance_exists(id, "selectedItem") {
		isSelected = selectedItem == item;
	}
	var isActive2 = true;
	if variable_instance_exists(id, "isActive") {
		isActive2 = isActive;
	}
	// in trading situations, see both player selected item and vendor selected item with highlight
	if (object_index == obj_vendor_items || object_index == obj_player_items) {
		isActive2 = true;
	}
	if isSelected && isActive2 {
		var hlc = item.equipmentSlot != noone ? c_aqua : c_orange;
		draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,hlc,global.gameManager.selectedItemFilterAlpha);
	}
}

if item.object_index == obj_item_coins && ds_list_find_index(global.player.inventory,item) != -1 {
	draw_sprite_ext(spr_item_slot,1,x1,y1,scale,scale,0,c_dkgray,alpha);
}

if item.object_index == obj_item_health_flask {
	draw_sprite_ext(spr_item_health_flask_empty,1,x1,y1, scale, scale, 0, c_white, alpha);
	
	var charges = ds_map_find_value(item.customItemProperties, hfs_charges);
	var chargesMax = ds_map_find_value(item.customItemProperties, hfs_max_charges);
	var percentFull = charges / chargesMax;
	var sprWidth = sprite_get_width(spr_item_health_flask_empty);
	var sprHeight = sprite_get_height(spr_item_health_flask_empty);
	var pyOff = (sprHeight) * (1-percentFull);
	var newY1 = y1 + (pyOff * scale);
	
	draw_sprite_part_ext(spr_item_health_flask_full,1,0,pyOff,sprWidth,sprHeight,x1,newY1, scale, scale, c_white, alpha);
	// draw remaining charges
	if isInventoryItem || (p.beltItems[p.currentBeltItemIndex] == item && scale >= .6) && charges > 0 {
		draw_set_font(font_main);
		draw_set_halign(fa_left); draw_set_valign(fa_top);
		scr_draw_text_outline(x1, y1, charges, c_white, c_red);
	}
}
else {
	draw_sprite_ext(item.itemSprite,1,x1,y1, scale, scale, 0, c_white, alpha);
}
/*
// if this item is currently equipped, signify that (only for inventory items)
if item.equipmentSlot != noone && showIfEquipped {
	draw_set_color(c_maroon);
	draw_circle(x1+5,y1+5,5,false);
}
// if this item is currently equipped in the belt, signify that (only for inventory items)
if item.beltItemIndex >= 0 && showIfEquipped {
	draw_set_color(c_teal);
	draw_circle(x1+slotWidth-10,y1+5,5,false);
} */

// if this item is broken, signify that
if item.type == ItemTypes.HandItem && isInventoryItem {
	if item.durability <= 0 {
		draw_line_width_color(x1,y1,x1+10,y1+10,3,c_red,c_red);
		draw_line_width_color(x1+10,y1,x1,y1+10,3,c_red,c_red);
	}
}

// if item is stackable and has more than 1 in stack, show item count
if item.isStackable && (isInventoryItem || (p.beltItems[p.currentBeltItemIndex] == item && scale >= .6)) {
	draw_set_font(font_main);
	if item.count != 1 || item.object_index == obj_item_coins {
		draw_set_valign(fa_top); draw_set_halign(fa_left);
		if item.object_index == obj_item_coins {
			var s = noone;
			// never have more than four digits
			if item.count > 1000000 {
				s = item.count / 1000000;
				s = string_format(s,1,2);
				s += "m";
				var sWidth = string_width(s);
				var scale = 1;
				if sWidth > (slotWidth-2) {
					scale = (slotWidth-2) / sWidth;
				}
				scr_draw_text_outline(x1+1,y1+1,s,c_white,c_white,scale,scale,0,c_black);
			} else if item.count > 1000 {
				s = item.count / 1000;
				s = string_format(s,1,2);
				s += "k";
				var sWidth = string_width(s);
				var scale = 1;
				if sWidth > (slotWidth-2) {
					scale = (slotWidth-2) / sWidth;
				}
				scr_draw_text_outline(x1+1,y1+1,s,c_white,c_white,scale,scale,0,c_black);
			}
			else scr_draw_text_outline(x1+1,y1+1,item.count,c_white,c_white);
		} else {
			scr_draw_text_outline(x1+1,y1+1,item.count,c_white,c_white, 1, 1, 0, c_black);
		}
	}
}
// if this item is socketed, show sockets (and any gems that are in those sockets)
if item.numberOfSockets != 0 /*&& isInventoryItem*/ {
	var socketWidth = slotWidth/3; var socketHeight = slotWidth/3;
	for(var j = 0; j < item.numberOfSockets; j++) {
		draw_set_color(c_white);
		draw_circle(mean(x1+(socketWidth*j),x1+(socketWidth*j)+socketWidth),y1+(slotHeight-(.5*socketHeight)),socketWidth/2,true);
		if item.socketedGems {
			var gem = ds_list_find_value(item.socketedGems,j);
			if gem != undefined {
				var scale = socketWidth/slotWidth;
				var alpha = (inv.selectedItem == item || global.equippedItemsManager.selectedItem == item) ? .75 : .25;
				draw_sprite_ext(gem.itemSprite,1,x1+(socketWidth*j),y1+(slotHeight-socketHeight),scale,scale,0,c_white,alpha);
			}
		}
	}
}