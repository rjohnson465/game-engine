ui = global.ui;
global.optionsManager = id;
width = (MENUS_BOTTOMRIGHT_X - MENUS_TOPLEFT_X);
height = (MENUS_BOTTOMRIGHT_Y-MENUS_TOPLEFT_Y)-ui.menusHandleHeight-ui.menuTabsHeight;
handlesHeight = 20;

// submenus
#macro SM_MAIN "Main"
#macro SM_SOUND "Sound Options"
#macro SM_DISPLAY "Display Options"
#macro SM_GAMEPLAY "Gameplay Options"

subMenu = SM_MAIN;

// options submenu navigators
#macro NAV_SAVEEXIT "Save and Exit"
#macro NAV_SOUND "Sound"
#macro NAV_DISPLAY "Display"
#macro NAV_GAMEPLAY "Gameplay"

navOptionsArr = [
	NAV_SOUND,
	NAV_DISPLAY,
	NAV_GAMEPLAY,
	NAV_SAVEEXIT
];
selectedOption = noone;

fade = noone;

#macro OPT_BACK "Back"

#macro OPT_D_ENEMYPOISE "Show Enemy Poise"
#macro OPT_D_PLAYERPOISE "Show Player Poise"
#macro OPT_D_TUTORIALS "Show Tutorial Messages"
#macro OPT_D_DAMAGENUMBERS "Show Damage Numbers"
#macro OPT_D_SMALLHEALTHBARS "Show Small Enemy Health Bars"
#macro OPT_D_FULLSCREEN "Fullscreen"

displayOptionsArr = [
	OPT_D_ENEMYPOISE,
	OPT_D_PLAYERPOISE,
	OPT_D_DAMAGENUMBERS,
	OPT_D_SMALLHEALTHBARS,
	OPT_D_TUTORIALS,
	OPT_D_FULLSCREEN,
	OPT_BACK
];

optionsMapDisplay = ds_map_create();
ds_map_replace(optionsMapDisplay, OPT_D_ENEMYPOISE, true);
ds_map_replace(optionsMapDisplay, OPT_D_PLAYERPOISE, true);
ds_map_replace(optionsMapDisplay, OPT_D_SMALLHEALTHBARS, true);
ds_map_replace(optionsMapDisplay, OPT_D_DAMAGENUMBERS, true);
ds_map_replace(optionsMapDisplay, OPT_D_TUTORIALS, true);
ds_map_replace(optionsMapDisplay, OPT_D_FULLSCREEN, window_get_fullscreen());

optionsMapSound = ds_map_create();

#macro OPT_G_DIFFICULTY "Difficulty"
gameplayOptionsArr = [
	OPT_G_DIFFICULTY,
	OPT_BACK
];

#macro OPT_DIFF_EASIEST "Daddy Can I Play?"
#macro OPT_DIFF_EASY "Casual Filth"
#macro OPT_DIFF_NORMAL "Fairy"
#macro OPT_DIFF_HARD "Unfairy"
#macro OPT_DIFF_HARDEST "Legenfairy"

difficultyOptionsArr = [
	OPT_DIFF_EASIEST,
	OPT_DIFF_EASY,
	OPT_DIFF_NORMAL,
	OPT_DIFF_HARD,
	OPT_DIFF_HARDEST
];

difficultyOptionsMap = ds_map_create();
ds_map_replace(difficultyOptionsMap, OPT_DIFF_EASIEST, "0x damage received, you goddamn child");
ds_map_replace(difficultyOptionsMap, OPT_DIFF_EASY, ".5x damage received, you coward");
ds_map_replace(difficultyOptionsMap, OPT_DIFF_NORMAL, "1x damage received, how the game is meant to be played");
ds_map_replace(difficultyOptionsMap, OPT_DIFF_HARD, "1.5x damage received, you are a hero");
ds_map_replace(difficultyOptionsMap, OPT_DIFF_HARDEST, "2x damage received, you are a masochist ;)");

optionsMapGameplay = ds_map_create();
ds_map_replace(optionsMapGameplay, OPT_G_DIFFICULTY, OPT_DIFF_NORMAL);

currentOptionsArr = navOptionsArr;