ui = global.ui;
global.questLog = id;
width = (MENUS_BOTTOMRIGHT_X - MENUS_TOPLEFT_X)/2;
height = (MENUS_BOTTOMRIGHT_Y-MENUS_TOPLEFT_Y);
handlesHeight = 20;

topLeftX = MENUS_TOPLEFT_X+width;
topLeftY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight;
bottomRightX = topLeftX+width;
bottomRightY = topLeftY +height;

// active quests pane
aqTopLeftX = topLeftX; aqTopLeftY = topLeftY;
aqBottomRightX = topLeftX+(width/2.5); aqBottomRightY = bottomRightY;

// selected quest details pane
sqTopLeftX = aqBottomRightX; sqTopLeftY = aqTopLeftY;
sqBottomRightX = bottomRightX; sqBottomRightY = bottomRightY;

// selected quest reward pane
//var slotHeight = 
//rTopLeftX = sqTopLeftX; rTopLeftY = 

selectedQuest = noone;

