if !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var leftHandItem2 = getItemInEquipmentSlot(EquipmentSlots.LeftHand2);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var rightHandItem2 = getItemInEquipmentSlot(EquipmentSlots.RightHand2);

var leftRing1 = getItemInEquipmentSlot(EquipmentSlots.LeftRing1);
var leftRing2 = getItemInEquipmentSlot(EquipmentSlots.LeftRing2);
var rightRing1 = getItemInEquipmentSlot(EquipmentSlots.RightRing1);
var rightRing2 = getItemInEquipmentSlot(EquipmentSlots.RightRing2);

var headItem = getItemInEquipmentSlot(EquipmentSlots.Head);

var b1 = getItemInEquipmentSlot(EquipmentSlots.BeltItem1);
var b2 = getItemInEquipmentSlot(EquipmentSlots.BeltItem2);
var b3 = getItemInEquipmentSlot(EquipmentSlots.BeltItem3);
var b4 = getItemInEquipmentSlot(EquipmentSlots.BeltItem4);
var b5 = getItemInEquipmentSlot(EquipmentSlots.BeltItem5);
			
// head slot
draw_set_font(font_main);
draw_text(headItemTextX, headItemTextY, "Hat");
drawEquipmentSlot(headItemSlotX, headItemSlotY, EquipmentSlots.Head);
if headItem {
	drawItem(headItem,headItemSlotX,headItemSlotY,1,1,1,0);
}

/*
// show gold in this pane too???
// gold?
draw_text(goldTextX, goldTextY, "Gold");
draw_set_color(c_black);
var sh = sprite_get_height(spr_item_coins);
var sys = 20 / sh;
draw_rectangle(goldBoxTopLeftX, goldBoxTopLeftY, goldBoxBottomRightX, goldBoxBottomRightY, 0);
draw_sprite_ext(spr_item_coins,1,goldBoxTopLeftX,goldBoxTopLeftY,sys,sys,0,c_white,1);
draw_set_color(c_white); draw_set_halign(fa_right); draw_set_valign(fa_center);
draw_text(goldBoxBottomRightX - 5, mean(goldBoxTopLeftY, goldBoxBottomRightY), getGoldCount());
*/

draw_set_halign(fa_left); draw_set_valign(fa_top);
// Hand Items 1
draw_text(handItems1TextX, handItems1TextY, "Weapons Set 1");

// left hand 1
drawEquipmentSlot(leftHandItem1SlotX,leftHandItem1SlotY, EquipmentSlots.LeftHand1);
if leftHandItem.spriteName != "unarmed" {
	drawItem(leftHandItem,leftHandItem1SlotX,leftHandItem1SlotY,1,1,1,0);
}

// right hand 1
drawEquipmentSlot(rightHandItem1SlotX,rightHandItem1SlotY, EquipmentSlots.RightHand1);
if rightHandItem.spriteName != "unarmed" {
	drawItem(rightHandItem,rightHandItem1SlotX,rightHandItem1SlotY,1,1,1,0);
}
if leftHandItem.isTwoHanded {
	draw_sprite_ext(leftHandItem.itemSprite,1,rightHandItem1SlotX,rightHandItem1SlotY,1,1,0,c_black,.75);
}


// Hand Items 2
draw_text(handItems2TextX, handItems2TextY, "Weapons Set 2");

// left hand 2
drawEquipmentSlot(leftHandItem2SlotX,leftHandItem2SlotY, EquipmentSlots.LeftHand2);
if leftHandItem2.spriteName != "unarmed" {
	drawItem(leftHandItem2,leftHandItem2SlotX,leftHandItem2SlotY,1,1,1,0);
}

// right hand 2
drawEquipmentSlot(rightHandItem2SlotX,rightHandItem2SlotY, EquipmentSlots.RightHand2);
if rightHandItem2.spriteName != "unarmed" {
	drawItem(rightHandItem2,rightHandItem2SlotX,rightHandItem2SlotY,1,1,1,0);
}
if leftHandItem2.isTwoHanded {
	draw_sprite_ext(leftHandItem2.itemSprite,1,rightHandItem2SlotX,rightHandItem2SlotY,1,1,0,c_black,.75);
}


// Rings
draw_text(ringsTextX, ringsTextY, "Rings");
// left ring 1 
drawEquipmentSlot(leftRing1SlotX,leftRing1SlotY, EquipmentSlots.LeftRing1);
if leftRing1 {
	drawItem(leftRing1,leftRing1SlotX,leftRing1SlotY,1,1,1,0);
}
// right ring 1 
drawEquipmentSlot(rightRing1SlotX,rightRing1SlotY, EquipmentSlots.RightRing1);
if rightRing1 {
	drawItem(rightRing1,rightRing1SlotX,rightRing1SlotY,1,1,1,0);
}
// left ring 2
drawEquipmentSlot(leftRing2SlotX,leftRing2SlotY, EquipmentSlots.LeftRing2);
if leftRing2 {
	drawItem(leftRing2,leftRing2SlotX,leftRing2SlotY,1,1,1,0);
}
// right ring 2
drawEquipmentSlot(rightRing2SlotX,rightRing2SlotY, EquipmentSlots.RightRing2);
if rightRing2 {
	drawItem(rightRing2,rightRing2SlotX,rightRing2SlotY,1,1,1,0);
}


// Belt 
draw_text(beltTextX, beltTextY, "Belt");

// belt item 1
drawEquipmentSlot(beltItem1SlotX, beltItem1SlotY, EquipmentSlots.BeltItem1);
if b1 {
	//drawItem(b1,beltItem1SlotX, beltItem1SlotY,1,1,1,0);
}
// belt item 2
drawEquipmentSlot(beltItem2SlotX, beltItem2SlotY, EquipmentSlots.BeltItem2);
if b2 {
	//drawItem(b2, beltItem2SlotX, beltItem2SlotY,1,1,1,0);
}
// belt item 3
drawEquipmentSlot(beltItem3SlotX, beltItem3SlotY, EquipmentSlots.BeltItem3);
if b3 {
	// drawItem(b3, beltItem3SlotX, beltItem3SlotX,1,1,1,0);
}
// belt item 4
drawEquipmentSlot(beltItem4SlotX, beltItem4SlotY, EquipmentSlots.BeltItem4);
if b4 {
	//drawItem(b4, beltItem4SlotX, beltItem4SlotX,1,1,1,0);
}
// belt item 5
drawEquipmentSlot(beltItem5SlotX, beltItem5SlotY, EquipmentSlots.BeltItem5);
if b5 {
	//drawItem(b5, beltItem5SlotX, beltItem5SlotX,1,1,1,0);
}

/*
// description box
draw_set_color(c_dkgray);
draw_rectangle(itemDescriptionTopLeftX,itemDescriptionTopLeftY,itemDescriptionBottomRightX,itemDescriptionBottomRightY,false);

draw_set_color(c_black);
draw_rectangle(itemDescriptionTopLeftX,itemDescriptionTopLeftY,itemDescriptionBottomRightX,itemDescriptionBottomRightY,1);
draw_line(bottomRightX,topLeftY,bottomRightX,bottomRightY);
draw_line(topLeftX,topLeftY,bottomRightX,topLeftY);

if selectedItem != noone && instance_exists(selectedItem) && selectedItem.equipmentSlot != noone {
	showItemInfo(itemDescriptionTopLeftX,itemDescriptionTopLeftY,selectedItem);
} else {
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(
		mean(itemDescriptionTopLeftX, itemDescriptionBottomRightX),
		mean(itemDescriptionTopLeftY, itemDescriptionBottomRightY),
		"No equipped item selected"
	);
}
