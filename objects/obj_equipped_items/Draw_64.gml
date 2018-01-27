if !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;


var leftHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand1);
var leftHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand2);
var rightHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand1);
var rightHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand2);

// equipped items side
draw_set_color(c_gray);
draw_rectangle(topLeftX,topLeftY,topLeftX+width,topLeftY+titleHeight,false);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(737,164,"Equipped Items");
			
// head slot
draw_sprite(spr_item_slot,1,705,204);
// left hand 1
draw_sprite(spr_item_slot,1,570,235);
if leftHandItem != global.player.unarmed {
	draw_sprite(leftHandItem.itemSprite,1,570,235);
}
if rightHandItem.isTwoHanded {
	draw_sprite_ext(rightHandItem.itemSprite,1,570,235,1,1,0,c_black,.75);
}
draw_text(570,225,"1");
// left hand 2
draw_sprite(spr_item_slot,1,635,235);
if rightHandItem != global.player.unarmed {
	draw_sprite(rightHandItem.itemSprite,1,635,235);
}
/*if rightHandItem2.isTwoHanded {
	draw_sprite_ext(rightHandItem2.itemSprite,1,635,235,1,1,0,c_black,.75);
}*/
draw_text(635,225,"1");
// left ring 1 
draw_sprite(spr_item_slot,1,602,300);
// left ring 2
draw_sprite(spr_item_slot,1,602,365);
// right hand 1
draw_sprite(spr_item_slot,1,775,235);
if leftHandItem2 != global.player.unarmed {
	draw_sprite(leftHandItem2.itemSprite,1,775,235);
}
if rightHandItem2.isTwoHanded {
	draw_sprite_ext(rightHandItem2.itemSprite,1,775,235,1,1,0,c_black,.75);
}
draw_text(775,225,"2");
// right hand 2
draw_sprite(spr_item_slot,1,840,235);
if rightHandItem2 != global.player.unarmed {
	draw_sprite(rightHandItem2.itemSprite,1,840,235);
}
draw_text(840,225,"2");
// right ring 1 
draw_sprite(spr_item_slot,1,807,300);
// right ring 2
draw_sprite(spr_item_slot,1,807,365);