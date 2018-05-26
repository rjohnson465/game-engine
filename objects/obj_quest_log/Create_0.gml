ui = global.ui;
global.questLog = id;
width = (MENUS_BOTTOMRIGHT_X - MENUS_TOPLEFT_X)/2;
height = (MENUS_BOTTOMRIGHT_Y-MENUS_TOPLEFT_Y)-ui.menusHandleHeight-ui.menuTabsHeight;
handlesHeight = 20;

// entire quest log area
topLeftX = MENUS_TOPLEFT_X+width;
topLeftY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight;
bottomRightX = topLeftX+width;
bottomRightY = topLeftY +height;

// active quests pane
aqTopLeftX = topLeftX; aqTopLeftY = topLeftY;
aqBottomRightX = topLeftX+(width/2.5); aqBottomRightY = bottomRightY;

// scrollbar for active quests pane
scrollBarWidth = 20;//sprite_get_width(spr_scrollarrow);
scrollBarTopLeftX = aqBottomRightX-scrollBarWidth;
var sh = string_height("test");
scrollBarTopLeftY = aqTopLeftY+sh;
scrollBarBottomRightX = aqBottomRightX;
scrollBarBottomRightY = aqBottomRightY;
scrollLevel = 0;

// selected quest details pane
sqTopLeftX = aqBottomRightX; sqTopLeftY = aqTopLeftY;
sqBottomRightX = bottomRightX; sqBottomRightY = bottomRightY;

// selected quest reward pane
//var slotHeight = 
//rTopLeftX = sqTopLeftX; rTopLeftY = 

selectedQuest = noone;



