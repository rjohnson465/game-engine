ui = global.ui;
inventory = global.inventory;

topLeftX = inventory.topLeftX+inventory.width;
topLeftY = inventory.topLeftY;
width = inventory.width;
height = inventory.height;

titleHeight = 30;

// equipped items
global.x1 = 705;
global.y1 = 204;
global.equipmentSlot = EquipmentSlots.Head;
headItemSlot = instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);

global.x1 = 570;
global.y1 = 235;
global.equipmentSlot = EquipmentSlots.LeftHand1;
leftHandItem1Slot = instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);

global.x1 = 635;
global.y1 = 235;
global.equipmentSlot = EquipmentSlots.RightHand1;
rightHandItem1Slot = instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);

global.x1 = 602;
global.y1 = 300;
global.equipmentSlot = EquipmentSlots.LeftRing1;
leftRing1Slot = instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);

global.x1 = 602;
global.y1 = 365;
global.equipmentSlot = EquipmentSlots.LeftRing2;
leftRing2Slot = instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);

global.x1 = 775;
global.y1 = 235;
global.equipmentSlot = EquipmentSlots.LeftHand2;
leftHandItem2Slot = instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);

global.x1 = 840;
global.y1 = 235;
global.equipmentSlot = EquipmentSlots.RightHand2;
rightHandItem2Slot = instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);

global.x1 = 807;
global.y1 = 300;
global.equipmentSlot = EquipmentSlots.RightRing1;
rightRing1Slot = instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);

global.x1 = 807;
global.y1 = 365;
global.equipmentSlot = EquipmentSlots.RightRing2;
rightRing2Slot = instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);