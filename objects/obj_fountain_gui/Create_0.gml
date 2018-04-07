global.fountainGui = id;
enum FountainOptions {
	InsertGem,
	BreakdownItem
}

#macro FOUNTAIN "Fountain"
#macro INSERTGEM "Insert Gem"
#macro BREAKDOWNITEM "Break Down Item"

#macro CHOOSEITEM "Choose Item"
#macro CHOOSEGEM "Choose Gem"
#macro NAMEPRICE "Name Price"

selectedOption = FountainOptions.InsertGem;
currentMenu = FOUNTAIN;
currentSubMenu = noone;

// GUI stuff
menusHandleHeight = 20;
subMenuWidth = (MENUS_BOTTOMRIGHT_X-MENUS_TOPLEFT_X)/3;
subMenuTitleHeight = 30;

depth = -1000;
hasSetAlarm = false;