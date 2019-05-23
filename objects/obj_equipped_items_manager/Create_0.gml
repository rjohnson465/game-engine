ui = global.ui;
inventory = global.inventory;
global.equippedItemsManager = id;

topLeftX = inventory.topLeftX+inventory.width;
topLeftY = inventory.topLeftY;
width = inventory.width;
height = inventory.height;
bottomRightX = topLeftX + width;
bottomRightY = topLeftY + height;

titleHeight = 0;

eqHeight = inventory.invHeight;

// New Layout
var eil = topLeftX + 5;
var eit = 125;
draw_set_font(font_main);
var sh = string_height("s");
var sw = sprite_get_width(spr_item_slot);

// hat 
headItemTextX = eil;
headItemTextY = eit;
headItemSlotX = eil;
headItemSlotY = eit+sh;

// hand items 1
handItems1TextX = eil;
handItems1TextY = headItemSlotY + sw;
leftHandItem1SlotX = eil;
leftHandItem1SlotY = handItems1TextY + sh;
rightHandItem1SlotX = eil+sw;
rightHandItem1SlotY = leftHandItem1SlotY;

// hand items 2
handItems2TextX = eil;
handItems2TextY = leftHandItem1SlotY + sw;
leftHandItem2SlotX = eil;
leftHandItem2SlotY = handItems2TextY+sh;
rightHandItem2SlotX = eil+sw;
rightHandItem2SlotY = leftHandItem2SlotY;

// rings
ringsTextX = eil;
ringsTextY = leftHandItem2SlotY + sw;
leftRing1SlotX = eil;
leftRing1SlotY = ringsTextY + sh;
rightRing1SlotX = leftRing1SlotX+sw;
rightRing1SlotY = leftRing1SlotY;

leftRing2SlotX = rightRing1SlotX + sw;
leftRing2SlotY = leftRing1SlotY;
rightRing2SlotX = leftRing2SlotX + sw;
rightRing2SlotY = leftRing1SlotY;

// Belt
beltTextX = eil;
beltTextY = leftRing1SlotY + sw;
beltItem1SlotX = eil;
beltItem1SlotY = beltTextY + sh;
beltItem2SlotX = beltItem1SlotX + sw;
beltItem2SlotY = beltItem1SlotY;
beltItem3SlotX = beltItem2SlotX + sw;
beltItem3SlotY = beltItem1SlotY;
beltItem4SlotX = beltItem3SlotX + sw;
beltItem4SlotY = beltItem1SlotY;
beltItem5SlotX = beltItem4SlotX + sw;
beltItem5SlotY = beltItem1SlotY;

/*
helperTextX = mean(headItemSlotX, topLeftX+width);
helperTextY = topLeftY + 5;


headItemSlotX = topLeftX+135;
headItemSlotY = 125;

leftHandItem1SlotX = topLeftX+3;
leftHandItem1SlotY = 185;
rightHandItem1SlotX = topLeftX+68;
rightHandItem1SlotY = 185;

leftHandItem2SlotX = topLeftX+202;
leftHandItem2SlotY = 185;
rightHandItem2SlotX = topLeftX+267;
rightHandItem2SlotY = 185;

leftRing1SlotX = topLeftX+35;
leftRing1SlotY = 250;
leftRing2SlotX = topLeftX+35;
leftRing2SlotY = 315;

rightRing1SlotX = topLeftX+234;
rightRing1SlotY = 250;
rightRing2SlotX = topLeftX+234;
rightRing2SlotY = 315;

*/

// description box
itemDescriptionTopLeftX = topLeftX;
itemDescriptionTopLeftY = topLeftY+30+eqHeight;
itemDescriptionBottomRightX = topLeftX+width;
itemDescriptionBottomRightY = MENUS_BOTTOMRIGHT_Y;

itemDescriptionHandleHeight = 20;
itemDescriptionCol1XPictures = itemDescriptionTopLeftX+1;
itemDescriptionCol1XText = itemDescriptionCol1XPictures + 20;
itemDescriptionCol1Width = (.5*width)+70;
itemDescriptionCol2XPictures = itemDescriptionTopLeftX+itemDescriptionCol1Width;
itemDescriptionCol2XText = itemDescriptionCol2XPictures + 20;
itemDescriptionColY = itemDescriptionTopLeftY+itemDescriptionHandleHeight;

selectedItem = noone;

headItemSlot = makeEquipmentSlot(EquipmentSlots.Head,headItemSlotX,headItemSlotY);

leftHandItem1Slot = makeEquipmentSlot(EquipmentSlots.LeftHand1,leftHandItem1SlotX,leftHandItem1SlotY);
rightHandItem1Slot = makeEquipmentSlot(EquipmentSlots.RightHand1,rightHandItem1SlotX,rightHandItem1SlotY);

leftHandItem2Slot = makeEquipmentSlot(EquipmentSlots.LeftHand2,leftHandItem2SlotX,leftHandItem2SlotY);
rightHandItem2Slot = makeEquipmentSlot(EquipmentSlots.RightHand2,rightHandItem2SlotX,rightHandItem2SlotY);

leftRing1Slot = makeEquipmentSlot(EquipmentSlots.LeftRing1,leftRing1SlotX,leftRing1SlotY);
leftRing2Slot = makeEquipmentSlot(EquipmentSlots.LeftRing2,leftRing2SlotX,leftRing2SlotY);

rightRing1Slot = makeEquipmentSlot(EquipmentSlots.RightRing1,rightRing1SlotX,rightRing1SlotY);
rightRing2Slot = makeEquipmentSlot(EquipmentSlots.RightRing2,rightRing2SlotX,rightRing2SlotY);

beltItem1Slot = makeEquipmentSlot(EquipmentSlots.BeltItem1, beltItem1SlotX, beltItem1SlotY);
beltItem2Slot = makeEquipmentSlot(EquipmentSlots.BeltItem2, beltItem2SlotX, beltItem2SlotY);
beltItem3Slot = makeEquipmentSlot(EquipmentSlots.BeltItem3, beltItem3SlotX, beltItem3SlotY);
beltItem4Slot = makeEquipmentSlot(EquipmentSlots.BeltItem4, beltItem4SlotX, beltItem4SlotY);
beltItem5Slot = makeEquipmentSlot(EquipmentSlots.BeltItem5, beltItem5SlotX, beltItem5SlotY);

selectedItemFilterAlpha = .75;
selectedItemFilterAlphaFrame = 60;