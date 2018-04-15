global.fountainGui = id;
enum FountainOptions {
	InsertGem,
	BreakdownItem,
	LeaveFountain
}

#macro FOUNTAIN "Fountain"
#macro INSERTGEM "Insert Gem"
#macro BREAKDOWNITEM "Break Down Item"
#macro LEAVEFOUNTAIN "Leave"

#macro CHOOSEITEM "Choose Item"
#macro CHOOSEGEM "Choose Gem"
#macro NAMEPRICE "Name Price"

selectedOption = INSERTGEM;
currentMenu = FOUNTAIN;
currentSubMenu = noone;

// GUI stuff
menusHandleHeight = 20;
subMenuWidth = (MENUS_BOTTOMRIGHT_X-MENUS_TOPLEFT_X)/3;
subMenuTitleHeight = 30;

menuButtonCoordinates = ds_map_create();
var midW = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X); var midH = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y);
menuOptions = ds_list_create();
ds_list_add(menuOptions,INSERTGEM);
ds_list_add(menuOptions,BREAKDOWNITEM);
ds_list_add(menuOptions,LEAVEFOUNTAIN);
for (var i = 0; i < ds_list_size(menuOptions); i++) {
	var opt = ds_list_find_value(menuOptions,i);
	var w = string_width(opt); var h = string_height(opt);
	var yy = midH+((i)*25);
	var x1 = midW-(.5*w); var y1 = yy-(.5*h);
	var x2 = midW+w; var y2 = yy+h;
	ds_map_replace(menuButtonCoordinates,opt,[x1,y1,x2,y2]);
}

/*
var insertGemWidth = string_width(INSERTGEM); var insertGemHeight = string_height(INSERTGEM);
insertGemTopLeftX = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X)-(.5*insertGemWidth);
insertGemTopLeftY = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y)-(.5*insertGemHeight);
insertGemBottomRightX = insertGemTopLeftX+insertGemWidth;
insertGemBottomRightY = insertGemTopLeftY+insertGemHeight;
ds_map_replace(menuButtonCoordinates,INSERTGEM,[insertGemTopLeftX,insertGemTopLeftY,insertGemBottomRightX,insertGemBottomRightY])*/

depth = -1000;
hasSetAlarm = false;