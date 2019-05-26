global.fountainGui = id;
enum FountainOptions {
	InsertGem,
	BreakdownItem,
	LeaveFountain
}

#macro FOUNTAIN "Fountain"
#macro INSERTGEM "Insert Gem"
#macro BREAKDOWNITEM "Break Down Item"
#macro REPAIRITEM "Repair Item"
#macro LEAVEFOUNTAIN "Leave"

#macro CHOOSEITEM "Choose Item"
#macro CHOOSEGEM "Choose Gem"
#macro NAMEPRICE "Name Price"

selectedOption = INSERTGEM;
currentMenu = FOUNTAIN;
currentSubMenu = noone;

joystickInputFrame = 0;
joystickInputTotalFrames = 30;

// GUI stuff
menusHandleHeight = 20;
subMenuWidth = (MENUS_BOTTOMRIGHT_X-MENUS_TOPLEFT_X)/3;
subMenuTitleHeight = 30;

menuButtonCoordinates = ds_map_create();
menuOptions = ds_list_create();
ds_list_add(menuOptions,INSERTGEM);
ds_list_add(menuOptions,BREAKDOWNITEM);
ds_list_add(menuOptions,REPAIRITEM);
ds_list_add(menuOptions,LEAVEFOUNTAIN);


var closeButtonWidth = sprite_get_width(spr_close_button);
var closeButtonHeight = sprite_get_height(spr_close_button);
var closeButtonCoordinates = 
	[MENUS_BOTTOMRIGHT_X-closeButtonWidth,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_TOPLEFT_Y+closeButtonHeight];
ds_map_replace(menuButtonCoordinates,"closeButton",closeButtonCoordinates);

depth = -1001;
hasSetAlarm = false;
isAcceptingInput = true;

fountain = global.fountainForFountainGui;