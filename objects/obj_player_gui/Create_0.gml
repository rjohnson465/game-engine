global.ui = id;
display_set_gui_size(1024, 768);
global.conditionBarCount = 0;
depth = -1000;

// UI menus
isShowingMenus = false;
#macro INVENTORY "Inventory & Stats"
#macro SKILLS "Skills & Quests"
//#macro STATS "Statistics"
#macro OPTIONS "Options"

#macro MENUS_TOPLEFT_X 12
#macro MENUS_TOPLEFT_Y 84
#macro MENUS_BOTTOMRIGHT_X 1012
#macro MENUS_BOTTOMRIGHT_Y 584

menusWidth = MENUS_BOTTOMRIGHT_X-MENUS_TOPLEFT_X;
menusHeight = MENUS_BOTTOMRIGHT_Y-MENUS_TOPLEFT_Y;

menuButtonCoordinates = ds_map_create();
var closeButtonWidth = sprite_get_width(spr_close_button);
var closeButtonHeight = sprite_get_height(spr_close_button);
var closeButtonCoordinates = 
	[MENUS_BOTTOMRIGHT_X-closeButtonWidth,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_TOPLEFT_Y+closeButtonHeight];
ds_map_replace(menuButtonCoordinates,"closeButton",closeButtonCoordinates);

// height for handle where menu name / hotkey is displayed
menusHandleHeight = 20;

// tabs
menuTabsHeight = 20;
menuTypes = [INVENTORY, SKILLS, OPTIONS];
menuHotKeys = ds_map_create();
ds_map_add(menuHotKeys,INVENTORY,"I");
ds_map_add(menuHotKeys,SKILLS,"K");
ds_map_add(menuHotKeys,OPTIONS,"O");

// get coordinate for tabs
var tabWidth = menusWidth / array_length_1d(menuTypes);
var xx = MENUS_TOPLEFT_X;
var yy = MENUS_TOPLEFT_Y+menusHandleHeight;
for (var i = 0; i < array_length_1d(menuTypes); i++) {
	var x1 = xx + (i*tabWidth);
	var el = menuTypes[i];
	var coordinates = [x1,yy,x1+tabWidth,yy+menuTabsHeight];
	ds_map_add(menuButtonCoordinates,el,coordinates);
	/*if currentMenu != el {
		draw_set_color(c_gray);
		draw_rectangle(x1,yy,x1+tabWidth,yy+menuTabsHeight,true);			
	} else {
		draw_set_color(c_ltgray);
		draw_rectangle(x1,yy,x1+tabWidth,yy+menuTabsHeight,true);
	}
	draw_text((x1+(x1+tabWidth))/2,((yy+menuTabsHeight)+yy)/2.15,el);*/
}

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

instance_deactivate_object(obj_menucategory);


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

// inventory
instance_create_depth(x,y,-1001,obj_inventory);

// combos
instance_create_depth(x,y,-100,obj_combo_manager);