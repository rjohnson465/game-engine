if !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

/*
var leftHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand1);
var leftHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand2);
var rightHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand1);
var rightHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand2);
*/

var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var leftHandItem2 = getItemInEquipmentSlot(EquipmentSlots.LeftHand2);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var rightHandItem2 = getItemInEquipmentSlot(EquipmentSlots.RightHand2);

// equipped items header
/*draw_set_color(c_gray);
draw_rectangle(topLeftX,topLeftY,topLeftX+width,topLeftY+titleHeight,false);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(mean(topLeftX,bottomRightX),topLeftY+10,"Equipped Items");*/
			
// head slot
draw_sprite(spr_item_slot,1,headItemSlotX,headItemSlotY);

// left hand 1
draw_sprite(spr_item_slot,1,leftHandItem1SlotX,leftHandItem2SlotY);
if leftHandItem != global.player.unarmed {
	draw_sprite(leftHandItem.itemSprite,1,leftHandItem1SlotX,leftHandItem2SlotY);
}
if rightHandItem.isTwoHanded {
	draw_sprite_ext(rightHandItem.itemSprite,1,leftHandItem1SlotX,leftHandItem2SlotY,1,1,0,c_black,.75);
}
draw_set_color(c_white);


// right hand 1
draw_sprite(spr_item_slot,1,rightHandItem1SlotX,rightHandItem1SlotY);
if rightHandItem != global.player.unarmed {
	draw_sprite(rightHandItem.itemSprite,1,rightHandItem1SlotX,rightHandItem1SlotY);
}
draw_text(rightHandItem1SlotX,leftHandItem2SlotY-15,"1");

// left ring 1 
draw_sprite(spr_item_slot,1,leftRing1SlotX,leftRing1SlotY);
// left ring 2
draw_sprite(spr_item_slot,1,leftRing2SlotX,leftRing2SlotY);

// left hand 2
draw_sprite(spr_item_slot,1,leftHandItem2SlotX,leftHandItem2SlotY);
if leftHandItem2 != global.player.unarmed {
	draw_sprite(leftHandItem2.itemSprite,1,leftHandItem2SlotX,leftHandItem2SlotY);
}
if rightHandItem2.isTwoHanded {
	draw_sprite_ext(rightHandItem2.itemSprite,1,leftHandItem2SlotX,leftHandItem2SlotY,1,1,0,c_black,.75);
}
//draw_text(leftHandItem2SlotX,leftHandItem2SlotY-10,"2");

// right hand 2
draw_sprite(spr_item_slot,1,rightHandItem2SlotX,rightHandItem2SlotY);
if rightHandItem2 != global.player.unarmed {
	draw_sprite(rightHandItem2.itemSprite,1,rightHandItem2SlotX,rightHandItem2SlotY);
}
draw_text(rightHandItem2SlotX,rightHandItem2SlotY-15,"2");

// right ring 1 
draw_sprite(spr_item_slot,1,rightRing1SlotX,rightRing1SlotY);
// right ring 2
draw_sprite(spr_item_slot,1,rightRing2SlotX,rightRing2SlotY);

// description box
draw_set_color(c_dkgray);
draw_rectangle(itemDescriptionTopLeftX,itemDescriptionTopLeftY,itemDescriptionBottomRightX,itemDescriptionBottomRightY,false);