// if selector is over this equipmentSlot, draw it as dark gray
var xx = x1;
var yy = y1;
with obj_item_selector {
	if x1 == xx && y1 == yy {
		draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_gray,.75);
	}
}