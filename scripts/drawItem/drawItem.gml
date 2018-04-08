/// drawItem(item,x,y)
/// @param item
/// @param x
/// @param y

var item = argument[0];
var x1 = argument[1];
var y1 = argument[2];
var inv = global.inventory;
var slotWidth = inv.slotWidth;
var slotHeight = inv.slotHeight;

if item.object_index == obj_item_coins && ds_list_find_index(global.player.inventory,item) != -1 {
	draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_dkgray,1);
}

draw_sprite(item.itemSprite,1,x1,y1);
// if this item is currently equipped, signify that (only for inventory items)
if item.equipmentSlot != noone && item.copyOf == noone {
	draw_set_color(c_maroon);
	draw_circle(x1+5,y1+5,5,false);
}
// if this item is broken, signify that
if item.type == ItemTypes.HandItem {
	if item.durability <= 0 {
		draw_line_width_color(x1,y1,x1+10,y1+10,3,c_red,c_red);
		draw_line_width_color(x1+10,y1,x1,y1+10,3,c_red,c_red);
	}
}
// if item is stackable and has more than 1 in stack, show item count
if item.isStackable {
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
			scr_draw_text_outline(x1+1,y1+1,item.count,c_white,c_white);
		}
	}
}
// if this item is socketed, show sockets (and any gems that are in those sockets)
if item.numberOfSockets != 0 {
	var socketWidth = slotWidth/3; var socketHeight = slotWidth/3;
	for(var j = 0; j < item.numberOfSockets; j++) {
		draw_set_color(c_white);
		draw_circle(mean(x1+(socketWidth*j),x1+(socketWidth*j)+socketWidth),y1+(slotHeight-(.5*socketHeight)),socketWidth/2,true);
		var gem = ds_list_find_value(item.socketedGems,j);
		if gem != undefined {
			var scale = socketWidth/slotWidth;
			var alpha = (inv.selectedItem == item || global.equippedItemsManager.selectedItem == item) ? .75 : .25;
			draw_sprite_ext(gem.itemSprite,1,x1+(socketWidth*j),y1+(slotHeight-socketHeight),scale,scale,0,c_white,alpha);
		}
	}
}