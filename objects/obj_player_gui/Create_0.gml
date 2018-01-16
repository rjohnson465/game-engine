global.ui = id;
display_set_gui_size(1024, 768);
global.conditionBarCount = 0;
depth = -1000;

// UI menus
isShowingMenus = false;
#macro INVENTORY "Inventory"
#macro SKILLS "Skills"
#macro STATS "Statistics"
#macro OPTIONS "Options"
menuTypes = [INVENTORY, SKILLS, STATS, OPTIONS];
menuHotKeys = ds_map_create();
ds_map_add(menuHotKeys,INVENTORY,"I");
ds_map_add(menuHotKeys,SKILLS,"K");
ds_map_add(menuHotKeys,STATS,"T");
ds_map_add(menuHotKeys,OPTIONS,"O");

currentMenu = INVENTORY;
isShowingMenus = false;

// attunment objects
global.y1 = 660; 
global.x1 = 12; // used for attunement instance creation
global.spellAttunementString = MAGIC;
attunementMagic = instance_create_depth(12,660,1,obj_attunement);

global.x1 = 52; // used for attunement instance creation
global.spellAttunementString = FIRE;
attunementFire = instance_create_depth(12,660,1,obj_attunement);

global.x1 = 92; // used for attunement instance creation
global.spellAttunementString = ICE;
attunementIce = instance_create_depth(12,660,1,obj_attunement);

global.x1 = 132; // used for attunement instance creation
global.spellAttunementString = POISON;
attunementPoison = instance_create_depth(12,660,1,obj_attunement);

global.x1 = 172; // used for attunement instance creation
global.spellAttunementString = LIGHTNING;
attunementLightning = instance_create_depth(12,660,1,obj_attunement);

// not active until visible
instance_deactivate_object(obj_attunement);

// menu categories objects
global.x1 = 112;

var init_y = 154;
for (var i = 0; i < array_length_1d(menuTypes); i++) {
	global.y1 = init_y + (i*120);
	global.menuType = menuTypes[i];
	instance_create_depth(global.x1,global.y1,1,obj_menucategory);
}

instance_deactivate_object(obj_menucategory);

// inventory specific stuff
enum InventoryFilters {
	None,
	Melee,
	Magic,
	Ranged,
	Shields,
	Other
}

inventoryFilter = InventoryFilters.None;
inventoryScrollLevel = 0; // display items 0 - 14
inventorySelectedItem = noone;
global.scrollDirection = "up";
global.x1 = 532;
global.y1 = 214;
instance_create_depth(320,184,1,obj_inventoryscroll);

global.scrollDirection = "down";
global.x1 = 532;
global.y1 = 410;
instance_create_depth(320,184,1,obj_inventoryscroll);
instance_deactivate_object(obj_inventoryscroll);

// grabbing items
grabbedItem = noone;

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