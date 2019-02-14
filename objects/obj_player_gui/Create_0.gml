global.ui = id;
display_set_gui_size(1024, 768);
global.conditionBarCount = 0;
depth = -1000;

// controls lockOn rotation
alarm[0] = 60;

display_set_gui_size(view_get_wport(view_camera[0]),view_get_hport(view_camera[0]));

// UI menus
isShowingMenus = false;
#macro INVENTORY "Inventory & Stats"
#macro SKILLS "Skills & Quests"
//#macro STATS "Statistics"
#macro OPTIONS "Options"

var vw = view_get_wport(view_camera[0]);
var tlx = (vw-1000)/2;
var blx = tlx+1000;

menusWidth = 1000;
menusHeight = 500;

#macro MENUS_TOPLEFT_X (view_get_wport(view_camera[0])-1000)/2
#macro MENUS_TOPLEFT_Y 84
#macro MENUS_BOTTOMRIGHT_X ((view_get_wport(view_camera[0])-1000)/2)+1000
#macro MENUS_BOTTOMRIGHT_Y 584



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
}

currentMenu = INVENTORY;
isShowingMenus = false;

// attunment objects
var vh = view_get_hport(view_camera[0]);
global.y1 = vh-108; 
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
//instance_deactivate_object(obj_attunement);


// grabbing items
grabbedItem = noone;

// inventory
instance_create_depth(x,y,-1001,obj_inventory);

// equipped items
instance_create_depth(x,y,-1001,obj_equipped_items_manager);

// combos
//instance_create_depth(x,y,-100,obj_combo_manager);

// stats
instance_create_depth(x,y,-1001,obj_stats);

// skills
instance_create_depth(x,y,-1001,obj_skill_manager);

// quests
instance_create_depth(x,y,-1001,obj_quest_log);

// options manager
instance_create_depth(x,y,-1001,obj_options_manager);

// selected equipment slot
selectedEquipmentSlot = noone;

// selected inventory slot
selectedInventorySlot = noone;

enum SelectorTypes {
	Select,
	Equip,
	Imbue
}

// item selector
global.selectorType = SelectorTypes.Select;
moveSelector = instance_create_depth(x,y,1,obj_item_selector);

global.selectorType = SelectorTypes.Equip;
equipSelector = instance_create_depth(x,y,1,obj_item_selector);

global.selectorType = SelectorTypes.Imbue;
imbueSelector = instance_create_depth(x,y,1,obj_item_selector);

// skill selector
global.selectorType = SelectorTypes.Select;
skillSelector = instance_create_depth(x,y,1,obj_skill_selector);

// input prompt enums
// these are all mk values but can be translated to Xbox controller sprites in draw_prompt
enum Input {
	F, // A
	Backspace, // X
	Escape, // B
	LMB,
	RMB,
	MMB,
	Space,
	Shift, // Sel
	Mouse,
	LT,
	RT,
	LB,
	RB,
	PadUD,
	PadLR,
	Face4 // Y
}

isShowingExplanations = false;

// hud stuff
global.x1 = 1154; global.y1 = 10;
hudInventory = instance_create_depth(x,y,1,obj_hud_inventory);

global.x1 = 1196; global.y1 = 10;
hudSkills = instance_create_depth(x,y,1,obj_hud_skills);

global.x1 = 1238; global.y1 = 10;
hudOptions = instance_create_depth(x,y,1,obj_hud_options);

justClosedMenus = false;