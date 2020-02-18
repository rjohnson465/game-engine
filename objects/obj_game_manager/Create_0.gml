var n = instance_number(object_index);

if instance_number(object_index) > 1 {
	instance_destroy(id,0);
	exit;
}

// window_set_fullscreen(true);

defineItemPropertyRangesForPts();
fs_clear_enemydata_tempfile(); fs_clear_roomdata_tempfile();
display_set_gui_size(view_get_wport(view_camera[0]),view_get_hport(view_camera[0]));
global.gameManager = id;
// use macros for elements rather than enums (helps with sprite getting)
#macro PHYSICAL "physical"
#macro SLASH "slash"
#macro PIERCE "pierce"
#macro CRUSH "crush"
#macro MAGIC "magic"
#macro FIRE "fire"
#macro ICE "ice"
#macro POISON "poison"
#macro LIGHTNING "lightning"

#macro C_HANDLES make_color_rgb(47,79,79)
#macro C_DKRGRAY make_color_rgb(42,42,42)
#macro C_FIRELIGHT make_color_rgb(255,178,102)
#macro C_GOLD make_color_rgb(255, 215, 0)
#macro C_HIGHLIGHT c_orange // might change later
#macro C_POISE make_color_rgb(255, 201, 40)

// input sprites
#macro IS_LT spr_prompt_xbox_lb 
#macro IS_RT spr_prompt_xbox_rb
#macro IS_LB spr_prompt_xbox_lt
#macro IS_RB spr_prompt_xbox_rt

#macro C_RARITY_NORMAL c_white
#macro C_RARITY_FINE c_lime
#macro C_RARITY_MASTERWORK c_aqua
#macro C_RARITY_LEGENDARY c_fuchsia
global.itemRarityColors = ds_map_create();
ds_map_replace(global.itemRarityColors, ItemRarities.Normal, C_RARITY_NORMAL);
ds_map_replace(global.itemRarityColors, ItemRarities.Fine, C_RARITY_FINE);
ds_map_replace(global.itemRarityColors, ItemRarities.Masterwork, C_RARITY_MASTERWORK);
ds_map_replace(global.itemRarityColors, ItemRarities.Legendary, C_RARITY_LEGENDARY);

global.weaponParticlesMap = defineWeaponParticles();

global.ALL_ELEMENTS = [MAGIC,FIRE,ICE,POISON,LIGHTNING];
global.ALL_DAMAGE_TYPES = [PHYSICAL,SLASH,PIERCE,CRUSH,MAGIC,FIRE,ICE,POISON,LIGHTNING];
global.ALL_PHYSICAL_DAMAGE_TYPES = [PHYSICAL,SLASH,PIERCE,CRUSH];

global.isTutorialInProgress = false;

#macro SWORD1H "Sword/1H"
#macro SWORD2H "Sword/2H"
#macro DAGGER "Dagger/1H"
#macro UNARMED "Unarmed"
#macro AXE1H "Axe/1H"
#macro AXE2H "Axe/2H"
#macro BLUNT1H "Club/1H"
#macro BLUNT2H "Club/2H"
#macro RAPIER "Rapier/1H"
#macro SPEAR "Spear/2H"
#macro BOW "Bow/2H"
#macro CROSSBOW "Crossbow/1H"
#macro SHURIKEN "Shuriken/2H"
#macro MUSKET "Musket/2H"
#macro THROWN "Thrown/1H"
#macro PISTOL "Pistol/1H"

#macro MATH_E 2.71828
if !variable_global_exists("gamePadIndex") {
	global.gamePadIndex = noone;
} else {
	if instance_exists(global.player) {
		global.player.gamePadIndex = global.gamePadIndex;
	}
}

global.playerDoNothing = false;
if room == game_menu {
	global.playerDoNothing = true;
}
global.populateInventory = true;

global.ALL_WEAPON_TYPES = [
	SWORD1H, SWORD2H, DAGGER, UNARMED, AXE1H, AXE2H, BLUNT1H, BLUNT2H, RAPIER, SPEAR,
	BOW, CROSSBOW, SHURIKEN, MUSKET, THROWN, PISTOL
];

depth = -1000;


global._light_layers = ds_map_create();
global._light_color = c_black;

global.gameEnding = false;

enum TitleScreenState {
	Options,
	Load,
	New
}

// all entries must be in order
// this allows for numerical comparison (higher value enums = later in the story)
enum NarrativeState {
	Start,
	LamplightFactory,
	WinterWonderground
}

options = ["New Game", "Load Game", "Exit"];

selectedOption = noone;

