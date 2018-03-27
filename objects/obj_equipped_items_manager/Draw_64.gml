if !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var leftHandItem2 = getItemInEquipmentSlot(EquipmentSlots.LeftHand2);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var rightHandItem2 = getItemInEquipmentSlot(EquipmentSlots.RightHand2);

var leftRing1 = getItemInEquipmentSlot(EquipmentSlots.LeftRing1);
var leftRing2 = getItemInEquipmentSlot(EquipmentSlots.LeftRing2);
var rightRing1 = getItemInEquipmentSlot(EquipmentSlots.RightRing1);
var rightRing2 = getItemInEquipmentSlot(EquipmentSlots.RightRing2);
			
// head slot
drawEquipmentSlot(headItemSlotX, headItemSlotY, EquipmentSlots.Head);

// left hand 1
drawEquipmentSlot(leftHandItem1SlotX,leftHandItem1SlotY, EquipmentSlots.LeftHand1);
if leftHandItem.spriteName != "unarmed" {
	draw_sprite(leftHandItem.itemSprite,1,leftHandItem1SlotX,leftHandItem2SlotY);
}

draw_set_color(c_white);


// right hand 1
drawEquipmentSlot(rightHandItem1SlotX,rightHandItem1SlotY, EquipmentSlots.RightHand1);
if rightHandItem.spriteName != "unarmed" {
	draw_sprite(rightHandItem.itemSprite,1,rightHandItem1SlotX,rightHandItem1SlotY);
}
if leftHandItem.isTwoHanded {
	draw_sprite_ext(leftHandItem.itemSprite,1,rightHandItem1SlotX,rightHandItem1SlotY,1,1,0,c_black,.75);
}
draw_text(rightHandItem1SlotX,leftHandItem2SlotY-15,"1");

// left ring 1 
drawEquipmentSlot(leftRing1SlotX,leftRing1SlotY, EquipmentSlots.LeftRing1);
if leftRing1 {
	draw_sprite(leftRing1.itemSprite,1,leftRing1SlotX,leftRing1SlotY);
}
// left ring 2
drawEquipmentSlot(leftRing2SlotX,leftRing2SlotY, EquipmentSlots.LeftRing2);
if leftRing2 {
	draw_sprite(leftRing2.itemSprite,1,leftRing2SlotX,leftRing2SlotY);
}

// left hand 2
drawEquipmentSlot(leftHandItem2SlotX,leftHandItem2SlotY, EquipmentSlots.LeftHand2);
if leftHandItem2.spriteName != "unarmed" {
	draw_sprite(leftHandItem2.itemSprite,1,leftHandItem2SlotX,leftHandItem2SlotY);
}

// right hand 2
drawEquipmentSlot(rightHandItem2SlotX,rightHandItem2SlotY, EquipmentSlots.RightHand2);
if rightHandItem2.spriteName != "unarmed" {
	draw_sprite(rightHandItem2.itemSprite,1,rightHandItem2SlotX,rightHandItem2SlotY);
}
if leftHandItem2.isTwoHanded {
	draw_sprite_ext(leftHandItem2.itemSprite,1,rightHandItem2SlotX,rightHandItem2SlotY,1,1,0,c_black,.75);
}
draw_text(rightHandItem2SlotX,rightHandItem2SlotY-15,"2");

// right ring 1 
drawEquipmentSlot(rightRing1SlotX,rightRing1SlotY, EquipmentSlots.RightRing1);
if rightRing1 {
	draw_sprite(rightRing1.itemSprite,1,rightRing1SlotX,rightRing1SlotY);
}
// right ring 2
drawEquipmentSlot(rightRing2SlotX,rightRing2SlotY, EquipmentSlots.RightRing2);
if rightRing2 {
	draw_sprite(rightRing2.itemSprite,1,rightRing2SlotX,rightRing2SlotY);
}
// description box
draw_set_color(c_dkgray);
draw_rectangle(itemDescriptionTopLeftX,itemDescriptionTopLeftY,itemDescriptionBottomRightX,itemDescriptionBottomRightY,false);

if selectedItem != noone {
	showItemInfo(itemDescriptionTopLeftX,itemDescriptionTopLeftY,selectedItem);
}
