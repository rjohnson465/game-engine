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

allEquipmentSlots = [headItemSlot,leftHandItem1Slot,leftHandItem2Slot,rightHandItem1Slot,rightHandItem2Slot,
					leftRing1Slot,leftRing2Slot,rightRing1Slot,rightRing2Slot];