state = TitleScreenState.Options;
isLoading = false;
currentSaveFile = noone;
//currentSaveFile = "Game"; // only for load test purposes, should be noone
fs_clear_roomdata_tempfile();
#macro TEMP_ROOMDATA_FILENAME "TempRoomData.sav"
#macro TEMP_ENEMYDATA_FILENAME "TempEnemyData.sav"

//currentSaveFile = "Game.sav";
roomToGoTo = noone;
isReadyToMoveRooms = false;
newGameName = "";
isConfirmingDestroySaveFile = false;
confirmDestroyOption = "N";
cursorPos = 1;

var vw = view_get_wport(view_camera[0]);
var vh = view_get_hport(view_camera[0]);

// load screen
selectedFile = noone;

loadBoxTopLeftX = vw/4;
loadBoxTopLeftY = 200;
loadBoxBottomRightX = (3*vw)/4;
loadBoxBottomRightY = 450;
loadBoxWidth = loadBoxBottomRightX - loadBoxTopLeftX;

scrollSpriteWidth = sprite_get_width(spr_scrollarrow);
scrollSpriteHeight = sprite_get_height(spr_scrollarrow);
scrollBarWidth = 20;

scrollBarTopLeftX = loadBoxBottomRightX-scrollBarWidth;
scrollBarTopLeftY = loadBoxTopLeftY;
scrollBarBottomRightX = loadBoxBottomRightX;
scrollBarBottomRightY = loadBoxBottomRightY;

scrollButtonUpTopLeftX = scrollBarBottomRightX-scrollBarWidth;
scrollButtonUpTopLeftY = scrollBarTopLeftY;
scrollButtonUpBottomRightX = scrollBarBottomRightX;
scrollButtonUpBottomRightY = scrollBarTopLeftY+scrollBarWidth;

scrollButtonDownTopLeftX = scrollButtonUpTopLeftX;
scrollButtonDownTopLeftY = scrollBarBottomRightY-scrollBarWidth;
scrollButtonDownBottomRightX = scrollBarBottomRightX;
scrollButtonDownBottomRightY = scrollBarBottomRightY;

scrollLevel = 0; // for load files

joystickInputFrame = 0;
joystickInputTotalFrames = 30;

fade = noone;

audio_falloff_set_model(audio_falloff_linear_distance); 
#macro AUDIO_MAX_FALLOFF_DIST 1000
defineItemsByAct();
defineItemPropertyPrefixes();
definePropertiesByRarity();

// create room data object
//currentRoomData = instance_create_depth(x,y,1,obj_room_data);
currentRoomData = noone;

enviroParticlesController = instance_create_depth(x,y,depth,obj_environment_particles_controller);

ambEmitter = audio_emitter_create();
audio_emitter_falloff(ambEmitter, audio_falloff_none,1,1);
ambCurrent = noone;

// stores info on periodical amb sounds (what they are, how often to maybe play them, chance to play them, length to play them
ambPeriodicalsMap = ds_map_create();
ambpFrames = ds_map_create(); // keys are snd ids
ambpEmitters = ds_map_create();
ambpFrameStarts = ds_map_create();
ambSoundIndexes = ds_list_create();

global.doNotDisplayTutorialMessages = false;
alarm[3] = 5;

waterManager = instance_create_depth(x,y,1,obj_water_manager);
//roofsManager = instance_create_depth(x,y,1,obj_roofs_manager);

cell_width = 32;//bbox_right-bbox_left;
cell_height = 32; //bbox_bottom-bbox_top;
global.grids = ds_map_create();
global.isPopulatingGrids = false;
hasReactivatedObjectsForGrids = false;

global.isUpdatingRoomLayers = false;
hasReactivatedObjectsForLayers = false;

global.respawnEnemiesAfterGridsPopulate = false;
global.activateAll = false;
global.isReturningToMainMenu = false;

bgmManager = instance_create_depth(x,y,1,obj_bgm_manager);

// events
#macro EV_ENEMY_KILLED "EnemyKilled"
#macro EV_ITEM_PICKEDUP "ItemPickedUp"
#macro EV_QUEST_COMPLETED "QuestCompleted"
#macro EV_DAMAGE_TAKEN "DamageTaken"
#macro EV_FOUNTAIN_WISH "FountainWish"
#macro EV_DARK_FOUNTAIN_WISH "DarkFountainWish"

// eventManager = instance_create_depth(x, y, 1, obj_event_manager);

isMouseOverBelt = false;

// every x steps, deactivate solid enviornment objects that are far away out of the view
#macro DEACTIVATION_STEPS_DEFAULT 15;
deactivationSteps = DEACTIVATION_STEPS_DEFAULT;
deactivationBorder = 200;
alarm[5] = deactivationSteps;

persistent = true;

selectedItemFilterAlpha = .75;
selectedItemFilterAlphaFrame = 60;