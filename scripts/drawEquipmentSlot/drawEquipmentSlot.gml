/// drawEquipmentSlot(x,y)
/// @param x
/// @param y

var xx = argument0;
var yy = argument1;

var drawDark = false;
with obj_item_selector {
	if x1 == xx && y1 == yy && (isActive || type == SelectorTypes.Select) {
		drawDark = true;
	} 
}

if drawDark {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_gray,.75);
} else draw_sprite(spr_item_slot,1,xx,yy);