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
	if item.count > 1 {
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		scr_draw_text_outline(x1+1,y1+1,item.count,c_white,c_white);
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